module SelectedNote exposing (render)

import Html exposing (Html, button, div, input, label, span, text)
import Html.Attributes exposing (checked, class, type_)
import Html.Events exposing (onCheck, onClick)
import Model exposing (Model)
import Msg exposing (Msg(..))
import Music


render : Model -> Html Msg
render model =
    let
        selectedNote =
            model.selectedGuitarNote

        showNoteInfo =
            model.showNoteInfo
    in
    case showNoteInfo of
        False ->
            button [ class "show-answer-btn", onClick ShowNoteInfo ]
                [ text "REVEAL ANSWER" ]

        True ->
            div [ class "selected-note-info" ]
                [ div [ class "title" ] [ text "Selected Note:" ]
                , div [ class "note-name" ]
                    [ text selectedNote.noteName
                    ]
                , div [ class "string-name" ]
                    [ span [ class "label" ] [ text "String:" ]
                    , text selectedNote.stringName
                    ]
                , div [ class "string-num" ]
                    [ span [ class "label" ] [ text "String #:" ]
                    , text (String.fromInt selectedNote.stringNum)
                    ]
                , div [ class "fret-num" ]
                    [ span [ class "label" ] [ text "Fret #:" ]
                    , text (String.fromInt selectedNote.fretNum)
                    ]
                , div [ class "scientific-pitch-notation" ]
                    [ span [ class "label" ] [ text "SPN:" ]
                    , text (Music.pitchNotationToStr selectedNote.scientificPitchNotation)
                    ]
                ]
