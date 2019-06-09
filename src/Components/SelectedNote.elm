module SelectedNote exposing (render)

import Guitar
import Html exposing (Html, button, div, input, label, span, text)
import Html.Attributes exposing (checked, class, type_)
import Html.Events exposing (onCheck, onClick)
import Model exposing (Model)
import Msg exposing (Msg(..))
import Music.PitchNotation as PitchNotation


render : Guitar.GuitarNote -> Html Msg
render guitarNote =
    div [ class "selected-note-info" ]
        [ div [ class "title" ] [ text "Selected Note:" ]
        , div [ class "note-name" ]
            [ text guitarNote.noteName
            ]
        , div [ class "string-name" ]
            [ span [ class "label" ] [ text "String:" ]
            , text guitarNote.stringName
            ]
        , div [ class "string-num" ]
            [ span [ class "label" ] [ text "String #:" ]
            , text (String.fromInt guitarNote.stringNum)
            ]
        , div [ class "fret-num" ]
            [ span [ class "label" ] [ text "Fret #:" ]
            , text (String.fromInt guitarNote.fretNum)
            ]
        , div [ class "pitch-notation" ]
            [ span [ class "label" ] [ text "SPN:" ]
            , text (PitchNotation.toString guitarNote.pitchNotation)
            ]
        ]
