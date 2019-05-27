module Music.IntervalTests exposing (testIntervalFromString)

import Expect
import Music.Interval as Interval
import Test exposing (..)


testIntervalFromString : Test
testIntervalFromString =
    describe "intervalFromString"
        [ test "returns an interval" <|
            \_ ->
                let
                    interval =
                        Interval.fromString "b3"

                    intervalValue =
                        Interval.toValue interval

                    intervalString =
                        Interval.toString interval
                in
                Expect.equal ( intervalString, intervalValue ) ( "b3", 3 )
        ]
