module Update exposing (update)

import Guitar exposing (GuitarNote)
import Model exposing (Model)
import Msg exposing (Msg(..))
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



---- UPDATE ----


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeGameMode mode ->
            ( { model | gameMode = mode }, Cmd.none )

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
                , showNoteInfo = True
              }
            , Cmd.none
            )

        PickRandomNote ->
            ( model, Random.generate RandomGuitarNoteSelected pickRandomNote )

        RandomGuitarNoteSelected guitarNote ->
            ( { model
                | selectedGuitarNote = guitarNote
                , selectedGuitarNoteOctaves = []
                , showNoteInfo = False
              }
            , Cmd.none
            )

        ShowNoteInfo ->
            ( { model | showNoteInfo = True }, Cmd.none )

        ShowOctavesChanged value ->
            ( { model | showOctaves = value }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )
