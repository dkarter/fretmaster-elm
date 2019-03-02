module GameControls exposing (render)

import Game exposing (GameMode(..))
import GuessNoteGameControls
import Html exposing (Html, button, div, input, label, text)
import Html.Attributes exposing (checked, class, type_)
import Html.Events exposing (onCheck, onClick)
import LearnGameControls
import Model exposing (GuessState(..), Model)
import Msg exposing (Msg(..))
import Music


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
