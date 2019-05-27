module Model exposing (Model, asGuessNotesGameIn, init, setSelectedGuitarNote)

import AudioPorts
import Game exposing (GameMode)
import GuessNotesGame exposing (GuessNotesGame)
import Guitar exposing (GuitarNote)
import LearnScalesGame exposing (LearnScalesGame)
import Msg exposing (Msg)
import Music


setSelectedGuitarNote : GuitarNote -> Model -> Model
setSelectedGuitarNote guitarNote model =
    { model | selectedGuitarNote = guitarNote }


asGuessNotesGameIn : Model -> GuessNotesGame -> Model
asGuessNotesGameIn model gameState =
    { model | guessNotesGame = gameState }


type alias Model =
    { selectedGuitarNote : GuitarNote
    , selectedGuitarNoteOctaves : List GuitarNote
    , showOctaves : Bool
    , gameMode : GameMode
    , guessNotesGame : GuessNotesGame
    , learnScalesGame : LearnScalesGame
    }


init : ( Model, Cmd Msg )
init =
    ( { selectedGuitarNote = Guitar.createGuitarNote 6 0
      , selectedGuitarNoteOctaves = []
      , showOctaves = False
      , gameMode = Game.LearnNotes
      , guessNotesGame = GuessNotesGame.init
      , learnScalesGame = LearnScalesGame.init
      }
    , AudioPorts.requestLoadSoundFont "/soundfonts"
    )
