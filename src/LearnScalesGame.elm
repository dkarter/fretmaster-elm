module LearnScalesGame exposing (LearnScalesGame, init)

import Music
import Music.Scale as Scale exposing (Scale)
import Music.ScaleClass as ScaleClass exposing (ScaleClass)


type LearnScalesGame
    = LearnScalesGame { scale : Scale }


aMajor : Scale
aMajor =
    Scale.build "A" ScaleClass.major


init : LearnScalesGame
init =
    LearnScalesGame { scale = aMajor }
