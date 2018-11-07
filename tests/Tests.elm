module Tests exposing (testGetGuitarNoteName, testGetGuitarStringName)

import Expect
import Main exposing (getGuitarNoteName, getGuitarStringName)
import Test exposing (..)



-- Check out http://package.elm-lang.org/packages/elm-community/elm-test/latest to learn more about testing in Elm!


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
