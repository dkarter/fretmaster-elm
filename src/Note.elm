module Note exposing
    ( Octave, Note
    , newNote, noteToIndex
    , octave
    )

{-| This module provides types and functions to manipulate musical notes.
Notes being represented as a tone and an octave convertible to an index (MIDI value)


# Types

@docs Octave, Note


# Common Helpers

@docs newNote, noteToIndex

-}

import Tone exposing (Adjustment, Key, Tone, adjustmentToValue, chromaticTones, keyToValue, newTone, toneToIndex)


{-| Octave represents an octave number, as represented in piano or MIDI notation
-}
type alias Octave =
    Int


{-| Note represents a tone on a given octave
-}
type alias Note =
    { tone : Tone
    , octave : Octave
    }


{-| newNote is a helper function to create a note
-}
newNote : Key -> Adjustment -> Octave -> Note
newNote key adjustment oct =
    { tone = newTone key adjustment, octave = oct }


{-| noteToIndex returns the MIDI value of a given note
-}
noteToIndex : Note -> Int
noteToIndex note =
    note.octave * 12 + toneToIndex note.tone


octave : Int -> Adjustment -> List Note
octave number adj =
    List.map (\t -> newNote t.key t.adjustment number) (chromaticTones adj)
