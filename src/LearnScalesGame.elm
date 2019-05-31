module LearnScalesGame exposing (LearnScalesGame, highlightedGuitarNotes, init)

import Guitar
import Music
import Music.Scale as Scale exposing (Scale)
import Music.ScaleClass as ScaleClass exposing (ScaleClass)


type LearnScalesGame
    = LearnScalesGame { scale : Scale }


aMajor : Scale
aMajor =
    Scale.build "A" ScaleClass.major


highlightedGuitarNotes : LearnScalesGame -> Guitar.HighlightedNotes
highlightedGuitarNotes (LearnScalesGame { scale }) =
    scale
        |> Scale.notes
        |> List.map (\note -> Guitar.findAllOctaves note 12)
        |> List.concat
        |> List.map (\note -> ( Guitar.Normal, note ))


init : LearnScalesGame
init =
    LearnScalesGame { scale = aMajor }
