module Pages.LearnNotesPage exposing (render)

import Fretboard
import Html exposing (Html, div)
import Html.Attributes exposing (class)
import LearnGameControls
import Model exposing (Model)
import Msg exposing (Msg(..))


render : Model -> Html Msg
render model =
    div [ class "body" ]
        [ Fretboard.render model
        , div [ class "game-controls learn-notes" ] (LearnGameControls.render model)
        ]
