module Music exposing (Note, PitchNotation, ScaleType(..), getNoteNameByIndex, getScaleNotes, notes, pitchNotationToStr)

import Array
import List.Extra
import Maybe exposing (withDefault)
import Utils


type alias Note =
    String


type alias Interval =
    String


type alias PitchNotation =
    ( String, Int )


type ScaleType
    = Major
    | Minor
    | Dorian
    | Phrygian
    | Lydian
    | Mixolydian
      -- | Locrian
    | HarmonicMinor
    | MelodicMinor
    | MajorPentatonic
    | MinorPentatonic


scaleFormula : ScaleType -> List Interval
scaleFormula scaleType =
    case scaleType of
        Major ->
            [ "1", "2", "3", "4", "5", "6", "7" ]

        Minor ->
            [ "1", "2", "b3", "4", "5", "b6", "b7" ]

        Dorian ->
            [ "1", "2", "b3", "4", "5", "6", "b7" ]

        Phrygian ->
            [ "1", "b2", "b3", "4", "5", "b6", "b7" ]

        Lydian ->
            [ "1", "2", "3", "#4", "5", "6", "7" ]

        Mixolydian ->
            [ "1", "2", "3", "4", "5", "6", "b7" ]

        -- Locrian ->
        --     [ "1", "b2", "b3", "4", "b5", "b6", "b7" ]
        MajorPentatonic ->
            [ "1", "2", "3", "5", "6" ]

        MinorPentatonic ->
            [ "1", "b3", "4", "5", "b7" ]

        _ ->
            -- not implemented yet
            []


intervalToInt : Interval -> Int
intervalToInt interval =
    [ "1", "b2", "2", "b3", "3", "4", "#4", "5", "b6", "6", "b7", "7" ]
        |> List.Extra.elemIndex interval
        |> Maybe.withDefault -1


getScaleNotes : Note -> ScaleType -> List Note
getScaleNotes key scaleType =
    let
        formula =
            scaleFormula scaleType

        keyIndex =
            getIndexByNoteName key

        intervalToNote interval =
            getNoteNameByIndex (Utils.getWrappedIndex notes (intervalToInt interval + keyIndex))
    in
    formula
        |> List.map intervalToNote


notes : List Note
notes =
    [ "A", "A#/Bb", "B", "C", "C#/Db", "D", "D#/Eb", "E", "F", "F#/Gb", "G", "G#/Ab" ]


pitchNotationToStr : PitchNotation -> String
pitchNotationToStr spn =
    let
        normalizedNoteName =
            spn
                |> Tuple.first
                |> String.split "/"
                |> List.reverse
                |> List.head
                |> withDefault "ERROR!"

        pitchString =
            spn
                |> Tuple.second
                |> String.fromInt
    in
    [ normalizedNoteName, pitchString ]
        |> String.join ""


getIndexByNoteName : Note -> Int
getIndexByNoteName note =
    let
        index =
            notes
                |> List.Extra.elemIndex note
    in
    withDefault -1 index


getNoteNameByIndex : Int -> Note
getNoteNameByIndex index =
    let
        noteName =
            notes
                |> Array.fromList
                |> Array.get index
    in
    withDefault "Err!" noteName
