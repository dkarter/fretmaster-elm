module View exposing (view)

import Game
import GuessNotesPage
import Header
import Html exposing (Html, div)
import Html.Attributes exposing (class)
import LearnNotesPage
import LearnScalesPage
import Model exposing (Model)
import Msg exposing (Msg(..))
import NotFoundPage
import SelectedNote


renderPage : Model -> Html Msg
renderPage model =
    case model.gameMode of
        Game.LearnNotes ->
            LearnNotesPage.render model

        Game.GuessNotes ->
            GuessNotesPage.render model

        Game.LearnScales ->
            LearnScalesPage.render model

        _ ->
            NotFoundPage.render


view : Model -> Html Msg
view model =
    div [ class "main" ]
        [ Header.render model
        , renderPage model
        ]
