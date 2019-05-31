module Update exposing (update)

import AudioPorts
import Game
import GuessNotesGame exposing (GuessState(..))
import Guitar exposing (GuitarNote)
import LearnScalesGame
import Model exposing (Model, asGuessNotesGameIn)
import Msg exposing (Msg(..))
import Music
import Random



---- HELPERS ----


toTupleWithCmd : Cmd Msg -> Model -> ( Model, Cmd Msg )
toTupleWithCmd cmd model =
    ( model, cmd )



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
            case mode of
                Game.GuessNotes ->
                    let
                        updatedModel =
                            { model
                                | guessNotesGame = GuessNotesGame.init
                                , gameMode = mode
                                , showOctaves = False
                            }
                    in
                    ( updatedModel, generateRandomGuitarNote )

                Game.LearnNotes ->
                    ( { model | gameMode = mode, showOctaves = True }, Cmd.none )

                Game.LearnScales ->
                    let
                        updatedModel =
                            { model
                                | learnScalesGame = LearnScalesGame.init
                                , gameMode = mode
                                , showOctaves = False
                                , highlightedGuitarNotes =
                                    LearnScalesGame.highlightedGuitarNotes LearnScalesGame.init
                            }
                    in
                    ( updatedModel, Cmd.none )

                _ ->
                    ( { model | gameMode = mode }, Cmd.none )

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
