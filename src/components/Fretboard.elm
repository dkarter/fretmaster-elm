module Fretboard exposing (render)

import Guitar
import Html exposing (Html, button, div, h1, img, input, label, span, text)
import Html.Attributes exposing (checked, class, classList, src, style, type_)
import Html.Events exposing (onCheck, onClick)
import Model exposing (Model)
import Msg exposing (Msg(..))


fretCount =
    12


stringCount =
    Guitar.guitarStrings
        |> List.length


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


isOctave : Model -> Int -> Int -> Bool
isOctave model stringNum fretNum =
    model.showOctaves
        && List.any
            (\note -> note.stringNum == stringNum && note.fretNum == fretNum)
            model.selectedGuitarNoteOctaves


renderFrets : Model -> Int -> List (Html Msg)
renderFrets model stringNum =
    let
        fretWidth fretNum =
            let
                minFretSize =
                    4

                reverseFretNum =
                    (fretCount + 1) - toFloat fretNum

                scale =
                    2
            in
            minFretSize + (reverseFretNum / scale)

        fretWidthInRems fretNum =
            fretNum
                |> fretWidth
                |> String.fromFloat
                |> List.singleton
                |> List.append [ "rem" ]
                |> List.reverse
                |> String.concat

        renderFret fretNum =
            div
                [ classList [ ( "fret", True ), ( "fret-marker", Guitar.isMarkerFret fretNum stringNum ) ]
                , style "width" (fretWidthInRems fretNum)
                ]
                [ div
                    [ class "string-line"
                    , classList
                        [ ( "selected", isSelected model stringNum fretNum )
                        , ( "octave", isOctave model stringNum fretNum )
                        ]
                    , onClick (GuitarNoteClicked stringNum fretNum)
                    ]
                    []
                ]
    in
    List.range 1 fretCount
        |> List.map renderFret


renderStrings : Model -> List (Html Msg)
renderStrings model =
    List.range 1 stringCount
        |> List.map (renderString model)


renderString : Model -> Int -> Html Msg
renderString model stringNum =
    div [ class "string-container" ]
        [ div
            [ class "string-name"
            , classList
                [ ( "selected", isSelected model stringNum 0 )
                , ( "octave", isOctave model stringNum 0 )
                ]
            , onClick (GuitarNoteClicked stringNum 0)
            ]
            [ text (Guitar.getGuitarStringName stringNum) ]
        , div [ class "string" ] (renderFrets model stringNum)
        ]


render : Model -> Html Msg
render model =
    div [ class "fretboard" ] (renderStrings model)
