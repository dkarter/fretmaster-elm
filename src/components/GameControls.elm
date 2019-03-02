module GameControls exposing (render)

import Game exposing (GameMode(..))
import GuessNoteGameControls
import Html exposing (Html, div, text)
import Html.Attributes exposing (class)
import LearnGameControls
import Model exposing (Model)
import Msg exposing (Msg(..))


render : Model -> Html Msg
render model =
    let
        gameControls =
            case model.gameMode of
                GuessNotes ->
                    GuessNoteGameControls.render model

                Learn ->
                    LearnGameControls.render model

                FindNotes ->
                    [ div [] [ text "COMING SOON..." ] ]
    in
    div [ class "game-controls" ] gameControls
