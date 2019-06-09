module Pages.LearnNotesPage exposing (render)

import Fretboard
import Game exposing (GameMode(..))
import Guitar
import Html exposing (Html, div)
import Html.Attributes exposing (class)
import LearnNotesGame exposing (LearnNotesGame)
import LearnNotesGameControls
import Msg exposing (Msg(..))


handleNoteClicked : LearnNotesGame -> Guitar.GuitarNote -> Msg
handleNoteClicked gameState note =
    UpdateGameState (LearnNotes (LearnNotesGame.setSelectedGuitarNote gameState note))


renderFretboard gameState =
    Fretboard.fretboard
        |> Fretboard.withOnClick (handleNoteClicked gameState)
        |> Fretboard.withHighlightedNotes (LearnNotesGame.getHighlightedGuitarNotes gameState)
        |> Fretboard.withNotesClickable True
        |> Fretboard.withNoteNameVisible True
        |> Fretboard.toHtml


render : LearnNotesGame -> Html Msg
render gameState =
    div [ class "body" ]
        [ renderFretboard gameState
        , div [ class "game-controls learn-notes" ] (LearnNotesGameControls.render gameState)
        ]
