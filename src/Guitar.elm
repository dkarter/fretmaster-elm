module Guitar exposing (GuitarNote, getGuitarNoteName, getGuitarStringName, isMarkerFret)

import Array
import List.Extra exposing (elemIndex)
import Maybe exposing (withDefault)
import Music exposing (Note, getNoteNameByIndex, notes)


type alias GuitarNote =
    { stringNum : Int
    , fretNum : Int
    , stringName : Note
    , noteName : Note
    }


guitarStrings : List Note
guitarStrings =
    [ "E", "B", "G", "D", "A", "E" ]


getGuitarStringName : Int -> Note
getGuitarStringName num =
    let
        guitarString =
            guitarStrings
                |> Array.fromList
                |> Array.get (num - 1)
    in
    withDefault "" guitarString


markerFrets : List Int
markerFrets =
    [ 3, 5, 7, 9, 12 ]


isMarkerFret : Int -> Int -> Bool
isMarkerFret fretNum stringNum =
    stringNum == 3 && (markerFrets |> List.member fretNum)


getGuitarNoteName : Int -> Int -> Note
getGuitarNoteName stringNum fretNum =
    let
        stringName =
            getGuitarStringName stringNum

        stringNoteIndex =
            withDefault 0 (elemIndex stringName notes)

        virtualIndex =
            stringNoteIndex + fretNum

        remainder =
            remainderBy noteCount virtualIndex

        noteCount =
            notes |> List.length

        wholeCycles =
            floor (toFloat virtualIndex / toFloat noteCount)

        selectedNoteIndex =
            if virtualIndex >= noteCount then
                virtualIndex - wholeCycles * noteCount

            else
                virtualIndex
    in
    getNoteNameByIndex selectedNoteIndex
