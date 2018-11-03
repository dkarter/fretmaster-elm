module Main exposing (Model, Msg(..), init, main, renderFretBoard, update, view)

import Array
import Browser
import Debug exposing (log)
import Html exposing (Html, div, h1, img, span, text)
import Html.Attributes exposing (class, classList, src)
import Html.Events exposing (onClick)
import List.Extra exposing (elemIndex)
import Maybe exposing (withDefault)



---- MODEL ----


notes : List String
notes =
    [ "A", "A#/Bb", "B", "C", "C#/Db", "E", "F", "F#/Gb", "G", "G#/Ab" ]


markerFrets : List Int
markerFrets =
    [ 3, 5, 7, 9, 12 ]


isMarkerFret : Int -> Int -> Bool
isMarkerFret fretNum stringNum =
    stringNum == 3 && (markerFrets |> List.member fretNum)


guitarStrings : List String
guitarStrings =
    [ "E", "B", "G", "D", "A", "E" ]


getGuitarStringName : Int -> String
getGuitarStringName num =
    let
        guitarString =
            guitarStrings
                |> Array.fromList
                |> Array.get (num - 1)
    in
    withDefault "" guitarString


getGuitarNoteName : Int -> Int -> String
getGuitarNoteName stringNum fretNum =
    let
        stringName =
            getGuitarNoteName stringNum fretNum

        stringNoteIndex =
            withDefault 0 <| elemIndex stringName notes

        selectedNoteIndex =
            stringNoteIndex + fretNum
    in
    String.fromInt selectedNoteIndex


type alias GuitarNote =
    { stringNum : Int
    , fretNum : Int
    , stringName : String
    , noteName : String
    }


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
renderString num =
    div [ class "string-container" ]
        [ div [ class "string-name" ] [ text (getGuitarStringName num) ]
        , div [ class "string" ] (renderFrets num)
        ]


renderFretBoard : Html Msg
renderFretBoard =
    div [ class "fretboard" ] renderStrings


renderSelectedNote : GuitarNote -> Html Msg
renderSelectedNote selectedNote =
    div [ class "selected-string-info" ]
        [ div [ class "title" ] [ text "Selected Note:" ]
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
        , div [ class "note-name" ]
            [ span [ class "label" ] [ text "Note:" ]
            , text selectedNote.noteName
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
