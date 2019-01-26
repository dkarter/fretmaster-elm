module Menu exposing (render)

import AudioPorts
import Game exposing (GameMode(..))
import Html exposing (Html, a, li, text, ul)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Msg exposing (Msg(..))


render : Html Msg
render =
    ul [ class "menu" ]
        [ li [] [ a [ onClick (ChangeGameMode Learn) ] [ text "Learn" ] ]
        , li [] [ a [ onClick (ChangeGameMode GuessNotes) ] [ text "Guess" ] ]
        , li [] [ a [ onClick (ChangeGameMode FindNotes) ] [ text "Find" ] ]
        ]
