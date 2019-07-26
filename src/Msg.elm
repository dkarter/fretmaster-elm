module Msg exposing (Msg(..))

import Chord exposing (Quality(..))
import Game exposing (GameMode)
import Guitar
import GuitarChord
import Music


type Msg
    = ChangeGameMode GameMode
    | GuessNoteButtonClicked Music.Note
    | GuitarNoteClicked Int Int
    | NoOp
    | PickRandomNote
    | RandomGuitarNoteSelected Guitar.GuitarNote
    | RandomGuitarChordSelected GuitarChord.GuitarChord
    | ShowOctavesChanged Bool
    | ShowChordStringSetButtonClicked GuitarChord.StringSet
    | ShowChordQualityButtonClicked Chord.Quality
    | ShowChordRootButtonClicked Music.Note
    | ShowChordInversionButtonClicked Int
    | GuessChordReset
    | GuessChordStringSetButtonClicked GuitarChord.StringSet
    | GuessChordQualityButtonClicked Chord.Quality
    | GuessChordRootButtonClicked Music.Note
    | GuessChordInversionButtonClicked Int
