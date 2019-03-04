module Toggle exposing (render)

import Html exposing (Html, div, input, label, text)
import Html.Attributes exposing (class, type_)
import Msg exposing (Msg)


render : String -> List (Html.Attribute Msg) -> Html Msg
render labelText attributes =
    let
        inputAttributes =
            [ class "toggle-state", type_ "checkbox" ] ++ attributes
    in
    label [ class "toggle-label" ]
        [ div [ class "toggle" ]
            [ input inputAttributes []
            , div [ class "toggle-inner" ] [ div [ class "indicator" ] [] ]
            , div [ class "active-bg" ] []
            ]
        , div [ class "label-text" ] [ text labelText ]
        ]
