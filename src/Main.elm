module Main exposing (main, view)

import Array
import Browser
import Debug exposing (log)
import Fretboard
import Header
import Html exposing (Html, button, div, h1, img, input, label, span, text)
import Html.Attributes exposing (checked, class, classList, src, type_)
import Html.Events exposing (onCheck, onClick)
import Menu
import Model exposing (Model)
import Msg exposing (Msg(..))
import Update


renderGameControls : Model -> Html Msg
renderGameControls model =
    div [ class "game-controls" ]
        [ label []
            [ input
                [ checked model.showOctaves
                , type_ "checkbox"
                , onCheck ShowOctavesChanged
                ]
                []
            , text "Show Octaves"
            ]
        , button
            [ class "pick-note-btn", onClick PickRandomNote ]
            [ text "Pick Random Note" ]
        ]


renderSelectedNote : Model -> Html Msg
renderSelectedNote model =
    let
        selectedNote =
            model.selectedGuitarNote

        showNoteInfo =
            model.showNoteInfo
    in
    case showNoteInfo of
        False ->
            button [ class "show-answer-btn", onClick ShowNoteInfo ] [ text "Show Answer" ]

        True ->
            div [ class "selected-note-info" ]
                [ div [ class "title" ] [ text "Selected Note:" ]
                , div [ class "note-name" ]
                    [ text selectedNote.noteName
                    ]
                , div [ class "string-name" ]
                    [ span [ class "label" ] [ text "String:" ]
                    , text selectedNote.stringName
                    ]
                , div [ class "string-num" ]
                    [ span [ class "label" ] [ text "String #:" ]
                    , text (String.fromInt selectedNote.stringNum)
                    ]
                , div [ class "fret-num" ]
                    [ span [ class "label" ] [ text "Fret #:" ]
                    , text (String.fromInt selectedNote.fretNum)
                    ]
                ]


view : Model -> Html Msg
view model =
    div [ class "main" ]
        [ Header.render
        , Menu.render
        , Fretboard.render model
        , renderGameControls model
        , renderSelectedNote model
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> Model.init
        , update = Update.update
        , subscriptions = always Sub.none
        }
