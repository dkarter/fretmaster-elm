module Header exposing (render)

import Html exposing (Html, div, img)
import Html.Attributes exposing (alt, class, src)
import Menu
import Msg exposing (Msg)


render : Html Msg
render =
    div [ class "header-container" ]
        [ img [ alt "fretmaster logo", class "logo", src "logo.svg" ] []
        , Menu.render
        ]
