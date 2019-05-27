module SelectedNote exposing (render)

import Html exposing (Html, button, div, input, label, span, text)
import Html.Attributes exposing (checked, class, type_)
import Html.Events exposing (onCheck, onClick)
import Model exposing (Model)
import Msg exposing (Msg(..))
import Music.PitchNotation as PitchNotation


render : Model -> Html Msg
render model =
    let
        selectedNote =
            model.selectedGuitarNote
    in
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
        , div [ class "pitch-notation" ]
            [ span [ class "label" ] [ text "SPN:" ]
            , text (PitchNotation.toString selectedNote.pitchNotation)
            ]
        ]
