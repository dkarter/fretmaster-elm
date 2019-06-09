module Menu exposing (render)

import Game exposing (GameMode(..))
import GuessNotesGame exposing (GuessNotesGame)
import Html exposing (Html, a, li, text, ul)
import Html.Attributes exposing (class, classList)
import Html.Events exposing (onClick)
import LearnNotesGame exposing (LearnNotesGame)
import LearnScalesGame exposing (LearnScalesGame)
import Model exposing (Model)
import Msg exposing (Msg(..))


render : Model -> Html Msg
render model =
    let
        -- TODO: can I do a pattern match?
        activeClass mode =
            classList [ ( "active", model.gameMode == mode ) ]
    in
    ul [ class "menu" ]
        [ li [ onClick (ChangeGameMode (LearnNotes LearnNotesGame.init)) ] [ text "Learn Notes" ]
        , li [ onClick (ChangeGameMode (GuessNotes GuessNotesGame.init)) ] [ text "Guess" ]
        , li [ onClick (ChangeGameMode (LearnScales LearnScalesGame.init)) ] [ text "Learn Scales" ]
        ]
