module Main exposing (Model, Msg(..), getGuitarNoteName, getGuitarStringName, init, main, update, view)

import Array
import Browser
import Debug exposing (log)
import Html exposing (Html, div, h1, img, span, text)
import Html.Attributes exposing (class, classList, src)
import Html.Events exposing (onClick)
import List.Extra exposing (elemIndex)
import Maybe exposing (withDefault)



---- MODEL ----


type alias Note =
    String


type alias GuitarNote =
    { stringNum : Int
    , fretNum : Int
    , stringName : Note
    , noteName : Note
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


notes : List Note
notes =
    [ "A", "A#/Bb", "B", "C", "C#/Db", "D", "D#/Eb", "E", "F", "F#/Gb", "G", "G#/Ab" ]


markerFrets : List Int
markerFrets =
    [ 3, 5, 7, 9, 12 ]


isMarkerFret : Int -> Int -> Bool
isMarkerFret fretNum stringNum =
    stringNum == 3 && (markerFrets |> List.member fretNum)


guitarStrings : List Note
guitarStrings =
    [ "E", "B", "G", "D", "A", "E" ]


getGuitarStringName : Int -> Note
getGuitarStringName num =
    let
        guitarString =
            guitarStrings
                |> Array.fromList
                |> Array.get (num - 1)
    in
    withDefault "" guitarString


getNoteNameByIndex : Int -> Note
getNoteNameByIndex index =
    let
        noteName =
            notes
                |> Array.fromList
                |> Array.get index
    in
    withDefault "Err!" noteName


getGuitarNoteName : Int -> Int -> Note
getGuitarNoteName stringNum fretNum =
    let
        stringName =
            getGuitarStringName stringNum

        stringNoteIndex =
            withDefault 0 (elemIndex stringName notes)

        virtualIndex =
            stringNoteIndex + fretNum

        remainder =
            remainderBy noteCount virtualIndex

        noteCount =
            notes |> List.length

        wholeCycles =
            floor (toFloat virtualIndex / toFloat noteCount)

        selectedNoteIndex =
            if virtualIndex >= noteCount then
                virtualIndex - wholeCycles * noteCount

            else
                virtualIndex
    in
    getNoteNameByIndex selectedNoteIndex



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
