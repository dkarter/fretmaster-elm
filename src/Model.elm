module Model exposing (Model, asGuessNotesGameIn, init, setSelectedGuitarNote)

import AudioPorts
import Game exposing (GameMode(..))
import GuessChordGame exposing (GuessChordGame)
import GuessNotesGame exposing (GuessNotesGame)
import Guitar exposing (GuitarNote)
import Msg exposing (Msg)
import ShowChord exposing (ShowChord)


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
    , showChord : ShowChord
    , guessChordGame : GuessChordGame
    , guessNotesGame : GuessNotesGame
    }


init : ( Model, Cmd Msg )
init =
    ( { selectedGuitarNote = Guitar.createGuitarNote 6 0
      , selectedGuitarNoteOctaves = []
      , showOctaves = False
      , gameMode = Learn
      , showChord = ShowChord.init
      , guessChordGame = GuessChordGame.init
      , guessNotesGame = GuessNotesGame.init
      }
    , AudioPorts.requestLoadSoundFont "/soundfonts"
    )
