module Chord exposing
    ( Chord, Quality(..)
    , chord, inversion1
    , qualityToIntervals, tonesCount
    )

{-| This module provides types and functions to create and
manipulate chords.


# Types

@docs Chord, Quality


# Chord generation

@docs chord, inversion1

-}

import Interval exposing (Interval(..), addInterval)
import ListUtils exposing (rotateR)
import Note exposing (newNote)
import Tone exposing (Tone)


{-| Chord represents a list of tones composing it
-}
type alias Chord =
    List Tone


{-| Quality represents the quality of a scale.
-}
type Quality
    = MajorTriad
    | MinorTriad
    | AugmentedTriad
    | DiminishedTriad
    | Seventh
    | MajorSeventh
    | MinorMajorSeventh
    | MinorSeventh
    | AugmentedMajorSeventh
    | AugmentedSeventh
    | HalfDiminishedSeventh
    | DiminishedSeventh
    | SeventhFlatFive


{-| Given a Tone and a Quality, generates the tones
composing a chord.

    (==)
        chord
        (newTone C Natural)
        MajorTriad
        [ { key = C, adjustment = Natural }
        , { key = E, adjustment = Natural }
        , { key = G, adjustment = Natural }
        ]

-}
chord : Tone -> Quality -> Chord
chord tone quality =
    let
        placeholderNote =
            newNote tone.key tone.adjustment 3
    in
    List.map (\i -> (addInterval placeholderNote i).tone) (qualityToIntervals quality)


{-| inversion1 produces the first inversion of a given chord
-}
inversion1 : Tone -> Quality -> Chord
inversion1 tone quality =
    let
        placeholderNote =
            newNote tone.key tone.adjustment 3

        intervals =
            qualityToIntervals quality
    in
    List.map (\i -> (addInterval placeholderNote i).tone) <| rotateR <| qualityToIntervals quality


qualityToIntervals : Quality -> List Interval
qualityToIntervals quality =
    case quality of
        MajorTriad ->
            majorTriad

        MinorTriad ->
            minorTriad

        AugmentedTriad ->
            augmentedTriad

        DiminishedTriad ->
            diminishedTriad

        Seventh ->
            seventh

        MajorSeventh ->
            majorSeventh

        MinorMajorSeventh ->
            minorMajorSeventh

        MinorSeventh ->
            minorSeventh

        AugmentedMajorSeventh ->
            augmentedMajorSeventh

        AugmentedSeventh ->
            augmentedSeventh

        HalfDiminishedSeventh ->
            halfDiminishedSeventh

        DiminishedSeventh ->
            diminishedSeventh

        SeventhFlatFive ->
            seventhFlatFive


tonesCount : Quality -> Int
tonesCount q =
    case q of
        MajorTriad ->
            3

        MinorTriad ->
            3

        AugmentedTriad ->
            3

        DiminishedTriad ->
            3

        Seventh ->
            4

        MajorSeventh ->
            4

        MinorMajorSeventh ->
            4

        MinorSeventh ->
            4

        AugmentedMajorSeventh ->
            4

        AugmentedSeventh ->
            4

        HalfDiminishedSeventh ->
            4

        DiminishedSeventh ->
            4

        SeventhFlatFive ->
            4


majorTriad : List Interval
majorTriad =
    [ Interval.PerfectUnison
    , Interval.MajorThird
    , Interval.PerfectFifth
    ]


minorTriad : List Interval
minorTriad =
    [ Interval.PerfectUnison
    , Interval.MinorThird
    , Interval.PerfectFifth
    ]


augmentedTriad : List Interval
augmentedTriad =
    [ Interval.PerfectUnison
    , Interval.MajorThird
    , Interval.AugmentedFifth
    ]


diminishedTriad : List Interval
diminishedTriad =
    [ Interval.PerfectUnison
    , Interval.MinorThird
    , Interval.DiminishedFifth
    ]


seventh : List Interval
seventh =
    [ Interval.PerfectUnison
    , Interval.MajorThird
    , Interval.PerfectFifth
    , Interval.MinorSeventh
    ]


majorSeventh : List Interval
majorSeventh =
    [ Interval.PerfectUnison
    , Interval.MajorThird
    , Interval.PerfectFifth
    , Interval.MajorSeventh
    ]


minorMajorSeventh : List Interval
minorMajorSeventh =
    [ Interval.PerfectUnison
    , Interval.MinorThird
    , Interval.PerfectFifth
    , Interval.MajorSeventh
    ]


minorSeventh : List Interval
minorSeventh =
    [ Interval.PerfectUnison
    , Interval.MinorThird
    , Interval.PerfectFifth
    , Interval.MinorSeventh
    ]


augmentedMajorSeventh : List Interval
augmentedMajorSeventh =
    [ Interval.PerfectUnison
    , Interval.MajorThird
    , Interval.AugmentedFifth
    , Interval.MajorSeventh
    ]


augmentedSeventh : List Interval
augmentedSeventh =
    [ Interval.PerfectUnison
    , Interval.MajorThird
    , Interval.AugmentedFifth
    , Interval.MinorSeventh
    ]


halfDiminishedSeventh : List Interval
halfDiminishedSeventh =
    [ Interval.PerfectUnison
    , Interval.MinorThird
    , Interval.DiminishedFifth
    , Interval.MinorSeventh
    ]


diminishedSeventh : List Interval
diminishedSeventh =
    [ Interval.PerfectUnison
    , Interval.MinorThird
    , Interval.DiminishedFifth
    , Interval.DiminishedSeventh
    ]


seventhFlatFive : List Interval
seventhFlatFive =
    [ Interval.PerfectUnison
    , Interval.MajorThird
    , Interval.DiminishedFifth
    , Interval.MinorSeventh
    ]
