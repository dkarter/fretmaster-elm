module Header exposing (render)

import Html exposing (Html, h1, text)
import Html.Attributes exposing (class)
import Msg exposing (Msg(..))


render : Html Msg
render =
    h1 [] [ text "FretMaster" ]
