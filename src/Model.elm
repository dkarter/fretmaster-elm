module Model exposing (Model, init)

import Game exposing (GameMode(..))
import Guitar exposing (GuitarNote)
import Msg exposing (Msg)


type alias Model =
    { selectedGuitarNote : GuitarNote
    , selectedGuitarNoteOctaves : List GuitarNote
    , showNoteInfo : Bool
    , showOctaves : Bool
    , gameMode : GameMode
    }


init : ( Model, Cmd Msg )
init =
    ( { selectedGuitarNote = Guitar.createGuitarNote 6 0
      , selectedGuitarNoteOctaves = []
      , showNoteInfo = True
      , showOctaves = True
      , gameMode = Learn
      }
    , Cmd.none
    )
