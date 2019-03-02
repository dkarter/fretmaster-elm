module Model exposing (GuessState(..), Model, init)

import AudioPorts
import Game exposing (GameMode(..))
import Guitar exposing (GuitarNote)
import Msg exposing (Msg)
import Music


type GuessState
    = NotSelected
    | Correct
    | Incorrect


type alias Model =
    { selectedGuitarNote : GuitarNote
    , selectedGuitarNoteOctaves : List GuitarNote
    , showOctaves : Bool
    , gameMode : GameMode
    , guesses : List Music.Note
    , guessState : GuessState
    }


init : ( Model, Cmd Msg )
init =
    ( { selectedGuitarNote = Guitar.createGuitarNote 6 0
      , selectedGuitarNoteOctaves = []
      , showOctaves = True
      , gameMode = Learn
      , guesses = []
      , guessState = NotSelected
      }
    , AudioPorts.requestLoadSoundFont "/soundfonts"
    )
