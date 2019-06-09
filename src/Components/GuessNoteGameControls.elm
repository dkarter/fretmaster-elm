module GuessNoteGameControls exposing (render)

import Game exposing (GameMode(..))
import GuessNotesGame exposing (GuessNotesGame, GuessState(..))
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (class, classList, disabled)
import Html.Events exposing (onClick)
import Maybe
import Msg exposing (Msg(..))
import Music


handleNoteButtonClick : GuessNotesGame -> Music.Note -> Msg
handleNoteButtonClick gameState note =
    UpdateGameState (GuessNotes (GuessNotesGame.guess gameState note))


renderNoteButtons : GuessNotesGame -> Html Msg
renderNoteButtons gameState =
    let
        guesses =
            GuessNotesGame.getGuesses gameState

        normalizedNoteName note =
            note
                |> String.split "/"
                |> List.head
                |> Maybe.withDefault ""

        classes note =
            classList
                [ ( "accidental", String.contains "/" note )
                ]

        renderNoteButton note =
            button
                [ class "note-button"
                , disablePreviousGuess note
                , onClick (handleNoteButtonClick gameState note)
                , classes note
                ]
                [ text (normalizedNoteName note) ]

        noteButtons =
            let
                tail =
                    Music.notes |> List.take 3

                head =
                    Music.notes |> List.drop 3

                chromatic =
                    head ++ tail
            in
            chromatic
                |> List.map renderNoteButton

        disablePreviousGuess note =
            guesses
                |> List.member note
                |> disabled
    in
    div [ class "note-buttons" ] noteButtons


renderFeedback : GuessNotesGame -> Html Msg
renderFeedback gameState =
    case GuessNotesGame.getGuessState gameState of
        -- TODO: can I access the state in a scoped manner? e.g. GameState.Correct
        Correct ->
            div [ class "game-feedback correct" ]
                [ text "Correct!" ]

        Incorrect ->
            div [ class "game-feedback incorrect" ]
                [ text "WRONG!" ]

        NotSelected ->
            div [] []


render : GuessNotesGame -> List (Html Msg)
render gameState =
    [ renderFeedback gameState
    , renderNoteButtons gameState
    ]
