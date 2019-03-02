module UpdateTests exposing (testChangeGameMode, testGuessNoteButtonClicked)

import Expect
import Game exposing (GameMode(..))
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
        [ test "Sets the game mode to Learn" <|
            \_ ->
                Expect.equal (updatedMode Learn) Learn
        , test "Sets the game mode to GuessNotes" <|
            \_ ->
                Expect.equal (updatedMode GuessNotes) GuessNotes
        , test "Sets the game mode to FindNotes" <|
            \_ ->
                Expect.equal (updatedMode FindNotes) FindNotes
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
                Expect.equal [ "A" ] (updateGuess initialModel "A").guessNotesGame.guesses
        , test "Adds the guess to list of guesses when guesses exist" <|
            \_ ->
                let
                    model =
                        GuessNotesGame.init
                            |> GuessNotesGame.setGuesses [ "B" ]
                            |> Model.asGuessNotesGameIn initialModel
                in
                Expect.equal [ "B", "A" ] (updateGuess model "A").guessNotesGame.guesses
        , test "Marks guess as correct if the note selected matches (natural)" <|
            \_ ->
                let
                    model =
                        initialModel.guessNotesGame
                            |> GuessNotesGame.setGuesses [ "B" ]
                            |> Model.asGuessNotesGameIn initialModel
                            |> Model.setSelectedGuitarNote (Guitar.createGuitarNote 6 0)
                in
                Expect.equal Correct (updateGuess model "E").guessNotesGame.guessState
        , test "Marks guess as correct if the note selected matches (accidental)" <|
            \_ ->
                let
                    model =
                        initialModel.guessNotesGame
                            |> GuessNotesGame.setGuesses [ "B" ]
                            |> Model.asGuessNotesGameIn initialModel
                            |> Model.setSelectedGuitarNote (Guitar.createGuitarNote 6 2)
                in
                Expect.equal Correct (updateGuess model "F#/Gb").guessNotesGame.guessState
        , test "Clears guesses if the note selected matches (natural)" <|
            \_ ->
                let
                    model =
                        initialModel.guessNotesGame
                            |> GuessNotesGame.setGuesses [ "B" ]
                            |> Model.asGuessNotesGameIn initialModel
                            |> Model.setSelectedGuitarNote (Guitar.createGuitarNote 6 0)
                in
                Expect.equal [] (updateGuess model "E").guessNotesGame.guesses
        , test "Marks guess as incorrect if the note selected matches (natural)" <|
            \_ ->
                let
                    model =
                        initialModel.guessNotesGame
                            |> GuessNotesGame.setGuesses [ "B" ]
                            |> Model.asGuessNotesGameIn initialModel
                            |> Model.setSelectedGuitarNote (Guitar.createGuitarNote 6 0)
                in
                Expect.equal Incorrect (updateGuess model "F").guessNotesGame.guessState
        ]
