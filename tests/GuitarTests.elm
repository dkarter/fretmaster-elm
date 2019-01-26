module GuitarTests exposing
    ( testCreateGuitarNote
    , testFindAllOctaves
    , testGetGuitarNoteName
    , testGetGuitarNoteWithPitch
    , testGetGuitarStringName
    , testGuitarStringsWithPitches
    )

import Expect
import Guitar
    exposing
        ( GuitarNote
        , createGuitarNote
        , findAllOctaves
        , getGuitarNoteName
        , getGuitarNoteWithPitch
        , getGuitarStringName
        , guitarStringsWithPitches
        )
import Test exposing (..)


testCreateGuitarNote : Test
testCreateGuitarNote =
    describe "createGuitarNote"
        [ test "returns a GuitarNote using the specified parameters" <|
            \_ ->
                Expect.equal (GuitarNote 3 4 "G" "B" ( "B", 3 )) (createGuitarNote 3 4)
        ]


testFindAllOctaves : Test
testFindAllOctaves =
    describe "findAllOctaves"
        [ test "returns all the octaves for D" <|
            \_ ->
                Expect.equal
                    [ createGuitarNote 1 10
                    , createGuitarNote 2 3
                    , createGuitarNote 3 7
                    , createGuitarNote 4 0
                    , createGuitarNote 4 12
                    , createGuitarNote 5 5
                    , createGuitarNote 6 10
                    ]
                    (findAllOctaves "D" 12)
        ]


testGetGuitarNoteWithPitch : Test
testGetGuitarNoteWithPitch =
    describe "getGuitarNoteWithPitch"
        [ test "returns notation for 2nd string, 1st fret" <|
            \_ ->
                Expect.equal ( "C", 4 ) (getGuitarNoteWithPitch 2 1)
        , test "returns notation for 2nd string, 3rd fret" <|
            \_ ->
                Expect.equal ( "D", 4 ) (getGuitarNoteWithPitch 2 3)
        , test "returns notation for 2nd string, 13th fret" <|
            \_ ->
                Expect.equal ( "C", 5 ) (getGuitarNoteWithPitch 2 13)
        , test "returns notation for 2nd string, 25th fret" <|
            \_ ->
                Expect.equal ( "C", 6 ) (getGuitarNoteWithPitch 2 25)
        , test "returns notation for 6th string, 0 fret" <|
            \_ ->
                Expect.equal ( "E", 2 ) (getGuitarNoteWithPitch 6 0)
        , test "returns notation for 6th string, 9th fret" <|
            \_ ->
                Expect.equal ( "C#/Db", 3 ) (getGuitarNoteWithPitch 6 9)
        , test "returns notation for 4th string, 0 fret" <|
            \_ ->
                Expect.equal ( "D", 3 ) (getGuitarNoteWithPitch 4 0)
        ]


testGuitarStringsWithPitches : Test
testGuitarStringsWithPitches =
    describe "guitarStringsWithPitches"
        [ test "returns guitar string with pitch notation" <|
            \_ ->
                Expect.equal
                    [ ( "E", 4 )
                    , ( "B", 3 )
                    , ( "G", 3 )
                    , ( "D", 3 )
                    , ( "A", 2 )
                    , ( "E", 2 )
                    ]
                    guitarStringsWithPitches
        ]


testGetGuitarStringName : Test
testGetGuitarStringName =
    describe "getGuitarStringName"
        [ test "returns 'E' for string 1" <|
            \_ ->
                Expect.equal "E" (getGuitarStringName 1)
        , test "returns 'B' for string 2" <|
            \_ ->
                Expect.equal "B" (getGuitarStringName 2)
        , test "returns 'G' for string 3" <|
            \_ ->
                Expect.equal "G" (getGuitarStringName 3)
        , test "returns 'D' for string 4" <|
            \_ ->
                Expect.equal "D" (getGuitarStringName 4)
        , test "returns 'A' for string 5" <|
            \_ ->
                Expect.equal "A" (getGuitarStringName 5)
        , test "returns 'E' for string 6" <|
            \_ ->
                Expect.equal "E" (getGuitarStringName 6)
        , test "returns empty string if string is not defined" <|
            \_ ->
                Expect.equal "" (getGuitarStringName 10)
        ]


testGetGuitarNoteName : Test
testGetGuitarNoteName =
    describe "getGuitarNoteName"
        [ test "returns 'E' for E string at fret 0" <|
            \_ ->
                Expect.equal "E" (getGuitarNoteName 1 0)
        , test "returns 'F' for E string at fret 1" <|
            \_ ->
                Expect.equal "F" (getGuitarNoteName 1 1)
        , test "returns 'A' for E string at fret 5" <|
            \_ ->
                Expect.equal "A" (getGuitarNoteName 6 5)
        , test "returns 'B' for E string at fret 7" <|
            \_ ->
                Expect.equal "B" (getGuitarNoteName 6 7)
        , test "returns 'D' for E string at fret 10" <|
            \_ ->
                Expect.equal "D" (getGuitarNoteName 6 10)
        ]
