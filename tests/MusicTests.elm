module MusicTests exposing (testGetNoteNameByIndex, testGetScaleNotes, testPitchNotationToStr)

import Expect
import Music exposing (getNoteNameByIndex, getScaleNotes, pitchNotationToStr)
import Test exposing (..)


testPitchNotationToStr : Test
testPitchNotationToStr =
    describe "pitchNotationToStr"
        [ test "returns SPN as a string" <|
            \_ ->
                Expect.equal "E2" (pitchNotationToStr ( "E", 2 ))
        , test "returns SPN with sharps/flats as flats" <|
            \_ ->
                Expect.equal "Bb2" (pitchNotationToStr ( "A#/Bb", 2 ))
        ]


testGetNoteNameByIndex : Test
testGetNoteNameByIndex =
    describe "getNoteNameByIndex"
        [ test "returns 'A' for 0" <|
            \_ ->
                Expect.equal "A" (getNoteNameByIndex 0)
        , test "returns 'B' for 2" <|
            \_ ->
                Expect.equal "B" (getNoteNameByIndex 2)
        , test "returns 'C' for 3" <|
            \_ ->
                Expect.equal "C" (getNoteNameByIndex 3)
        , test "returns 'E' for 7" <|
            \_ ->
                Expect.equal "E" (getNoteNameByIndex 7)
        , test "returns 'F' for 8" <|
            \_ ->
                Expect.equal "F" (getNoteNameByIndex 8)
        , test "returns 'Err!' for out of range" <|
            \_ ->
                Expect.equal "Err!" (getNoteNameByIndex 100)
        ]


testGetScaleNotes : Test
testGetScaleNotes =
    describe "getScaleNotes"
        [ test "returns notes for C Major" <|
            \_ ->
                Expect.equal [ "C", "D", "E", "F", "G", "A", "B" ] (getScaleNotes "C" Music.Major)
        , test "returns notes for C Minor Pentatonic" <|
            \_ ->
                Expect.equal [ "C", "D#/Eb", "F", "G", "A#/Bb" ] (getScaleNotes "C" Music.MinorPentatonic)
        , test "returns notes for D Major Pentatonic" <|
            \_ ->
                Expect.equal [ "D", "E", "F#/Gb", "A", "B" ] (getScaleNotes "D" Music.MajorPentatonic)
        , test "returns notes for E Minor" <|
            \_ ->
                Expect.equal [ "E", "F#/Gb", "G", "A", "B", "C", "D" ] (getScaleNotes "E" Music.Minor)
        , test "returns notes for F Dorian" <|
            \_ ->
                Expect.equal [ "F", "G", "G#/Ab", "A#/Bb", "C", "D", "D#/Eb" ] (getScaleNotes "F" Music.Dorian)
        , test "returns notes for G Phrygian" <|
            \_ ->
                Expect.equal [ "G", "G#/Ab", "A#/Bb", "C", "D", "D#/Eb", "F" ] (getScaleNotes "G" Music.Phrygian)
        , test "returns notes for A Lydian" <|
            \_ ->
                Expect.equal [ "A", "B", "C#/Db", "D#/Eb", "E", "F#/Gb", "G#/Ab" ] (getScaleNotes "A" Music.Lydian)
        , test "returns notes for B Mixolydian" <|
            \_ ->
                Expect.equal [ "B", "C#/Db", "D#/Eb", "E", "F#/Gb", "G#/Ab", "A" ] (getScaleNotes "B" Music.Mixolydian)

        -- , test "returns notes for C# Locrian" <|
        --     \_ ->
        --         Expect.equal [ "C#/Db", "D", "E", "F#/Gb", "G", "A", "B" ] (getScaleNotes "C#/Bb" Music.Locrian)
        ]
