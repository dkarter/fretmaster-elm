module GuitarChord exposing
    ( GuitarChord
    , StringSet(..)
    , chordQualityIntervals
    , stringSetLabel
    , stringSets
    )

import Chord exposing (Quality(..), qualityToIntervals, tonesCount)
import Interval exposing (Interval(..))
import List exposing (length, map)
import List.Extra exposing (getAt)
import Maybe


type StringSet
    = FirstSetFour
    | SecondSetFour
    | ThirdSetFour
    | FirstSetBrokenFour
    | SecondSetBrokenFour


stringSets : List StringSet
stringSets =
    [ FirstSetFour, SecondSetFour, ThirdSetFour, FirstSetBrokenFour, SecondSetBrokenFour ]


stringSetLabel : StringSet -> String
stringSetLabel stringSet =
    case stringSet of
        FirstSetFour ->
            "1|4"

        SecondSetFour ->
            "2|4"

        ThirdSetFour ->
            "3|4"

        FirstSetBrokenFour ->
            "1|B4"

        SecondSetBrokenFour ->
            "2|B4"


type alias GuitarChord =
    { rootNote : String
    , quality : Quality
    , inversion : Int
    , stringSet : StringSet
    }


nextIntervalIndex : Int -> Int -> Maybe Int -> Maybe Int
nextIntervalIndex interval max index =
    case index of
        Nothing ->
            Nothing

        Just idx ->
            Just (modBy max (idx + interval))


intervalFromIndex : List Interval -> Maybe Int -> Maybe Interval
intervalFromIndex intervals index =
    case index of
        Nothing ->
            Nothing

        Just idx ->
            getAt idx intervals


takeInversion : Int -> List Interval -> ( List (Maybe Int), Int ) -> List (Maybe Interval)
takeInversion inversion intervals ( indices, numNotes ) =
    let
        intervalIndices =
            map (nextIntervalIndex inversion numNotes) indices
    in
    map (intervalFromIndex intervals) intervalIndices


noNotes =
    [ Nothing, Nothing, Nothing, Nothing, Nothing, Nothing ]


chordQualityIntervals : StringSet -> Quality -> Int -> List (Maybe Interval)
chordQualityIntervals stringSet quality inversion =
    let
        indices =
            case stringSet of
                FirstSetFour ->
                    ( [ Just 0, Just 2, Just 3, Just 1, Nothing, Nothing ], tonesCount quality )

                SecondSetFour ->
                    ( [ Nothing, Just 0, Just 2, Just 3, Just 1, Nothing ], tonesCount quality )

                ThirdSetFour ->
                    ( [ Nothing, Nothing, Just 0, Just 2, Just 3, Just 1 ], tonesCount quality )

                FirstSetBrokenFour ->
                    ( [ Just 0, Nothing, Just 3, Just 1, Just 2, Nothing ], tonesCount quality )

                SecondSetBrokenFour ->
                    ( [ Nothing, Just 0, Nothing, Just 3, Just 1, Just 2 ], tonesCount quality )

        intervals =
            qualityToIntervals quality
    in
    case ( indices, intervals ) of
        ( _, [] ) ->
            noNotes

        ( ( [], _ ), _ ) ->
            noNotes

        _ ->
            takeInversion inversion intervals indices
