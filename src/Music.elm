module Music exposing (Note, PitchNotation, getNoteNameByIndex, notes, pitchNotationToStr, toTone)

import Array
import Maybe exposing (withDefault)
import Tone exposing (Adjustment(..), Key(..), Tone)


type alias Note =
    String


type alias PitchNotation =
    ( String, Int )


notes : List Note
notes =
    [ "A", "A#/Bb", "B", "C", "C#/Db", "D", "D#/Eb", "E", "F", "F#/Gb", "G", "G#/Ab" ]


toTone : Note -> Maybe Tone
toTone note =
    case note of
        "A" ->
            Just { key = A, adjustment = Natural }

        "A#" ->
            Just { key = A, adjustment = Sharp }

        "A#/Bb" ->
            Just { key = A, adjustment = Sharp }

        "Bb" ->
            Just { key = B, adjustment = Flat }

        "B" ->
            Just { key = B, adjustment = Natural }

        "C" ->
            Just { key = C, adjustment = Natural }

        "C#" ->
            Just { key = C, adjustment = Sharp }

        "C#/Db" ->
            Just { key = C, adjustment = Sharp }

        "Db" ->
            Just { key = D, adjustment = Flat }

        "D" ->
            Just { key = D, adjustment = Natural }

        "D#" ->
            Just { key = D, adjustment = Sharp }

        "D#/Eb" ->
            Just { key = D, adjustment = Sharp }

        "Eb" ->
            Just { key = E, adjustment = Flat }

        "E" ->
            Just { key = E, adjustment = Natural }

        "F" ->
            Just { key = F, adjustment = Natural }

        "F#" ->
            Just { key = F, adjustment = Sharp }

        "F#/Gb" ->
            Just { key = F, adjustment = Sharp }

        "Gb" ->
            Just { key = G, adjustment = Flat }

        "G" ->
            Just { key = G, adjustment = Natural }

        "G#" ->
            Just { key = G, adjustment = Sharp }

        "G#/Ab" ->
            Just { key = G, adjustment = Sharp }

        "Ab" ->
            Just { key = A, adjustment = Flat }

        _ ->
            Nothing


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
