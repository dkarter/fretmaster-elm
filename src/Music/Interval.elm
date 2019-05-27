module Music.Interval exposing (Interval, fromString, toString, toValue)

import Dict


type Interval
    = Interval
        { stringForm : String
        , numericDelta : Int
        }


intervals =
    Dict.fromList
        [ ( "1", 0 )
        , ( "b2", 1 )
        , ( "2", 2 )
        , ( "b3", 3 )
        , ( "3", 4 )
        , ( "4", 5 )
        , ( "#4", 6 )
        , ( "b5", 6 )
        , ( "5", 7 )
        , ( "#5", 8 )
        , ( "b6", 8 )
        , ( "6", 9 )
        , ( "b7", 10 )
        , ( "7", 11 )
        ]


fromString : String -> Interval
fromString str =
    Interval
        { stringForm = str
        , numericDelta = parseIntervalString str
        }


toString : Interval -> String
toString (Interval { stringForm }) =
    stringForm


toValue : Interval -> Int
toValue (Interval { numericDelta }) =
    numericDelta


parseIntervalString : String -> Int
parseIntervalString str =
    case Dict.get str intervals of
        Just value ->
            value

        Nothing ->
            -1
