module Menu exposing (render)

import AudioPorts
import Game exposing (GameMode(..))
import Html exposing (Html, a, li, text, ul)
import Html.Attributes exposing (class, classList)
import Html.Events exposing (onClick)
import Model exposing (Model)
import Msg exposing (Msg(..))


render : Model -> Html Msg
render model =
    let
        activeClass mode =
            classList [ ( "active", model.gameMode == mode ) ]
    in
    ul [ class "menu" ]
        [ li [ activeClass Learn, onClick (ChangeGameMode Learn) ] [ text "Learn" ]
        , li [ activeClass GuessNotes, onClick (ChangeGameMode GuessNotes) ] [ text "Guess" ]
        , li [ activeClass GuessChord, onClick (ChangeGameMode GuessChord) ] [ text "Guess Chord" ]
        , li [ activeClass ShowChord, onClick (ChangeGameMode ShowChord) ] [ text "Show Chord" ]
        ]
