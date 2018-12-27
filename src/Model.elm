module Model exposing (Model)

import Guitar exposing (GuitarNote)


type alias Model =
    { selectedGuitarNote : GuitarNote
    , selectedGuitarNoteOctaves : List GuitarNote
    , showNoteInfo : Bool
    , showOctaves : Bool
    }
