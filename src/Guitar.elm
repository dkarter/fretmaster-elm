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
import Maybe
import Music exposing (Note)
import Music.PitchNotation as PitchNotation exposing (PitchNotation)
import Utils


type alias GuitarNote =
    { stringNum : Int
    , fretNum : Int
    , stringName : Note
    , noteName : Note
    , pitchNotation : PitchNotation
    }


createGuitarNote : Int -> Int -> GuitarNote
createGuitarNote stringNum fretNum =
    { stringNum = stringNum
    , fretNum = fretNum
    , stringName = getGuitarStringName stringNum
    , noteName = getGuitarNoteName stringNum fretNum
    , pitchNotation = getGuitarNoteWithPitch stringNum fretNum
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


guitarStringsWithPitches : List PitchNotation
guitarStringsWithPitches =
    List.map2 PitchNotation.build guitarStrings guitarStringPitches


getGuitarNoteWithPitch : Int -> Int -> PitchNotation
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
                |> Maybe.withDefault (PitchNotation.build "Err!" -1000)

        pitch =
            PitchNotation.getPitch stringPitch + octaveCountInRange

        noteName =
            getGuitarNoteName stringNum fretNum
    in
    PitchNotation.build noteName pitch


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
    Maybe.withDefault "" guitarString


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
            Maybe.withDefault 0 (elemIndex stringName Music.notes)

        virtualIndex =
            stringNoteIndex + fretNum

        selectedNoteIndex =
            Utils.getWrappedIndex Music.notes virtualIndex
    in
    Music.getNoteNameByIndex selectedNoteIndex


playNoteAudio : GuitarNote -> Cmd msg
playNoteAudio guitarNote =
    guitarNote.pitchNotation
        |> PitchNotation.toString
        |> AudioPorts.playNote
