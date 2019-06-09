module LearnNotesGame exposing
    ( LearnNotesGame
    , getHighlightedGuitarNotes
    , getSelectedGuitarNote
    , getShowOctaves
    , init
    , setSelectedGuitarNote
    , setShowOctaves
    )

import Guitar
import HighlightedNotes exposing (HighlightedNotes)


type LearnNotesGame
    = LearnNotesGame
        { selectedGuitarNote : Guitar.GuitarNote
        , showOctaves : Bool
        }


setSelectedGuitarNote : LearnNotesGame -> Guitar.GuitarNote -> LearnNotesGame
setSelectedGuitarNote (LearnNotesGame gameState) guitarNote =
    LearnNotesGame { gameState | selectedGuitarNote = guitarNote }


getSelectedGuitarNote : LearnNotesGame -> Guitar.GuitarNote
getSelectedGuitarNote (LearnNotesGame { selectedGuitarNote }) =
    selectedGuitarNote


setShowOctaves : LearnNotesGame -> Bool -> LearnNotesGame
setShowOctaves (LearnNotesGame gameState) value =
    LearnNotesGame { gameState | showOctaves = value }


getShowOctaves : LearnNotesGame -> Bool
getShowOctaves (LearnNotesGame { showOctaves }) =
    showOctaves


getHighlightedGuitarNotes : LearnNotesGame -> HighlightedNotes
getHighlightedGuitarNotes (LearnNotesGame { selectedGuitarNote, showOctaves }) =
    let
        addOctave octave highlights =
            HighlightedNotes.addOctave highlights octave

        octaves =
            Guitar.findAllOctaves selectedGuitarNote.noteName 12

        highlightedNotes =
            if showOctaves then
                octaves
                    |> List.foldl addOctave HighlightedNotes.empty

            else
                HighlightedNotes.empty
    in
    selectedGuitarNote |> HighlightedNotes.addSelected highlightedNotes


init : LearnNotesGame
init =
    LearnNotesGame
        { selectedGuitarNote = Guitar.createGuitarNote 6 0
        , showOctaves = False
        }
