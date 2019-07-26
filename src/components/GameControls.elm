module GameControls exposing (render)

import Game exposing (GameMode(..))
import GuessChordGameControls
import GuessNoteGameControls
import Html exposing (Html, div, text)
import Html.Attributes exposing (class, classList)
import LearnGameControls
import Model exposing (Model)
import Msg exposing (Msg(..))
import ShowChordControls


render : Model -> Html Msg
render model =
    let
        gameControls =
            case model.gameMode of
                GuessNotes ->
                    GuessNoteGameControls.render model

                Learn ->
                    LearnGameControls.render model

                GuessChord ->
                    GuessChordGameControls.render model

                ShowChord ->
                    ShowChordControls.render model

                FindNotes ->
                    [ div [] [ text "COMING SOON..." ] ]

        classes =
            classList
                [ ( "learn", model.gameMode == Learn )
                , ( "guess-notes", model.gameMode == GuessNotes )
                , ( "find-notes", model.gameMode == FindNotes )
                ]
    in
    div [ class "game-controls", classes ] gameControls
