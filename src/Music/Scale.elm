module Music.Scale exposing (Scale, build, getKey, notes)

import Music
import Music.Interval as Interval exposing (Interval)
import Music.ScaleClass as ScaleClass exposing (ScaleClass)
import Utils


type Scale
    = Scale
        { key : Music.Note
        , class : ScaleClass
        }


build : String -> ScaleClass -> Scale
build key class =
    Scale { key = key, class = class }


getKey : Scale -> Music.Note
getKey (Scale { key }) =
    key


notes : Scale -> List Music.Note
notes (Scale { key, class }) =
    let
        keyIndex =
            Music.getIndexByNoteName key

        intervalToNote interval =
            Utils.getWrappedIndex Music.notes (Interval.toValue interval + keyIndex)
                |> Music.getNoteNameByIndex
    in
    class
        |> List.map intervalToNote
