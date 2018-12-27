module View exposing (view)

import Fretboard
import GameControls
import Header
import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Menu
import Model exposing (Model)
import Msg exposing (Msg(..))
import SelectedNote


view : Model -> Html Msg
view model =
    div [ class "main" ]
        [ Header.render
        , Menu.render
        , Fretboard.render model
        , GameControls.render model
        , SelectedNote.render model
        ]
