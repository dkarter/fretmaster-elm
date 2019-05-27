module View exposing (view)

import Game
import Header
import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Model exposing (Model)
import Msg exposing (Msg(..))
import Pages.GuessNotesPage as GuessNotesPage
import Pages.LearnNotesPage as LearnNotesPage
import Pages.LearnScalesPage as LearnScalesPage
import Pages.NotFoundPage as NotFoundPage
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
