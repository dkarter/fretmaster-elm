module Header exposing (render)

import Html exposing (Html, div, img)
import Html.Attributes exposing (alt, class, src)
import Menu
import Model exposing (Model)
import Msg exposing (Msg)


render : Model -> Html Msg
render model =
    div [ class "header-container" ]
        [ img [ alt "fretmaster logo", class "logo", src "logo.svg" ] []
        , Menu.render model
        ]
