module Update exposing (update)

import Game
import GuessNotesGame exposing (GuessState(..))
import Guitar
import Model exposing (Model, asGuessNotesGameIn)
import Msg exposing (Msg(..))
import Random



---- GENERATORS ----


randomString : Random.Generator Int
randomString =
    Random.int 1 6


randomFret : Random.Generator Int
randomFret =
    Random.int 0 12


pickRandomNote : Random.Generator Guitar.GuitarNote
pickRandomNote =
    Random.map2 Guitar.createGuitarNote randomString randomFret


generateRandomGuitarNote : Cmd Msg
generateRandomGuitarNote =
    Random.generate RandomGuitarNoteSelected pickRandomNote



---- UPDATE ----


changeGameMode : Model -> Game.GameMode -> ( Model, Cmd Msg )
changeGameMode model mode =
    case mode of
        Game.GuessNotes _ ->
            let
                updatedModel =
                    GuessNotesGame.init
                        |> asGuessNotesGameIn model
            in
            ( updatedModel, generateRandomGuitarNote )

        _ ->
            ( { model | gameMode = mode }, Cmd.none )


updateGameMode : Model -> Game.GameMode -> ( Model, Cmd Msg )
updateGameMode model mode =
    case mode of
        Game.GuessNotes newGameState ->
            let
                updatedModel =
                    newGameState
                        |> asGuessNotesGameIn model
            in
            ( updatedModel, generateRandomGuitarNote )

        _ ->
            ( { model | gameMode = mode }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeGameMode mode ->
            changeGameMode model mode

        UpdateGameState newGameState ->
            updateGameMode model newGameState

        -- GuitarNoteClicked stringNum fretNum ->
        --     let
        --         guitarNote =
        --             Guitar.createGuitarNote stringNum fretNum
        --     in
        --     ( { model
        --         | selectedGuitarNote = guitarNote
        --         , selectedGuitarNoteOctaves = octaves
        --       }
        --     , Guitar.playNoteAudio guitarNote
        --     )
        PickRandomNote ->
            ( model, generateRandomGuitarNote )

        -- RandomGuitarNoteSelected guitarNote ->
        --     ( { model
        --         | selectedGuitarNote = guitarNote
        --         , selectedGuitarNoteOctaves = []
        --       }
        --     , Guitar.playNoteAudio guitarNote
        --     )
        _ ->
            ( model, Cmd.none )
