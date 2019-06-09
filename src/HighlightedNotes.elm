module HighlightedNotes exposing
    ( HighlightedNotes
    , addNormalHighlight
    , addOctave
    , addRoot
    , addSelected
    , empty
    , isHighlighted
    , isOctave
    , isRoot
    , isSelected
    )

import Dict exposing (Dict)
import Guitar
import Maybe
import Set exposing (Set)


type alias HighlightType =
    String


type alias NoteHighlights =
    Set HighlightType


type alias HighlightedNotes =
    Dict Int (Dict Int NoteHighlights)


addOctave : HighlightedNotes -> Guitar.GuitarNote -> HighlightedNotes
addOctave highlightedNotes guitarNote =
    addNoteHighlight highlightedNotes guitarNote octave


addNormalHighlight : HighlightedNotes -> Guitar.GuitarNote -> HighlightedNotes
addNormalHighlight highlightedNotes guitarNote =
    addNoteHighlight highlightedNotes guitarNote normal


addRoot : HighlightedNotes -> Guitar.GuitarNote -> HighlightedNotes
addRoot highlightedNotes guitarNote =
    addNoteHighlight highlightedNotes guitarNote root


addSelected : HighlightedNotes -> Guitar.GuitarNote -> HighlightedNotes
addSelected highlightedNotes guitarNote =
    addNoteHighlight highlightedNotes guitarNote selected


empty : HighlightedNotes
empty =
    Dict.empty


isOctave : HighlightedNotes -> Guitar.GuitarNote -> Bool
isOctave highlightedNotes guitarNote =
    octave
        |> containsHighlightType highlightedNotes guitarNote


isSelected : HighlightedNotes -> Guitar.GuitarNote -> Bool
isSelected highlightedNotes guitarNote =
    selected
        |> containsHighlightType highlightedNotes guitarNote


isHighlighted : HighlightedNotes -> Guitar.GuitarNote -> Bool
isHighlighted highlightedNotes guitarNote =
    normal
        |> containsHighlightType highlightedNotes guitarNote


isRoot : HighlightedNotes -> Guitar.GuitarNote -> Bool
isRoot highlightedNotes guitarNote =
    root
        |> containsHighlightType highlightedNotes guitarNote



-- HELPER METHODS --


octave : HighlightType
octave =
    "octave"


selected : HighlightType
selected =
    "selected"


normal : HighlightType
normal =
    "normal"


root : HighlightType
root =
    "root"


addNoteHighlight : HighlightedNotes -> Guitar.GuitarNote -> HighlightType -> HighlightedNotes
addNoteHighlight highlightedNotes guitarNote highlightType =
    let
        updatedTypes : NoteHighlights
        updatedTypes =
            Set.insert highlightType fretHighlightTypes

        fretHighlightTypes : NoteHighlights
        fretHighlightTypes =
            highlightedTypes highlightedNotes guitarNote

        stringDict : Dict Int NoteHighlights
        stringDict =
            getStringHighlights highlightedNotes guitarNote

        updatedStringDict : Dict Int NoteHighlights
        updatedStringDict =
            Dict.insert guitarNote.fretNum updatedTypes stringDict
    in
    Dict.insert guitarNote.stringNum updatedStringDict highlightedNotes


getStringHighlights : HighlightedNotes -> Guitar.GuitarNote -> Dict Int NoteHighlights
getStringHighlights highlightedNotes { stringNum } =
    Dict.get stringNum highlightedNotes
        |> Maybe.withDefault Dict.empty


highlightedTypes : HighlightedNotes -> Guitar.GuitarNote -> NoteHighlights
highlightedTypes highlightedNotes guitarNote =
    getStringHighlights highlightedNotes guitarNote
        |> Dict.get guitarNote.fretNum
        |> Maybe.withDefault Set.empty


containsHighlightType : HighlightedNotes -> Guitar.GuitarNote -> HighlightType -> Bool
containsHighlightType highlightedNotes guitarNote highlightType =
    let
        types =
            highlightedTypes highlightedNotes guitarNote
    in
    Set.member highlightType types
