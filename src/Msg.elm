module Msg exposing (Msg(..))

import Game exposing (GameMode)
import GuessNotesGame exposing (GuessNotesGame)
import Guitar
import LearnScalesGame exposing (LearnScalesGame)


type Msg
    = ChangeGameMode GameMode
    | UpdateGameState GameMode
    | NoOp
    | PickRandomNote
    | RandomGuitarNoteSelected Guitar.GuitarNote
