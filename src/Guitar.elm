module Guitar exposing
    ( GuitarNote
    , createGuitarNote
    , findAllOctaves
    , getGuitarNoteName
    , getGuitarStringName
    , guitarStrings
    , isMarkerFret
    )

import Array
import List.Extra exposing (elemIndex)
import Maybe exposing (withDefault)
import Music exposing (Note)


type alias GuitarNote =
    { stringNum : Int
    , fretNum : Int
    , stringName : Note
    , noteName : Note
    }


createGuitarNote : Int -> Int -> GuitarNote
createGuitarNote stringNum fretNum =
    { stringNum = stringNum
    , fretNum = fretNum
    , stringName = getGuitarStringName stringNum
    , noteName = getGuitarNoteName stringNum fretNum
    }


findAllOctaves : Note -> Int -> List GuitarNote
findAllOctaves note numberOfFrets =
    let
        findMatchingNotes ( stringIndex, _ ) =
            getAllStringNotes (stringIndex + 1) numberOfFrets
                |> List.filter (\n -> n.noteName == note)
    in
    guitarStrings
        |> Array.fromList
        |> Array.toIndexedList
        |> List.concatMap findMatchingNotes


guitarStrings : List Note
guitarStrings =
    [ "E", "B", "G", "D", "A", "E" ]


getAllStringNotes : Int -> Int -> List GuitarNote
getAllStringNotes stringNum numberOfFrets =
    List.range 0 numberOfFrets
        |> List.map (createGuitarNote stringNum)


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
    [ 1, 3, 5, 7, 9, 12, 15, 17, 19, 21, 24 ]


isMarkerFret : Int -> Int -> Bool
isMarkerFret fretNum stringNum =
    stringNum == 3 && (markerFrets |> List.member fretNum)


getGuitarNoteName : Int -> Int -> Note
getGuitarNoteName stringNum fretNum =
    let
        stringName =
            getGuitarStringName stringNum

        stringNoteIndex =
            withDefault 0 (elemIndex stringName Music.notes)

        virtualIndex =
            stringNoteIndex + fretNum

        remainder =
            remainderBy noteCount virtualIndex

        noteCount =
            Music.notes |> List.length

        wholeCycles =
            floor (toFloat virtualIndex / toFloat noteCount)

        selectedNoteIndex =
            if virtualIndex >= noteCount then
                virtualIndex - wholeCycles * noteCount

            else
                virtualIndex
    in
    Music.getNoteNameByIndex selectedNoteIndex
