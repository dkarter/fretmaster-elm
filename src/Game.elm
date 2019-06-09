module Game exposing (GameMode(..))

import GuessNotesGame exposing (GuessNotesGame)
import LearnNotesGame exposing (LearnNotesGame)
import LearnScalesGame exposing (LearnScalesGame)


type GameMode
    = LearnNotes LearnNotesGame
    | LearnScales LearnScalesGame
    | GuessNotes GuessNotesGame
    | FindNotes
    | None
