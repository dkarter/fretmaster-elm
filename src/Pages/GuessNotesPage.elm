module Pages.GuessNotesPage exposing (render)

import Fretboard
import GuessNoteGameControls
import GuessNotesGame exposing (GuessNotesGame)
import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Model exposing (Model)
import Msg exposing (Msg(..))


renderFretboard gameState =
    Fretboard.fretboard
        |> Fretboard.withHighlightedNotes (GuessNotesGame.getHighlightedGuitarNotes gameState)
        |> Fretboard.withNotesClickable True
        |> Fretboard.withNoteNameVisible True
        |> Debug.log "what what"
        |> Fretboard.toHtml


render : GuessNotesGame -> Html Msg
render gameState =
    div [ class "body" ]
        [ renderFretboard gameState
        , div [ class "game-controls guess-notes" ] (GuessNoteGameControls.render gameState)
        ]
