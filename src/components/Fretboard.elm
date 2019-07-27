module Fretboard exposing (render)

import Game exposing (GameMode(..))
import Guitar
import GuitarChord exposing (chordQualityIntervals)
import Html exposing (Html, button, div, h1, img, input, label, span, text)
import Html.Attributes exposing (checked, class, classList, src, style, type_)
import Html.Events exposing (onCheck, onClick)
import Interval
    exposing
        ( Interval(..)
        , addInterval
        , distance
        , fifthIntervals
        , fourthIntervals
        , rootIntervals
        , secondIntervals
        , seventhIntervals
        , sixthIntervals
        , thirdIntervals
        )
import List.Extra exposing (getAt)
import Maybe exposing (withDefault)
import Model exposing (Model)
import Msg exposing (Msg(..))
import Music exposing (toTone)
import Note exposing (Note)
import Tone exposing (Tone, toneToIndex)


fretCount =
    12


stringCount =
    Guitar.guitarStrings
        |> List.length


isChordTone : Maybe Tone -> List Interval -> List (Maybe Interval) -> Int -> Int -> Bool
isChordTone rootTone expectedIntervals chordStringIntervals stringNum fretNum =
    let
        stringInterval =
            case getAt (stringCount - stringNum) chordStringIntervals of
                Just a ->
                    a

                _ ->
                    Nothing

        rootNote =
            case ( stringInterval, rootTone ) of
                ( Just _, Just tone ) ->
                    Just { tone = tone, octave = 1 }

                _ ->
                    Nothing

        chordNote =
            case ( rootNote, stringInterval ) of
                ( Just rn, Just sivl ) ->
                    Just (addInterval rn sivl)

                _ ->
                    Nothing

        ( guitarNote, _ ) =
            Guitar.getGuitarNoteWithPitch stringNum fretNum

        stringTone =
            toTone guitarNote
    in
    case ( stringTone, chordNote ) of
        ( Just guitarTone, Just note ) ->
            let
                chordTone =
                    note.tone

                isInterval =
                    case stringInterval of
                        Just interval ->
                            List.member interval expectedIntervals

                        Nothing ->
                            False

                retval =
                    isInterval && toneToIndex guitarTone == toneToIndex chordTone
            in
            retval

        _ ->
            False


isSelected : Model -> Int -> Int -> Bool
isSelected model stringNum fretNum =
    let
        selectedGuitarNote =
            model.selectedGuitarNote

        selectedFretNum =
            selectedGuitarNote.fretNum

        selectedStringNum =
            selectedGuitarNote.stringNum
    in
    selectedStringNum == stringNum && selectedFretNum == fretNum


isOctave : Model -> Int -> Int -> Bool
isOctave model stringNum fretNum =
    model.showOctaves
        && List.any
            (\note -> note.stringNum == stringNum && note.fretNum == fretNum)
            model.selectedGuitarNoteOctaves


isChordMode model =
    model.gameMode == GuessChord || model.gameMode == ShowChord


noteClassList : Model -> Int -> Int -> List ( String, Bool )
noteClassList model stringNum fretNum =
    let
        chordMode =
            isChordMode model

        chordIntervals =
            case model.gameMode of
                GuessChord ->
                    case model.guessChordGame.answer of
                        Nothing ->
                            Nothing

                        Just answer ->
                            Just
                                (chordQualityIntervals
                                    answer.stringSet
                                    answer.quality
                                    answer.inversion
                                )

                ShowChord ->
                    Just
                        (chordQualityIntervals
                            model.showChord.stringSet
                            model.showChord.quality
                            model.showChord.inversion
                        )

                _ ->
                    Nothing

        rootTone =
            case model.gameMode of
                ShowChord ->
                    Just (toTone model.showChord.rootNote)

                GuessChord ->
                    case model.guessChordGame.answer of
                        Nothing ->
                            Nothing

                        Just answer ->
                            Just (toTone answer.rootNote)

                _ ->
                    Nothing

        chordClasses =
            case ( chordIntervals, rootTone ) of
                ( Nothing, _ ) ->
                    []

                ( _, Nothing ) ->
                    []

                ( Just ci, Just rt ) ->
                    [ ( "root", chordMode && isChordTone rt rootIntervals ci stringNum fretNum )
                    , ( "fifth", chordMode && isChordTone rt fifthIntervals ci stringNum fretNum )
                    , ( "third", chordMode && isChordTone rt thirdIntervals ci stringNum fretNum )
                    , ( "seventh", chordMode && isChordTone rt seventhIntervals ci stringNum fretNum )
                    ]

        highlightClasses =
            chordClasses
                ++ [ ( "selected", not chordMode && isSelected model stringNum fretNum )
                   , ( "chord-octave", chordMode && isOctave model stringNum fretNum )
                   , ( "octave", not chordMode && isOctave model stringNum fretNum )
                   ]

        isHighlighted =
            List.any (\( _, visible ) -> visible) highlightClasses
    in
    highlightClasses
        ++ [ ( "clickable", model.gameMode == Learn )
           , ( "highlighted-note", isHighlighted )
           ]


renderFrets : Model -> Int -> List (Html Msg)
renderFrets model stringNum =
    let
        floatToCssRemString float =
            String.concat [ String.fromFloat float, "rem" ]

        fretWidth fretNum =
            let
                minFretSize =
                    4

                reverseFretNum =
                    (fretCount + 1) - toFloat fretNum

                scale =
                    2
            in
            minFretSize + (reverseFretNum / scale)

        fretWidthInRems fretNum =
            floatToCssRemString (fretWidth fretNum)

        stringThickness =
            let
                minStringSize =
                    0.3

                scale =
                    20
            in
            minStringSize + (toFloat stringNum / scale)

        stringThicknessInRems =
            floatToCssRemString stringThickness

        selectedNoteName =
            model.selectedGuitarNote.noteName
                |> String.split "/"
                |> List.head
                |> Maybe.withDefault "X"

        noteText fretNum =
            if model.gameMode == Learn && isSelected model stringNum fretNum then
                [ div [ class "selected-note-name" ] [ text selectedNoteName ] ]

            else
                []

        fretOnClick fretNum =
            if model.gameMode == Learn then
                onClick (GuitarNoteClicked stringNum fretNum)

            else
                onClick NoOp

        renderFret fretNum =
            div
                [ classList [ ( "fret", True ), ( "fret-marker", Guitar.isMarkerFret fretNum stringNum ) ]
                , style "width" (fretWidthInRems fretNum)
                ]
                [ div
                    [ class "string-line"
                    , classList (noteClassList model stringNum fretNum)
                    , style "height" stringThicknessInRems
                    , fretOnClick fretNum
                    ]
                    (noteText fretNum)
                ]
    in
    List.range 1 fretCount
        |> List.map renderFret


renderStrings : Model -> List (Html Msg)
renderStrings model =
    List.range 1 stringCount
        |> List.map (renderStringName model)


renderStringName : Model -> Int -> Html Msg
renderStringName model stringNum =
    div [ class "string-container" ]
        [ div
            [ class "string-name"
            , classList (noteClassList model stringNum 0)
            , onClick (GuitarNoteClicked stringNum 0)
            ]
            [ text (Guitar.getGuitarStringName stringNum) ]
        , div [ class "string" ] (renderFrets model stringNum)
        ]


render : Model -> Html Msg
render model =
    div [ class "fretboard-container" ]
        [ div [ class "fretboard" ] (renderStrings model) ]
