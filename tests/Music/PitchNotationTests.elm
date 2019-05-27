module Music.PitchNotationTests exposing (testToString)

import Expect
import Music.PitchNotation as PitchNotation
import Test exposing (..)


testToString : Test
testToString =
    describe "toString"
        [ test "returns SPN as a string" <|
            \_ ->
                Expect.equal "E2" (PitchNotation.toString (PitchNotation.build "E" 2))
        , test "returns SPN with sharps/flats as flats" <|
            \_ ->
                Expect.equal "Bb2" (PitchNotation.toString (PitchNotation.build "A#/Bb" 2))
        ]
