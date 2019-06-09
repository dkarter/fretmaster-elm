module Pages.LearnScalesPage exposing (render)

import Fretboard
import Guitar
import Html exposing (Html, div, text)
import Html.Attributes exposing (class)
import LearnScalesGame exposing (LearnScalesGame)
import Model exposing (Model)
import Msg exposing (Msg(..))


renderFretboard gameState =
    Fretboard.fretboard
        |> Fretboard.withHighlightedNotes (LearnScalesGame.getHighlightedGuitarNotes gameState)
        |> Fretboard.withNotesClickable True
        |> Fretboard.withNoteNameVisible True
        |> Fretboard.toHtml


render : LearnScalesGame -> Html Msg
render gameState =
    div [ class "body" ]
        [ renderFretboard gameState
        , div [ class "game-controls guess-notes" ] [ text "Scale selection goes here" ]
        ]
