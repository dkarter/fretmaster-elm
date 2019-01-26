module Guitar exposing
    ( GuitarNote
    , createGuitarNote
    , findAllOctaves
    , getGuitarNoteName
    , getGuitarNoteWithPitch
    , getGuitarStringName
    , guitarStrings
    , guitarStringsWithPitches
    , isMarkerFret
    , playNoteAudio
    )

import Array
import AudioPorts
import List.Extra exposing (elemIndex)
import Maybe exposing (withDefault)
import Music exposing (Note, ScientificPitchNotation)


type alias GuitarNote =
    { stringNum : Int
    , fretNum : Int
    , stringName : Note
    , noteName : Note
    , scientificPitchNotation : ScientificPitchNotation
    }


createGuitarNote : Int -> Int -> GuitarNote
createGuitarNote stringNum fretNum =
    { stringNum = stringNum
    , fretNum = fretNum
    , stringName = getGuitarStringName stringNum
    , noteName = getGuitarNoteName stringNum fretNum
    , scientificPitchNotation = getGuitarNoteWithPitch stringNum fretNum
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


guitarStringPitches : List Int
guitarStringPitches =
    [ 4, 3, 3, 3, 2, 2 ]


guitarStringsWithPitches : List ScientificPitchNotation
guitarStringsWithPitches =
    List.map2 Tuple.pair guitarStrings guitarStringPitches


getGuitarNoteWithPitch : Int -> Int -> ScientificPitchNotation
getGuitarNoteWithPitch stringNum fretNum =
    let
        octaveCountInRange =
            List.range 0 fretNum
                |> List.filter (\fret -> getGuitarNoteName stringNum fret == "C")
                |> List.length

        stringPitch =
            guitarStringsWithPitches
                |> Array.fromList
                |> Array.get (stringNum - 1)
                |> withDefault ( "E", -1000 )

        pitch =
            Tuple.second stringPitch + octaveCountInRange

        noteName =
            getGuitarNoteName stringNum fretNum
    in
    ( noteName, pitch )


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


playNoteAudio : GuitarNote -> Cmd msg
playNoteAudio guitarNote =
    guitarNote.scientificPitchNotation
        |> Music.pitchNotationToStr
        |> AudioPorts.playNote
