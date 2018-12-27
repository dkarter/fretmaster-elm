module Msg exposing (Msg(..))

import Guitar exposing (GuitarNote)


type Msg
    = GuitarNoteClicked Int Int
    | PickRandomNote
    | RandomGuitarNoteSelected GuitarNote
    | ShowNoteInfo
    | ShowOctavesChanged Bool
    | NoOp
