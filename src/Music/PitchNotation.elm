module Music.PitchNotation exposing (PitchNotation, build, getPitch, toString)

import Maybe
import Music


type PitchNotation
    = PitchNotation ( Music.Note, Int )


build : Music.Note -> Int -> PitchNotation
build note pitch =
    PitchNotation ( note, pitch )


getPitch : PitchNotation -> Int
getPitch (PitchNotation ( _, pitch )) =
    pitch


toString : PitchNotation -> String
toString (PitchNotation ( note, pitch )) =
    let
        normalizedNoteName =
            note
                |> String.split "/"
                |> List.reverse
                |> List.head
                |> Maybe.withDefault "ERROR!"

        pitchString =
            pitch
                |> String.fromInt
    in
    [ normalizedNoteName, pitchString ]
        |> String.join ""
