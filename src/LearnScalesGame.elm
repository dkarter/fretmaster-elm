module LearnScalesGame exposing (LearnScalesGame, getHighlightedGuitarNotes, init)

import Guitar
import HighlightedNotes exposing (HighlightedNotes)
import Music.Scale as Scale exposing (Scale)
import Music.ScaleClass as ScaleClass


type LearnScalesGame
    = LearnScalesGame
        { scale : Scale
        , showOctaves : Bool
        }


aMajor : Scale
aMajor =
    Scale.build "A" ScaleClass.major


aMinor : Scale
aMinor =
    Scale.build "A" ScaleClass.minor


getShowOctaves : LearnScalesGame -> Bool
getShowOctaves (LearnScalesGame { showOctaves }) =
    showOctaves


setShowOctaves : LearnScalesGame -> Bool -> LearnScalesGame
setShowOctaves (LearnScalesGame gameState) showOctaves =
    LearnScalesGame { gameState | showOctaves = showOctaves }


getScale : LearnScalesGame -> Scale
getScale (LearnScalesGame { scale }) =
    scale


setScale : LearnScalesGame -> Scale -> LearnScalesGame
setScale (LearnScalesGame gameState) scale =
    LearnScalesGame { gameState | scale = scale }


getHighlightedGuitarNotes : LearnScalesGame -> HighlightedNotes
getHighlightedGuitarNotes (LearnScalesGame { scale, showOctaves }) =
    let
        addHighlight guitarNote highlights =
            if guitarNote.noteName == key && showOctaves then
                HighlightedNotes.addOctave highlights guitarNote

            else
                HighlightedNotes.addNormalHighlight highlights guitarNote

        key =
            Scale.getKey scale

        scaleGuitarNotes =
            scale
                |> Scale.notes
                |> List.map (\note -> Guitar.findAllOctaves note 12)
                |> List.concat
    in
    List.foldl addHighlight HighlightedNotes.empty scaleGuitarNotes


init : LearnScalesGame
init =
    LearnScalesGame
        { scale = aMinor
        , showOctaves = False
        }
