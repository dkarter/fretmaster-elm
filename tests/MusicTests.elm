module MusicTests exposing (testGetIndexByNoteName, testGetNoteNameByIndex)

import Expect
import Music exposing (getIndexByNoteName, getNoteNameByIndex)
import Test exposing (..)


testGetIndexByNoteName : Test
testGetIndexByNoteName =
    describe "getIndexByNoteName"
        [ test "returns 0 for 'A'" <|
            \_ ->
                Expect.equal 0 (getIndexByNoteName "A")
        , test "returns 1 for 'A#/Bb'" <|
            \_ ->
                Expect.equal 1 (getIndexByNoteName "A#/Bb")
        , test "returns 3 for 'C'" <|
            \_ ->
                Expect.equal 3 (getIndexByNoteName "C")
        , test "returns -1 for invalid note" <|
            \_ ->
                Expect.equal -1 (getIndexByNoteName "nonesense")
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
