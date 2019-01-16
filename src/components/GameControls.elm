module GameControls exposing (render)

import Html exposing (Html, button, div, input, label, text)
import Html.Attributes exposing (checked, class, type_)
import Html.Events exposing (onCheck, onClick)
import Model exposing (Model)
import Msg exposing (Msg(..))


render : Model -> Html Msg
render model =
    div [ class "game-controls" ]
        [ label []
            [ input
                [ checked model.showOctaves
                , type_ "checkbox"
                , onCheck ShowOctavesChanged
                ]
                []
            , text "Show Octaves"
            ]
        , button
            [ class "pick-note-btn", onClick PickRandomNote ]
            [ text "RANDOM NOTE" ]
        ]
