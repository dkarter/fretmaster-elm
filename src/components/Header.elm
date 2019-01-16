module Header exposing (render)

import Html exposing (Html, img)
import Html.Attributes exposing (alt, class, src)
import Msg exposing (Msg)


render : Html Msg
render =
    img [ alt "fretmaster logo", class "logo", src "logo.svg" ] []
