module GuessNotesGame exposing
    ( GameState
    , GuessNotesGame
    , GuessState(..)
    , appendGuess
    , getGameState
    , getGuessState
    , getGuesses
    , getHighlightedGuitarNotes
    , guess
    , init
    , setGameState
    , setGuessState
    , setGuesses
    )

import Guitar
import HighlightedNotes exposing (HighlightedNotes)
import Music


type GuessState
    = NotSelected
    | Correct
    | Incorrect


type GameState
    = InProgress
    | NotStarted


type GuessNotesGame
    = GuessNotesGame
        { guesses : List Music.Note
        , guessState : GuessState
        , gameState : GameState
        , currentGuitarNote : Guitar.GuitarNote
        }


guess : GuessNotesGame -> Music.Note -> GuessNotesGame
guess game guessNote =
    let
        checkCorrectNote (GuessNotesGame { currentGuitarNote }) =
            currentGuitarNote.noteName == guessNote
    in
    case checkCorrectNote game of
        True ->
            game
                |> setGuesses []
                |> setGuessState Correct

        False ->
            game
                |> appendGuess guessNote
                |> setGuessState Incorrect


appendGuess : Music.Note -> GuessNotesGame -> GuessNotesGame
appendGuess note (GuessNotesGame guessNotesGame) =
    GuessNotesGame { guessNotesGame | guesses = guessNotesGame.guesses ++ [ note ] }


setGuesses : List Music.Note -> GuessNotesGame -> GuessNotesGame
setGuesses guesses (GuessNotesGame guessNotesGame) =
    GuessNotesGame { guessNotesGame | guesses = guesses }


setGameState : GameState -> GuessNotesGame -> GuessNotesGame
setGameState gameState (GuessNotesGame guessNotesGame) =
    GuessNotesGame { guessNotesGame | gameState = gameState }


setGuessState : GuessState -> GuessNotesGame -> GuessNotesGame
setGuessState guessState (GuessNotesGame guessNotesGame) =
    GuessNotesGame { guessNotesGame | guessState = guessState }


getGuesses : GuessNotesGame -> List Music.Note
getGuesses (GuessNotesGame { guesses }) =
    guesses


getGameState : GuessNotesGame -> GameState
getGameState (GuessNotesGame { gameState }) =
    gameState


getGuessState : GuessNotesGame -> GuessState
getGuessState (GuessNotesGame { guessState }) =
    guessState


getHighlightedGuitarNotes : GuessNotesGame -> HighlightedNotes
getHighlightedGuitarNotes (GuessNotesGame { currentGuitarNote }) =
    currentGuitarNote
        |> HighlightedNotes.addSelected HighlightedNotes.empty


init =
    GuessNotesGame
        { guesses = []
        , guessState = NotSelected
        , gameState = NotStarted
        , currentGuitarNote = Guitar.createGuitarNote 5 5
        }
