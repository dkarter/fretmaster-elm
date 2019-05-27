module Pages.NotFoundPage exposing (render)

import Html exposing (Html, div, text)
import Html.Attributes exposing (class)
import Msg exposing (Msg(..))


render : Html Msg
render =
    div [ class "body" ]
        [ text "Sorry page not found..." ]
