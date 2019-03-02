module UpdateTests exposing (testChangeGameMode, testGuessNoteButtonClicked)

import Expect
import Game exposing (GameMode(..))
import Guitar
import Model exposing (GuessState(..), Model)
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
                Expect.equal [ "A" ] (updateGuess initialModel "A").guesses
        , test "Adds the guess to list of guesses when guesses exist" <|
            \_ ->
                let
                    model =
                        { initialModel | guesses = [ "B" ] }
                in
                Expect.equal [ "B", "A" ] (updateGuess model "A").guesses
        , test "Marks guess as correct if the note selected matches (natural)" <|
            \_ ->
                let
                    model =
                        { initialModel | selectedGuitarNote = Guitar.createGuitarNote 6 0, guesses = [ "B" ] }
                in
                Expect.equal Correct (updateGuess model "E").guessState
        , test "Marks guess as correct if the note selected matches (accidental)" <|
            \_ ->
                let
                    model =
                        { initialModel | selectedGuitarNote = Guitar.createGuitarNote 6 2, guesses = [ "B" ] }
                in
                Expect.equal Correct (updateGuess model "F#/Gb").guessState
        , test "Clears guesses if the note selected matches (natural)" <|
            \_ ->
                let
                    model =
                        { initialModel | selectedGuitarNote = Guitar.createGuitarNote 6 0, guesses = [ "B" ] }
                in
                Expect.equal [] (updateGuess model "E").guesses
        , test "Marks guess as incorrect if the note selected matches (natural)" <|
            \_ ->
                let
                    model =
                        { initialModel | selectedGuitarNote = Guitar.createGuitarNote 6 0, guesses = [ "B" ] }
                in
                Expect.equal Incorrect (updateGuess model "F").guessState
        ]
