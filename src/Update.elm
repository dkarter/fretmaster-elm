module Update exposing (update)

import AudioPorts
import Chord exposing (Quality(..))
import Game exposing (GameMode(..))
import GuessChordGame exposing (GuessChordGame, guessChordQualities, guessStateByGuessAnswer)
import GuessNotesGame exposing (GuessState(..))
import Guitar exposing (GuitarNote)
import GuitarChord exposing (GuitarChord, StringSet(..), stringSets)
import Model exposing (Model, asGuessNotesGameIn)
import Msg exposing (Msg(..))
import Music
import Random
import Task



---- HELPERS ----


toTupleWithCmd : Cmd Msg -> Model -> ( Model, Cmd Msg )
toTupleWithCmd cmd model =
    ( model, cmd )



---- GENERATORS ----


randomInversion : Random.Generator Int
randomInversion =
    Random.int 0 3


randomStringSet : Random.Generator StringSet
randomStringSet =
    case stringSets of
        first :: rest ->
            Random.uniform first rest

        _ ->
            Random.uniform FirstSetFour []


randomRootNote : Random.Generator String
randomRootNote =
    case Music.notes of
        first :: rest ->
            Random.uniform first rest

        _ ->
            Random.uniform "C" []


randomQuality : Random.Generator Quality
randomQuality =
    let
        chordQualities =
            guessChordQualities |> List.map (\( q, _ ) -> q)
    in
    case chordQualities of
        first :: rest ->
            Random.uniform first rest

        _ ->
            Random.uniform Chord.MajorSeventh []


randomString : Random.Generator Int
randomString =
    Random.int 1 6


randomFret : Random.Generator Int
randomFret =
    Random.int 0 12


pickRandomNote =
    Random.map2 Guitar.createGuitarNote randomString randomFret


pickRandomChord =
    Random.map4 GuitarChord randomRootNote randomQuality randomInversion randomStringSet


generateRandomGuitarChord : Cmd Msg
generateRandomGuitarChord =
    Random.generate RandomGuitarChordSelected pickRandomChord


generateRandomGuitarNote : Cmd Msg
generateRandomGuitarNote =
    Random.generate RandomGuitarNoteSelected pickRandomNote



---- UPDATE ----


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GuessChordStringSetButtonClicked stringSet ->
            let
                guessChordGame =
                    model.guessChordGame

                guess =
                    guessChordGame.guess

                newGuess =
                    { guess | stringSet = Just stringSet }

                newGuessState =
                    guessStateByGuessAnswer newGuess guessChordGame.answer

                newGuessChordGame =
                    { guessChordGame | guess = newGuess, guessState = newGuessState }
            in
            ( { model
                | guessChordGame = newGuessChordGame
              }
            , Cmd.none
            )

        GuessChordQualityButtonClicked quality ->
            let
                guessChordGame =
                    model.guessChordGame

                guess =
                    guessChordGame.guess

                newGuess =
                    { guess | quality = Just quality }

                newGuessState =
                    guessStateByGuessAnswer newGuess guessChordGame.answer

                newGuessChordGame =
                    { guessChordGame | guess = newGuess, guessState = newGuessState }
            in
            ( { model | guessChordGame = newGuessChordGame }, Cmd.none )

        GuessChordInversionButtonClicked inversion ->
            let
                guessChordGame =
                    model.guessChordGame

                guess =
                    guessChordGame.guess

                newGuess =
                    { guess | inversion = Just inversion }

                newGuessState =
                    guessStateByGuessAnswer newGuess guessChordGame.answer

                newGuessChordGame =
                    { guessChordGame | guess = newGuess, guessState = newGuessState }
            in
            ( { model | guessChordGame = newGuessChordGame }, Cmd.none )

        GuessChordRootButtonClicked note ->
            let
                guessChordGame =
                    model.guessChordGame

                guess =
                    guessChordGame.guess

                newGuess =
                    { guess | rootNote = Just note }

                newGuessState =
                    guessStateByGuessAnswer newGuess guessChordGame.answer

                newGuessChordGame =
                    { guessChordGame | guess = newGuess, guessState = newGuessState }
            in
            ( { model | guessChordGame = newGuessChordGame }, Cmd.none )

        ShowChordStringSetButtonClicked stringSet ->
            let
                showChord =
                    model.showChord

                newShowChord =
                    { showChord | stringSet = stringSet }
            in
            ( { model | showChord = newShowChord }, Cmd.none )

        ShowChordQualityButtonClicked quality ->
            let
                showChord =
                    model.showChord

                newShowChord =
                    { showChord | quality = quality }
            in
            ( { model | showChord = newShowChord }, Cmd.none )

        ShowChordInversionButtonClicked inversion ->
            let
                showChord =
                    model.showChord

                newShowChord =
                    { showChord | inversion = inversion }
            in
            ( { model | showChord = newShowChord }, Cmd.none )

        ShowChordRootButtonClicked note ->
            let
                showChord =
                    model.showChord

                newShowChord =
                    { showChord | rootNote = note }
            in
            ( { model | showChord = newShowChord }, Cmd.none )

        GuessChordReset ->
            ( { model | guessChordGame = GuessChordGame.init }, generateRandomGuitarChord )

        ChangeGameMode mode ->
            let
                showOctaves =
                    case mode of
                        Learn ->
                            True

                        _ ->
                            False

                cmd =
                    case mode of
                        GuessNotes ->
                            generateRandomGuitarNote

                        GuessChord ->
                            generateRandomGuitarChord

                        _ ->
                            Cmd.none
            in
            ( { model
                | guessNotesGame = GuessNotesGame.init
                , gameMode = mode
                , showOctaves = showOctaves
              }
            , cmd
            )

        GuessNoteButtonClicked note ->
            case model.selectedGuitarNote.noteName == note of
                True ->
                    model.guessNotesGame
                        |> GuessNotesGame.setGuesses []
                        |> GuessNotesGame.setGuessState Correct
                        |> asGuessNotesGameIn model
                        |> toTupleWithCmd generateRandomGuitarNote

                False ->
                    model.guessNotesGame
                        |> GuessNotesGame.appendGuess note
                        |> GuessNotesGame.setGuessState Incorrect
                        |> asGuessNotesGameIn model
                        |> toTupleWithCmd Cmd.none

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
              }
            , Guitar.playNoteAudio guitarNote
            )

        PickRandomNote ->
            ( model, generateRandomGuitarNote )

        RandomGuitarChordSelected guitarChord ->
            let
                { guessChordGame } =
                    model

                newGuessChordGame =
                    { guessChordGame | answer = Just guitarChord }
            in
            ( { model | guessChordGame = newGuessChordGame }, Cmd.none )

        RandomGuitarNoteSelected guitarNote ->
            ( { model
                | selectedGuitarNote = guitarNote
                , selectedGuitarNoteOctaves = []
              }
            , Guitar.playNoteAudio guitarNote
            )

        ShowOctavesChanged value ->
            let
                octaves =
                    if value then
                        Guitar.findAllOctaves model.selectedGuitarNote.noteName 12

                    else
                        []
            in
            ( { model
                | showOctaves = value
                , selectedGuitarNoteOctaves = octaves
              }
            , Cmd.none
            )

        NoOp ->
            ( model, Cmd.none )
