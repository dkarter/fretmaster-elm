module GuessNoteGameControls exposing (render)

import Html exposing (Html, button, div, text)
import Html.Attributes exposing (class, classList, disabled)
import Html.Events exposing (onClick)
import Maybe
import Model exposing (GuessState(..), Model)
import Msg exposing (Msg(..))
import Music


renderNoteButtons : List Music.Note -> Html Msg
renderNoteButtons guesses =
    let
        normalizedNoteName note =
            note
                |> String.split "/"
                |> List.head
                |> Maybe.withDefault ""

        classes note =
            classList
                [ ( "accidental", String.contains "/" note )
                ]

        renderNoteButton note =
            button
                [ class "note-button"
                , disablePreviousGuess note
                , onClick (GuessNoteButtonClicked note)
                , classes note
                ]
                [ text (normalizedNoteName note) ]

        noteButtons =
            let
                tail =
                    Music.notes |> List.take 3

                head =
                    Music.notes |> List.drop 3

                chromatic =
                    head ++ tail
            in
            chromatic
                |> List.map renderNoteButton

        disablePreviousGuess note =
            guesses
                |> List.member note
                |> disabled
    in
    div [ class "note-buttons" ] noteButtons


renderFeedback : Model -> Html Msg
renderFeedback model =
    case model.guessState of
        Correct ->
            div [ class "game-feedback correct" ]
                [ text "Correct!" ]

        Incorrect ->
            div [ class "game-feedback incorrect" ]
                [ text "WRONG!" ]

        NotSelected ->
            div [] []


render : Model -> List (Html Msg)
render model =
    [ renderFeedback model
    , renderNoteButtons model.guesses
    ]
