module Music exposing (Note, PitchNotation, getIndexByNoteName, getNoteNameByIndex, notes, pitchNotationToStr)

import Array
import List.Extra
import Maybe exposing (withDefault)
import Music.ScaleClass exposing (ScaleClass)
import Utils


type alias Note =
    String


type alias PitchNotation =
    ( String, Int )


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
