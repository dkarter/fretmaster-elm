module GuessNotesGame exposing
    ( GameState
    , GuessNotesGame
    , GuessState(..)
    , appendGuess
    , init
    , setGameState
    , setGuessState
    , setGuesses
    )

import Music


type GuessState
    = NotSelected
    | Correct
    | Incorrect


type GameState
    = InProgress
    | NotStarted


type alias GuessNotesGame =
    { guesses : List Music.Note
    , guessState : GuessState
    , gameState : GameState
    }


appendGuess : Music.Note -> GuessNotesGame -> GuessNotesGame
appendGuess note guessNotesGame =
    { guessNotesGame | guesses = guessNotesGame.guesses ++ [ note ] }


setGuesses : List Music.Note -> GuessNotesGame -> GuessNotesGame
setGuesses guesses guessNotesGame =
    { guessNotesGame | guesses = guesses }


setGameState : GameState -> GuessNotesGame -> GuessNotesGame
setGameState gameState guessNotesGame =
    { guessNotesGame | gameState = gameState }


setGuessState : GuessState -> GuessNotesGame -> GuessNotesGame
setGuessState guessState guessNotesGame =
    { guessNotesGame | guessState = guessState }


init =
    { guesses = []
    , guessState = NotSelected
    , gameState = NotStarted
    }
