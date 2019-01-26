module Music exposing (Note, PitchNotation, getNoteNameByIndex, notes, pitchNotationToStr)

import Array
import Maybe exposing (withDefault)


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


getNoteNameByIndex : Int -> Note
getNoteNameByIndex index =
    let
        noteName =
            notes
                |> Array.fromList
                |> Array.get index
    in
    withDefault "Err!" noteName
