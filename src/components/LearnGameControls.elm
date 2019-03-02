module LearnGameControls exposing (render)

import Game exposing (GameMode(..))
import GuessNoteGameControls
import Html exposing (Html, button, div, input, label, text)
import Html.Attributes exposing (checked, class, type_)
import Html.Events exposing (onCheck, onClick)
import Model exposing (GuessState(..), Model)
import Msg exposing (Msg(..))
import Music
import SelectedNote


render : Model -> List (Html Msg)
render model =
    [ label []
        [ input
            [ checked model.showOctaves
            , type_ "checkbox"
            , onCheck ShowOctavesChanged
            ]
            []
        , text "Show Octaves"
        ]
    , SelectedNote.render model
    ]
