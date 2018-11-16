module Main exposing (Model, Msg(..), init, main, update, view)

import Array
import Browser
import Debug exposing (log)
import Guitar exposing (GuitarNote, getGuitarNoteName, getGuitarStringName, isMarkerFret)
import Html exposing (Html, div, h1, img, span, text)
import Html.Attributes exposing (class, classList, src)
import Html.Events exposing (onClick)
import Music exposing (getNoteNameByIndex, notes)



---- MODEL ----


type alias Model =
    { selectedGuitarNote : GuitarNote }


init : ( Model, Cmd Msg )
init =
    ( { selectedGuitarNote =
            { stringNum = 0
            , fretNum = 0
            , stringName = "E"
            , noteName = "E"
            }
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = SelectGuitarNote Int Int
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectGuitarNote stringNum fretNum ->
            ( { model
                | selectedGuitarNote =
                    { stringNum = stringNum
                    , fretNum =
                        fretNum
                    , stringName = getGuitarStringName stringNum
                    , noteName = getGuitarNoteName stringNum fretNum
                    }
              }
            , Cmd.none
            )

        NoOp ->
            ( model, Cmd.none )



---- VIEW ----


renderFrets : Int -> List (Html Msg)
renderFrets stringNum =
    let
        renderFret fretNum =
            div [ classList [ ( "fret", True ), ( "fret-marker", isMarkerFret fretNum stringNum ) ] ]
                [ div [ class "string-line", onClick (SelectGuitarNote stringNum fretNum) ] [] ]
    in
    List.range 1 12
        |> List.map renderFret


renderStrings =
    List.range 1 6
        |> List.map renderString


renderString : Int -> Html Msg
renderString stringNum =
    div [ class "string-container" ]
        [ div [ class "string-name" ] [ text (getGuitarStringName stringNum) ]
        , div [ class "string" ] (renderFrets stringNum)
        ]


renderFretBoard : Html Msg
renderFretBoard =
    div [ class "fretboard" ] renderStrings


renderSelectedNote : GuitarNote -> Html Msg
renderSelectedNote selectedNote =
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
    h1 [] [ text "FretBored" ]


view : Model -> Html Msg
view model =
    div [ class "main" ]
        [ renderHeader
        , renderFretBoard
        , renderSelectedNote model.selectedGuitarNote
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
