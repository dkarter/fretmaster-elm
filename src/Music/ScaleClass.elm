module Music.ScaleClass exposing
    ( ScaleClass
    , dorian
    , locrian
    , lydian
    , major
    , majorPentatonic
    , minor
    , minorPentatonic
    , mixolydian
    , phrygian
    )

import Music.Interval as Interval exposing (Interval)


type alias ScaleClass =
    List Interval



-- SCALES --


major : ScaleClass
major =
    build [ "1", "2", "3", "4", "5", "6", "7" ]


minor : ScaleClass
minor =
    build [ "1", "2", "b3", "4", "5", "b6", "b7" ]


dorian : ScaleClass
dorian =
    build [ "1", "2", "b3", "4", "5", "6", "b7" ]


phrygian : ScaleClass
phrygian =
    build [ "1", "b2", "b3", "4", "5", "b6", "b7" ]


lydian : ScaleClass
lydian =
    build [ "1", "2", "3", "#4", "5", "6", "7" ]


mixolydian : ScaleClass
mixolydian =
    build [ "1", "2", "3", "4", "5", "6", "b7" ]


locrian : ScaleClass
locrian =
    build [ "1", "b2", "b3", "4", "b5", "b6", "b7" ]


majorPentatonic : ScaleClass
majorPentatonic =
    build [ "1", "2", "3", "5", "6" ]


minorPentatonic : ScaleClass
minorPentatonic =
    build [ "1", "b3", "4", "5", "b7" ]



-- PRIVATE --


build : List String -> ScaleClass
build formula =
    formula
        |> List.map Interval.fromString
