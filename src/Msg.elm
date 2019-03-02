module Msg exposing (Msg(..))

import Game exposing (GameMode)
import Guitar
import Music


type Msg
    = ChangeGameMode GameMode
    | GuessNoteButtonClicked Music.Note
    | GuitarNoteClicked Int Int
    | NoOp
    | PickRandomNote
    | RandomGuitarNoteSelected Guitar.GuitarNote
    | ShowOctavesChanged Bool
