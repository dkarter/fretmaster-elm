module Model exposing (Model, asGuessNotesGameIn, asLearnNotesGameIn, asLearnScalesGameIn, init)

import AudioPorts
import Game exposing (GameMode(..))
import GuessNotesGame exposing (GuessNotesGame)
import LearnNotesGame exposing (LearnNotesGame)
import LearnScalesGame exposing (LearnScalesGame)
import Msg exposing (Msg)


asLearnNotesGameIn : Model -> LearnNotesGame -> Model
asLearnNotesGameIn model gameState =
    { model | gameMode = LearnNotes gameState }


asGuessNotesGameIn : Model -> GuessNotesGame -> Model
asGuessNotesGameIn model gameState =
    { model | gameMode = GuessNotes gameState }


asLearnScalesGameIn : Model -> LearnScalesGame -> Model
asLearnScalesGameIn model gameState =
    { model | gameMode = LearnScales gameState }


type alias Model =
    { gameMode : GameMode }


init : ( Model, Cmd Msg )
init =
    ( { gameMode = Game.LearnNotes LearnNotesGame.init }, AudioPorts.requestLoadSoundFont "/soundfonts" )
