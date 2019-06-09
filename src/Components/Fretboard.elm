module Fretboard exposing
    ( fretboard
    , toHtml
    , withHighlightedNotes
    , withNoteNameVisible
    , withNotesClickable
    , withOnClick
    )

import Guitar
import HighlightedNotes exposing (HighlightedNotes)
import Html exposing (Html, div, text)
import Html.Attributes exposing (class, classList, style)
import Html.Events exposing (onClick)
import Msg exposing (Msg(..))


type alias Options =
    { highlightedNotes : HighlightedNotes
    , onClick : Guitar.GuitarNote -> Msg
    , notesClickable : Bool
    , noteNameVisible : Bool
    }


defaultOptions : Options
defaultOptions =
    { highlightedNotes = HighlightedNotes.empty
    , onClick = \_ -> NoOp
    , notesClickable = False
    , noteNameVisible = False
    }


type Fretboard
    = Fretboard Options


fretboard : Fretboard
fretboard =
    Fretboard defaultOptions


withHighlightedNotes : HighlightedNotes -> Fretboard -> Fretboard
withHighlightedNotes highlightedNotes (Fretboard options) =
    Fretboard { options | highlightedNotes = highlightedNotes }


withNotesClickable : Bool -> Fretboard -> Fretboard
withNotesClickable notesClickable (Fretboard options) =
    Fretboard { options | notesClickable = notesClickable }


withNoteNameVisible : Bool -> Fretboard -> Fretboard
withNoteNameVisible noteNameVisible (Fretboard options) =
    Fretboard { options | noteNameVisible = noteNameVisible }


withOnClick : (Guitar.GuitarNote -> Msg) -> Fretboard -> Fretboard
withOnClick onClick (Fretboard options) =
    Fretboard { options | onClick = onClick }


fretCount : Int
fretCount =
    12


stringCount : Int
stringCount =
    Guitar.guitarStrings
        |> List.length


renderFrets : Options -> Int -> List (Html Msg)
renderFrets options stringNum =
    let
        floatToCssRemString float =
            String.concat [ String.fromFloat float, "rem" ]

        fretWidth fretNum =
            let
                minFretSize =
                    4

                reverseFretNum =
                    (fretCount + 1) - fretNum

                scale =
                    2
            in
            minFretSize + (toFloat reverseFretNum / toFloat scale)

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

        selectedNoteName fretNum =
            (Guitar.createGuitarNote stringNum fretNum).noteName
                |> String.split "/"
                |> List.head
                |> Maybe.withDefault "X"

        isSelected fretNum =
            HighlightedNotes.isSelected options.highlightedNotes (guitarNote fretNum)

        isOctave fretNum =
            HighlightedNotes.isOctave options.highlightedNotes (guitarNote fretNum)

        isHighlighted fretNum =
            HighlightedNotes.isHighlighted options.highlightedNotes (guitarNote fretNum)

        noteText fretNum =
            if options.noteNameVisible && isSelected fretNum then
                [ div [ class "selected-note-name" ] [ text (selectedNoteName fretNum) ] ]

            else
                []

        guitarNote fretNum =
            Guitar.createGuitarNote stringNum fretNum

        fretOnClick fretNum =
            onClick (options.onClick (guitarNote fretNum))

        renderFret fretNum =
            div
                [ classList [ ( "fret", True ), ( "fret-marker", Guitar.isMarkerFret fretNum stringNum ) ]
                , style "width" (fretWidthInRems fretNum)
                ]
                [ div
                    [ class "string-line"
                    , classList
                        [ ( "selected", isSelected fretNum )
                        , ( "octave", isOctave fretNum )
                        , ( "highlighted", isHighlighted fretNum )
                        , ( "clickable", options.notesClickable )
                        ]
                    , style "height" stringThicknessInRems
                    , fretOnClick fretNum
                    ]
                    (noteText fretNum)
                ]
    in
    List.range 1 fretCount
        |> List.map renderFret


renderStrings : Options -> List (Html Msg)
renderStrings options =
    List.range 1 stringCount
        |> List.map (renderString options)


renderString : Options -> Int -> Html Msg
renderString options stringNum =
    let
        guitarNote =
            Guitar.createGuitarNote stringNum 0

        isSelected =
            HighlightedNotes.isSelected options.highlightedNotes guitarNote

        isOctave =
            HighlightedNotes.isOctave options.highlightedNotes guitarNote

        isHighlighted =
            HighlightedNotes.isHighlighted options.highlightedNotes guitarNote
    in
    div [ class "string-container" ]
        [ div
            [ class "string-name"
            , classList
                [ ( "selected", isSelected )
                , ( "octave", isOctave )
                , ( "highlighted", isHighlighted )
                ]
            , onClick (options.onClick guitarNote)
            ]
            [ text (Guitar.getGuitarStringName stringNum) ]
        , div [ class "string" ] (renderFrets options stringNum)
        ]


toHtml : Fretboard -> Html Msg
toHtml (Fretboard options) =
    div [ class "fretboard-container" ]
        [ div [ class "fretboard" ] (renderStrings options) ]
