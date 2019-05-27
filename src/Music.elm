module Music exposing (Note, getIndexByNoteName, getNoteNameByIndex, notes)

import Array
import List.Extra
import Maybe
import Music.ScaleClass exposing (ScaleClass)
import Utils


type alias Note =
    String


notes : List Note
notes =
    [ "A", "A#/Bb", "B", "C", "C#/Db", "D", "D#/Eb", "E", "F", "F#/Gb", "G", "G#/Ab" ]


getIndexByNoteName : Note -> Int
getIndexByNoteName note =
    let
        index =
            notes
                |> List.Extra.elemIndex note
    in
    Maybe.withDefault -1 index


getNoteNameByIndex : Int -> Note
getNoteNameByIndex index =
    let
        noteName =
            notes
                |> Array.fromList
                |> Array.get index
    in
    Maybe.withDefault "Err!" noteName
