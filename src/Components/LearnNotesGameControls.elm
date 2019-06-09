module LearnNotesGameControls exposing (render)

import Game exposing (GameMode(..))
import Html exposing (Html, label)
import Html.Attributes exposing (checked)
import Html.Events exposing (onCheck)
import LearnNotesGame exposing (LearnNotesGame)
import Model exposing (Model)
import Msg exposing (Msg(..))
import SelectedNote
import Toggle


handleShowOctavesChecked : LearnNotesGame -> Bool -> Msg
handleShowOctavesChecked gameState value =
    UpdateGameState (LearnNotes (LearnNotesGame.setShowOctaves gameState value))


render : LearnNotesGame -> List (Html Msg)
render gameState =
    [ Toggle.render "Show Octaves"
        [ onCheck (handleShowOctavesChecked gameState)
        , checked (LearnNotesGame.getShowOctaves gameState)
        ]
    , SelectedNote.render (LearnNotesGame.getSelectedGuitarNote gameState)
    ]
