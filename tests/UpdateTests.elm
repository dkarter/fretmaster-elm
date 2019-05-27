module UpdateTests exposing (testChangeGameMode, testGuessNoteButtonClicked)

import Expect
import Game
import GuessNotesGame exposing (GuessState(..))
import Guitar
import Model exposing (Model)
import Msg exposing (Msg(..))
import Test exposing (..)
import Update


initialModel : Model
initialModel =
    Model.init
        |> Tuple.first


updateModel : Msg -> Model -> Model
updateModel msg model =
    Update.update msg model
        |> Tuple.first


testChangeGameMode : Test
testChangeGameMode =
    let
        updatedMode toMode =
            updateModel (ChangeGameMode toMode) initialModel
                |> .gameMode
    in
    describe "ChangeGameMode"
        [ test "Sets the game mode to LearnNotes" <|
            \_ ->
                Expect.equal (updatedMode Game.LearnNotes) Game.LearnNotes
        , test "Sets the game mode to GuessNotes" <|
            \_ ->
                Expect.equal (updatedMode Game.GuessNotes) Game.GuessNotes
        , test "Sets the game mode to FindNotes" <|
            \_ ->
                Expect.equal (updatedMode Game.FindNotes) Game.FindNotes
        ]


testGuessNoteButtonClicked : Test
testGuessNoteButtonClicked =
    let
        updateGuess model note =
            updateModel (GuessNoteButtonClicked note) model
    in
    describe "GuessNoteButtonClicked"
        [ test "Adds the guess to list of guesses when guesses are empty" <|
            \_ ->
                Expect.equal [ "A" ] (GuessNotesGame.getGuesses (updateGuess initialModel "A").guessNotesGame)
        , test "Adds the guess to list of guesses when guesses exist" <|
            \_ ->
                let
                    model =
                        GuessNotesGame.init
                            |> GuessNotesGame.setGuesses [ "B" ]
                            |> Model.asGuessNotesGameIn initialModel

                    guesses =
                        GuessNotesGame.getGuesses (updateGuess model "A").guessNotesGame
                in
                Expect.equal [ "B", "A" ] guesses
        , test "Marks guess as correct if the note selected matches (natural)" <|
            \_ ->
                let
                    model =
                        initialModel.guessNotesGame
                            |> GuessNotesGame.setGuesses [ "B" ]
                            |> Model.asGuessNotesGameIn initialModel
                            |> Model.setSelectedGuitarNote (Guitar.createGuitarNote 6 0)

                    guessState =
                        GuessNotesGame.getGuessState (updateGuess model "E").guessNotesGame
                in
                Expect.equal Correct guessState
        , test "Marks guess as correct if the note selected matches (accidental)" <|
            \_ ->
                let
                    model =
                        initialModel.guessNotesGame
                            |> GuessNotesGame.setGuesses [ "B" ]
                            |> Model.asGuessNotesGameIn initialModel
                            |> Model.setSelectedGuitarNote (Guitar.createGuitarNote 6 2)

                    guessState =
                        GuessNotesGame.getGuessState (updateGuess model "F#/Gb").guessNotesGame
                in
                Expect.equal Correct guessState
        , test "Clears guesses if the note selected matches (natural)" <|
            \_ ->
                let
                    model =
                        initialModel.guessNotesGame
                            |> GuessNotesGame.setGuesses [ "B" ]
                            |> Model.asGuessNotesGameIn initialModel
                            |> Model.setSelectedGuitarNote (Guitar.createGuitarNote 6 0)

                    guesses =
                        GuessNotesGame.getGuesses (updateGuess initialModel "E").guessNotesGame
                in
                Expect.equal [] guesses
        , test "Marks guess as incorrect if the note selected matches (natural)" <|
            \_ ->
                let
                    model =
                        initialModel.guessNotesGame
                            |> GuessNotesGame.setGuesses [ "B" ]
                            |> Model.asGuessNotesGameIn initialModel
                            |> Model.setSelectedGuitarNote (Guitar.createGuitarNote 6 0)

                    guessState =
                        GuessNotesGame.getGuessState (updateGuess initialModel "F").guessNotesGame
                in
                Expect.equal Incorrect guessState
        ]
