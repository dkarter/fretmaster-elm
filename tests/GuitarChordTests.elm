module GuitarChordTests exposing (testChordQualityIntervals)

import Chord exposing (Quality(..))
import Expect
import GuitarChord exposing (chordQualityIntervals)
import Interval exposing (Interval(..))
import Test exposing (..)


testChordQualityIntervals : Test
testChordQualityIntervals =
    describe "chordQualityIntervals"
        [ test "returns drop 3 chord intervals" <|
            \_ ->
                Expect.equal
                    [ Just PerfectUnison
                    , Nothing
                    , Just Interval.MajorSeventh
                    , Just MajorThird
                    , Just PerfectFifth
                    , Nothing
                    ]
                    (chordQualityIntervals GuitarChord.FirstSetBrokenFour Chord.MajorSeventh 0)
        , test "returns drop 3 inversion" <|
            \_ ->
                Expect.equal
                    [ Just MajorThird
                    , Nothing
                    , Just PerfectUnison
                    , Just PerfectFifth
                    , Just Interval.MajorSeventh
                    , Nothing
                    ]
                    (chordQualityIntervals GuitarChord.FirstSetBrokenFour Chord.MajorSeventh 1)
        ]
