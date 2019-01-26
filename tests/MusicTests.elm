module MusicTests exposing (testGetNoteNameByIndex, testPitchNotationToStr)

import Expect
import Music exposing (getNoteNameByIndex, pitchNotationToStr)
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
    describe "testGetNoteNameByIndex"
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
