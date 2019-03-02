module View exposing (view)

import Fretboard
import GameControls
import Header
import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Model exposing (Model)
import Msg exposing (Msg(..))
import SelectedNote


view : Model -> Html Msg
view model =
    div [ class "main" ]
        [ Header.render model
        , Fretboard.render model
        , GameControls.render model
        ]
