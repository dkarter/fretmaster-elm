module Main exposing (init, main, update, view)

import Array
import Browser
import Debug exposing (log)
import Fretboard
import Guitar exposing (GuitarNote)
import Html exposing (Html, button, div, h1, img, input, label, span, text)
import Html.Attributes exposing (checked, class, classList, src, type_)
import Html.Events exposing (onCheck, onClick)
import Model exposing (Model)
import Msg exposing (Msg(..))
import Random



---- MODEL ----


init : ( Model, Cmd Msg )
init =
    ( { selectedGuitarNote = Guitar.createGuitarNote 6 0
      , selectedGuitarNoteOctaves = []
      , showNoteInfo = True
      , showOctaves = True
      }
    , Cmd.none
    )


randomString : Random.Generator Int
randomString =
    Random.int 1 6


randomFret : Random.Generator Int
randomFret =
    Random.int 1 12


pickRandomNote =
    Random.map2 Guitar.createGuitarNote randomString randomFret



---- UPDATE ----


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GuitarNoteClicked stringNum fretNum ->
            let
                guitarNote =
                    Guitar.createGuitarNote stringNum fretNum

                octaves =
                    if model.showOctaves then
                        Guitar.findAllOctaves guitarNote.noteName 12

                    else
                        []
            in
            ( { model
                | selectedGuitarNote = guitarNote
                , selectedGuitarNoteOctaves = octaves
                , showNoteInfo = True
              }
            , Cmd.none
            )

        PickRandomNote ->
            ( model, Random.generate RandomGuitarNoteSelected pickRandomNote )

        RandomGuitarNoteSelected guitarNote ->
            ( { model
                | selectedGuitarNote = guitarNote
                , selectedGuitarNoteOctaves = []
                , showNoteInfo = False
              }
            , Cmd.none
            )

        ShowNoteInfo ->
            ( { model | showNoteInfo = True }, Cmd.none )

        ShowOctavesChanged value ->
            ( { model | showOctaves = value }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )



---- VIEW ----


renderHeader : Html Msg
renderHeader =
    h1 [] [ text "Elm Fretboard" ]


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
        [ renderHeader
        , Fretboard.render model
        , renderGameControls model
        , renderSelectedNote model
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
