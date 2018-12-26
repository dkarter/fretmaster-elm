module Main exposing (Model, Msg(..), init, main, update, view)

import Array
import Browser
import Debug exposing (log)
import Guitar exposing (GuitarNote, createGuitarNote, getGuitarStringName, isMarkerFret)
import Html exposing (Html, button, div, h1, img, span, text)
import Html.Attributes exposing (class, classList, src)
import Html.Events exposing (onClick)
import Music exposing (getNoteNameByIndex, notes)
import Random



---- MODEL ----


type alias Model =
    { selectedGuitarNote : GuitarNote, showNoteInfo : Bool }


init : ( Model, Cmd Msg )
init =
    ( { selectedGuitarNote = createGuitarNote 6 1, showNoteInfo = True }, Cmd.none )


isSelected : Model -> Int -> Int -> Bool
isSelected model stringNum fretNum =
    let
        selectedGuitarNote =
            model.selectedGuitarNote

        selectedFretNum =
            selectedGuitarNote.fretNum

        selectedStringNum =
            selectedGuitarNote.stringNum
    in
    selectedStringNum == stringNum && selectedFretNum == fretNum


randomString : Random.Generator Int
randomString =
    Random.int 1 6


randomFret : Random.Generator Int
randomFret =
    Random.int 1 12


pickRandomNote =
    Random.map2 createGuitarNote randomString randomFret



---- UPDATE ----


type Msg
    = GuitarNoteClicked Int Int
    | PickRandomNote
    | RandomGuitarNoteSelected GuitarNote
    | ShowNoteInfo
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GuitarNoteClicked stringNum fretNum ->
            ( { model | selectedGuitarNote = createGuitarNote stringNum fretNum, showNoteInfo = True }
            , Cmd.none
            )

        PickRandomNote ->
            ( model, Random.generate RandomGuitarNoteSelected pickRandomNote )

        RandomGuitarNoteSelected guitarNote ->
            ( { model | selectedGuitarNote = guitarNote, showNoteInfo = False }
            , Cmd.none
            )

        ShowNoteInfo ->
            ( { model | showNoteInfo = True }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )



---- VIEW ----


renderFrets : Model -> Int -> List (Html Msg)
renderFrets model stringNum =
    let
        renderFret fretNum =
            div [ classList [ ( "fret", True ), ( "fret-marker", isMarkerFret fretNum stringNum ) ] ]
                [ div
                    [ classList
                        [ ( "string-line", True )
                        , ( "selected", isSelected model stringNum fretNum )
                        ]
                    , onClick (GuitarNoteClicked stringNum fretNum)
                    ]
                    []
                ]
    in
    List.range 1 12
        |> List.map renderFret


renderStrings : Model -> List (Html Msg)
renderStrings model =
    List.range 1 6
        |> List.map (renderString model)


renderString : Model -> Int -> Html Msg
renderString model stringNum =
    div [ class "string-container" ]
        [ div [ class "string-name" ] [ text (getGuitarStringName stringNum) ]
        , div [ class "string" ] (renderFrets model stringNum)
        ]


renderFretBoard : Model -> Html Msg
renderFretBoard model =
    div [ class "fretboard" ] (renderStrings model)


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


renderHeader : Html Msg
renderHeader =
    h1 [] [ text "Elm Fretboard" ]


renderGameControls : Model -> Html Msg
renderGameControls model =
    button
        [ class "pick-note-btn", onClick PickRandomNote ]
        [ text "Pick Random Note" ]


view : Model -> Html Msg
view model =
    div [ class "main" ]
        [ renderHeader
        , renderFretBoard model
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
