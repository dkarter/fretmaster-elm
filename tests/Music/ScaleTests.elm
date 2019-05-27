module Music.ScaleTests exposing (testNotes)

import Expect
import Music.Scale as Scale
import Music.ScaleClass
    exposing
        ( dorian
        , locrian
        , lydian
        , major
        , majorPentatonic
        , minor
        , minorPentatonic
        , mixolydian
        , phrygian
        )
import Test exposing (..)


testNotes : Test
testNotes =
    describe "notes"
        [ test "returns notes for C Major" <|
            \_ ->
                let
                    scaleNotes =
                        Scale.build "C" major |> Scale.notes
                in
                Expect.equal [ "C", "D", "E", "F", "G", "A", "B" ] scaleNotes
        , test "returns notes for C Minor Pentatonic" <|
            \_ ->
                let
                    scaleNotes =
                        Scale.build "C" minorPentatonic |> Scale.notes
                in
                Expect.equal [ "C", "D#/Eb", "F", "G", "A#/Bb" ] scaleNotes
        , test "returns notes for D Major Pentatonic" <|
            \_ ->
                let
                    scaleNotes =
                        Scale.build "D" majorPentatonic |> Scale.notes
                in
                Expect.equal [ "D", "E", "F#/Gb", "A", "B" ] scaleNotes
        , test "returns notes for E Minor" <|
            \_ ->
                let
                    scaleNotes =
                        Scale.build "E" minor |> Scale.notes
                in
                Expect.equal [ "E", "F#/Gb", "G", "A", "B", "C", "D" ] scaleNotes
        , test "returns notes for F Dorian" <|
            \_ ->
                let
                    scaleNotes =
                        Scale.build "F" dorian |> Scale.notes
                in
                Expect.equal [ "F", "G", "G#/Ab", "A#/Bb", "C", "D", "D#/Eb" ] scaleNotes
        , test "returns notes for G Phrygian" <|
            \_ ->
                let
                    scaleNotes =
                        Scale.build "G" phrygian |> Scale.notes
                in
                Expect.equal [ "G", "G#/Ab", "A#/Bb", "C", "D", "D#/Eb", "F" ] scaleNotes
        , test "returns notes for A Lydian" <|
            \_ ->
                let
                    scaleNotes =
                        Scale.build "A" lydian |> Scale.notes
                in
                Expect.equal [ "A", "B", "C#/Db", "D#/Eb", "E", "F#/Gb", "G#/Ab" ] scaleNotes
        , test "returns notes for B Mixolydian" <|
            \_ ->
                let
                    scaleNotes =
                        Scale.build "B" mixolydian |> Scale.notes
                in
                Expect.equal [ "B", "C#/Db", "D#/Eb", "E", "F#/Gb", "G#/Ab", "A" ] scaleNotes
        , test "returns notes for C# Locrian" <|
            \_ ->
                let
                    scaleNotes =
                        Scale.build "C#/Db" locrian |> Scale.notes
                in
                Expect.equal [ "C#/Db", "D", "E", "F#/Gb", "G", "A", "B" ] scaleNotes
        ]
