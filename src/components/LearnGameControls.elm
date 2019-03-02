module LearnGameControls exposing (render)

import Html exposing (Html, input, label, text)
import Html.Attributes exposing (checked, class, type_)
import Html.Events exposing (onCheck, onClick)
import Model exposing (Model)
import Msg exposing (Msg(..))
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
