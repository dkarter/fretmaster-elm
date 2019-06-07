module ShowChordControls exposing (render)

import Chord exposing (Quality(..))
import GuitarChord exposing (StringSet(..), stringSetLabel, stringSets)
import Html exposing (Html, button, div, h3, img, span, text)
import Html.Attributes exposing (class, classList, disabled, src)
import Html.Events exposing (onClick)
import Model exposing (Model)
import Msg exposing (Msg(..))
import Music


renderNoteButtons : Music.Note -> Html Msg
renderNoteButtons rootNote =
    let
        normalizedNoteName note =
            note
                |> String.split "/"
                |> List.head
                |> Maybe.withDefault ""

        classes note =
            classList
                [ ( "accidental", String.contains "/" note )
                , ( "active", rootNote == note )
                ]

        renderNoteButton note =
            button
                [ class "note-button"
                , onClick (ShowChordRootButtonClicked note)
                , classes note
                ]
                [ text (normalizedNoteName note) ]

        noteButtons =
            let
                tail =
                    Music.notes |> List.take 3

                head =
                    Music.notes |> List.drop 3

                chromatic =
                    head ++ tail
            in
            chromatic
                |> List.map renderNoteButton
    in
    div [ class "note-buttons" ] noteButtons


renderInversionButtons : Int -> Html Msg
renderInversionButtons selectedInversion =
    let
        inversions =
            [ ( 0, "Root" )
            , ( 1, "First" )
            , ( 2, "Second" )
            , ( 3, "Third" )
            ]

        classes inversion =
            classList
                [ ( "active", selectedInversion == inversion ) ]

        renderInversionButton ( inversion, inversionName ) =
            button
                [ class "quality-button"
                , onClick (ShowChordInversionButtonClicked inversion)
                , classes inversion
                ]
                [ text inversionName ]

        inversionButtons =
            inversions |> List.map renderInversionButton
    in
    div [ class "inversion-buttons" ] ([ h3 [] [ text "Chord Inversion" ] ] ++ inversionButtons)


renderStringSetButtons : StringSet -> Html Msg
renderStringSetButtons selectedStringSet =
    let
        classes stringSet =
            classList
                [ ( "active", selectedStringSet == stringSet ) ]

        renderStringSetButton stringSet =
            button
                [ class "string-set-button"
                , onClick (ShowChordStringSetButtonClicked stringSet)
                , classes stringSet
                ]
                [ img [ src ("string-sets/" ++ stringSetLabel stringSet ++ ".svg") ] [] ]

        stringSetButtons =
            stringSets |> List.map renderStringSetButton
    in
    div [ class "string-set-buttons" ] ([ h3 [] [ text "String Set" ] ] ++ stringSetButtons)


renderLegend : Html Msg
renderLegend =
    div [ class "chord-tone-legend" ]
        [ h3 [] [ text "Chord Tone Legend" ]
        , span [ class "root" ] [ text "Root" ]
        , span [ class "third" ] [ text "Third" ]
        , span [ class "fifth" ] [ text "Fifth" ]
        , span [ class "seventh" ] [ text "Seventh" ]
        ]


renderQualityButtons : Quality -> Html Msg
renderQualityButtons selectedQuality =
    let
        qualities =
            [ ( MajorSeventh, "Δ", "major-seventh" )
            , ( AugmentedMajorSeventh, "Δ#5", "augmented-major-seventh" )
            , ( Seventh, "7", "seventh" )
            , ( SeventhFlatFive, "7b5", "seventh-flat-five" )
            , ( AugmentedSeventh, "7#5", "augmented-seventh" )
            , ( MinorSeventh, "-7", "minor-seventh" )
            , ( MinorMajorSeventh, "-Δ", "minor-major-seventh" )
            , ( HalfDiminishedSeventh, "Ø7", "half-diminished-seventh" )
            , ( DiminishedSeventh, "O7", "diminished-seventh" )
            , ( MinorTriad, "-", "minor" )
            , ( MajorTriad, "M", "major" )
            , ( AugmentedTriad, "#5", "augmented" )
            , ( DiminishedTriad, "b5", "diminished" )
            ]

        classes quality =
            classList
                [ ( "active", selectedQuality == quality ) ]

        renderQualityButton ( quality, qualityName, qualityClass ) =
            button
                [ class "quality-button"
                , class qualityClass
                , onClick (ShowChordQualityButtonClicked quality)
                , classes quality
                ]
                [ text qualityName ]

        qualityButtons =
            qualities |> List.map renderQualityButton
    in
    div [ class "quality-buttons" ] ([ h3 [] [ text "Chord Quality" ] ] ++ qualityButtons)


render : Model -> List (Html Msg)
render model =
    [ div [ class "show-chord" ]
        [ renderLegend
        , renderStringSetButtons model.showChord.stringSet
        , renderQualityButtons model.showChord.quality
        , renderInversionButtons model.showChord.inversion
        , renderNoteButtons model.showChord.rootNote
        ]
    ]
