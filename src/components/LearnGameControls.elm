module LearnGameControls exposing (render)

import Html exposing (Html, label)
import Html.Attributes exposing (checked)
import Html.Events exposing (onCheck)
import Model exposing (Model)
import Msg exposing (Msg(..))
import SelectedNote
import Toggle


render : Model -> List (Html Msg)
render model =
    [ Toggle.render "Show Octaves"
        [ onCheck ShowOctavesChanged
        , checked model.showOctaves
        ]
    , SelectedNote.render model
    ]
