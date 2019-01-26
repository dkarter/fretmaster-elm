module Main exposing (main)

import Array
import Browser
import Model exposing (Model)
import Msg exposing (Msg(..))
import Update
import View


main : Program () Model Msg
main =
    Browser.element
        { view = View.view
        , init = \_ -> Model.init
        , update = Update.update
        , subscriptions = always Sub.none
        }
