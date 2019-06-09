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


renderPage : Model -> Html Msg
renderPage model =
    case model.gameMode of
        Game.LearnNotes gameState ->
            LearnNotesPage.render gameState

        Game.GuessNotes gameState ->
            GuessNotesPage.render gameState

        Game.LearnScales gameState ->
            LearnScalesPage.render gameState

        _ ->
            NotFoundPage.render


view : Model -> Html Msg
view model =
    div [ class "main" ]
        [ Header.render model
        , renderPage model
        ]
