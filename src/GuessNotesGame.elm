module GuessNotesGame exposing
    ( GameState
    , GuessNotesGame
    , GuessState(..)
    , appendGuess
    , getGameState
    , getGuessState
    , getGuesses
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


type GuessNotesGame
    = GuessNotesGame
        { guesses : List Music.Note
        , guessState : GuessState
        , gameState : GameState
        }


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


init =
    GuessNotesGame
        { guesses = []
        , guessState = NotSelected
        , gameState = NotStarted
        }
