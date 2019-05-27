module LearnScalesPage exposing (render)

import Fretboard
import Html exposing (Html, div, text)
import Html.Attributes exposing (class)
import Model exposing (Model)
import Msg exposing (Msg(..))


render : Model -> Html Msg
render model =
    div [ class "body" ]
        [ Fretboard.render model
        , div [ class "game-controls guess-notes" ] [ text "Scale selection goes here" ]
        ]
