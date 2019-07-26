module GuessChordGameControls exposing (render)

import Chord exposing (Quality(..))
import GuessChordGame exposing (GuessState(..), guessChordQualities)
import GuitarChord exposing (GuitarChord, StringSet, stringSetLabel, stringSets)
import Html exposing (Html, button, div, h3, img, span, text)
import Html.Attributes exposing (class, classList, disabled, src)
import Html.Events exposing (onClick)
import Maybe exposing (withDefault)
import Model exposing (Model)
import Msg exposing (Msg(..))
import Music


renderNoteButtons : Maybe Music.Note -> Maybe GuitarChord -> Html Msg
renderNoteButtons rootNote answer =
    let
        normalizedNoteName note =
            note
                |> String.split "/"
                |> List.head
                |> Maybe.withDefault ""

        classes note =
            classList
                [ ( "accidental", String.contains "/" note )
                , ( "correct"
                  , case ( rootNote, answer ) of
                        ( _, Nothing ) ->
                            False

                        ( Nothing, _ ) ->
                            False

                        ( Just rn, Just ans ) ->
                            rn == note && ans.rootNote == rn
                  )
                , ( "incorrect"
                  , case ( rootNote, answer ) of
                        ( _, Nothing ) ->
                            False

                        ( Nothing, _ ) ->
                            False

                        ( Just rn, Just ans ) ->
                            rn == note && ans.rootNote /= rn
                  )
                ]

        renderNoteButton note =
            button
                [ class "note-button"
                , onClick (GuessChordRootButtonClicked note)
                , classes note
                ]
                [ text (normalizedNoteName note) ]

        noteButtons =
            let
                tail =
                    Music.notes |> List.take 3

                head =
                    Music.notes |> List.drop 3

                chromatic =
                    head ++ tail
            in
            chromatic
                |> List.map renderNoteButton
    in
    div [ class "note-buttons" ] noteButtons


renderInversionButtons : Maybe Int -> Maybe GuitarChord -> Html Msg
renderInversionButtons selectedInversion answer =
    let
        inversions =
            [ ( 0, "Root" )
            , ( 1, "First" )
            , ( 2, "Second" )
            , ( 3, "Third" )
            ]

        classes inversion =
            classList
                [ ( "correct"
                  , case ( selectedInversion, answer ) of
                        ( _, Nothing ) ->
                            False

                        ( Nothing, _ ) ->
                            False

                        ( Just si, Just ans ) ->
                            si == inversion && si == ans.inversion
                  )
                , ( "incorrect"
                  , case ( selectedInversion, answer ) of
                        ( _, Nothing ) ->
                            False

                        ( Nothing, _ ) ->
                            False

                        ( Just si, Just ans ) ->
                            si == inversion && si /= ans.inversion
                  )
                ]

        renderInversionButton ( inversion, inversionName ) =
            button
                [ class "quality-button"
                , onClick (GuessChordInversionButtonClicked inversion)
                , classes inversion
                ]
                [ text inversionName ]

        inversionButtons =
            inversions |> List.map renderInversionButton
    in
    div [ class "inversion-buttons" ] ([ h3 [] [ text "Chord Inversion" ] ] ++ inversionButtons)


renderStringSetButtons : Maybe StringSet -> Maybe GuitarChord -> Html Msg
renderStringSetButtons selectedStringSet answer =
    let
        classes stringSet =
            classList
                [ ( "correct"
                  , case ( selectedStringSet, answer ) of
                        ( Nothing, _ ) ->
                            False

                        ( _, Nothing ) ->
                            False

                        ( Just sss, Just ans ) ->
                            sss == stringSet && sss == ans.stringSet
                  )
                , ( "incorrect"
                  , case ( selectedStringSet, answer ) of
                        ( Nothing, _ ) ->
                            False

                        ( _, Nothing ) ->
                            False

                        ( Just sss, Just ans ) ->
                            sss == stringSet && sss /= ans.stringSet
                  )
                ]

        renderStringSetButton : StringSet -> Html Msg
        renderStringSetButton stringSet =
            button
                [ class "string-set-button"
                , onClick (GuessChordStringSetButtonClicked stringSet)
                , classes stringSet
                ]
                [ img [ src ("string-sets/" ++ stringSetLabel stringSet ++ ".svg") ] [] ]

        stringSetButtons =
            stringSets |> List.map renderStringSetButton
    in
    div [ class "string-set-buttons" ] ([ h3 [] [ text "String Set" ] ] ++ stringSetButtons)


renderLegend : Html Msg
renderLegend =
    div [ class "chord-tone-legend" ]
        [ h3 [] [ text "Chord Tone Legend" ]
        , span [ class "root" ] [ text "Root" ]
        , span [ class "third" ] [ text "Third" ]
        , span [ class "fifth" ] [ text "Fifth" ]
        , span [ class "seventh" ] [ text "Seventh" ]
        ]


renderQualityButtons : Maybe Quality -> Maybe GuitarChord -> Html Msg
renderQualityButtons selectedQuality answer =
    let
        classes quality =
            classList
                [ ( "correct"
                  , case ( selectedQuality, answer ) of
                        ( _, Nothing ) ->
                            False

                        ( Nothing, _ ) ->
                            False

                        ( Just sq, Just ans ) ->
                            sq == quality && sq == ans.quality
                  )
                , ( "incorrect"
                  , case ( selectedQuality, answer ) of
                        ( _, Nothing ) ->
                            False

                        ( Nothing, _ ) ->
                            False

                        ( Just sq, Just ans ) ->
                            sq == quality && sq /= ans.quality
                  )
                ]

        renderQualityButton ( quality, qualityName ) =
            button
                [ class "quality-button"
                , onClick (GuessChordQualityButtonClicked quality)
                , classes quality
                ]
                [ text qualityName ]

        qualityButtons =
            guessChordQualities |> List.map renderQualityButton
    in
    div [ class "quality-buttons" ] ([ h3 [] [ text "Chord Quality" ] ] ++ qualityButtons)


renderFeedback : Model -> Html Msg
renderFeedback model =
    case model.guessChordGame.guessState of
        Incomplete ->
            div [ class "game-feedback incomplete" ] [ text "Select Chord Properties" ]

        Incorrect ->
            div [ class "game-feedback incorrect" ] [ text "WRONG!" ]

        Correct ->
            div [ class "game-feedback correct" ]
                [ text "Correct!"
                , div [ class "reset-button" ] [ button [ onClick GuessChordReset ] [ text "Try Another" ] ]
                ]


render : Model -> List (Html Msg)
render model =
    let
        guess =
            model.guessChordGame.guess

        answer =
            model.guessChordGame.answer
    in
    [ div [ class "show-chord" ]
        [ renderFeedback model
        , renderLegend
        , renderStringSetButtons guess.stringSet answer
        , renderQualityButtons guess.quality answer
        , renderInversionButtons guess.inversion answer
        , renderNoteButtons guess.rootNote answer
        ]
    ]
