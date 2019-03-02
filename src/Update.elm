module Update exposing (update)

import AudioPorts
import Game exposing (GameMode(..))
import Guitar exposing (GuitarNote)
import Model exposing (GuessState(..), Model)
import Msg exposing (Msg(..))
import Music
import Random



---- GENERATORS ----


randomString : Random.Generator Int
randomString =
    Random.int 1 6


randomFret : Random.Generator Int
randomFret =
    Random.int 0 12


pickRandomNote =
    Random.map2 Guitar.createGuitarNote randomString randomFret


generateRandomGuitarNote : Cmd Msg
generateRandomGuitarNote =
    Random.generate RandomGuitarNoteSelected pickRandomNote



---- UPDATE ----


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
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

                        _ ->
                            Cmd.none
            in
            ( { model | gameMode = mode, guessState = NotSelected, showOctaves = showOctaves }, cmd )

        GuessNoteButtonClicked note ->
            let
                noteMatchesSelectedNote =
                    model.selectedGuitarNote.noteName == note
            in
            case noteMatchesSelectedNote of
                True ->
                    ( { model | guesses = [], guessState = Correct }, generateRandomGuitarNote )

                False ->
                    ( { model | guesses = model.guesses ++ [ note ], guessState = Incorrect }, Cmd.none )

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

        RandomGuitarNoteSelected guitarNote ->
            ( { model
                | selectedGuitarNote = guitarNote
                , selectedGuitarNoteOctaves = []
              }
            , Guitar.playNoteAudio guitarNote
            )

        ShowOctavesChanged value ->
            ( { model | showOctaves = value }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )
