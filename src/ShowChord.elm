module ShowChord exposing (ShowChord, init)

import Chord exposing (Quality(..))
import GuitarChord exposing (StringSet(..))
import Music


type alias ShowChord =
    { rootNote : Music.Note
    , quality : Chord.Quality
    , inversion : Int
    , stringSet : StringSet
    }


init : ShowChord
init =
    { stringSet = FirstSetBrokenFour
    , quality = Chord.MajorSeventh
    , rootNote = "D"
    , inversion = 0
    }
