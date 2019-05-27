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
        [ li [ activeClass LearnNotes, onClick (ChangeGameMode LearnNotes) ] [ text "Learn Notes" ]
        , li [ activeClass GuessNotes, onClick (ChangeGameMode GuessNotes) ] [ text "Guess" ]
        , li [ activeClass LearnScales, onClick (ChangeGameMode LearnScales) ] [ text "Learn Scales" ]
        ]
