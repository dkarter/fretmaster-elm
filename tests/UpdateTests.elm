module UpdateTests exposing (testChangeGameMode)

import Expect
import Game exposing (GameMode(..))
import Model exposing (Model)
import Msg exposing (Msg(..))
import Test exposing (..)
import Update


updateInitialModel : Msg -> Model
updateInitialModel msg =
    let
        initialModel =
            Model.init
                |> Tuple.first
    in
    initialModel
        |> Update.update msg
        |> Tuple.first


testChangeGameMode : Test
testChangeGameMode =
    describe "ChangeGameMode"
        [ test "Sets the game mode to Learn" <|
            \_ ->
                let
                    updatedModel =
                        updateInitialModel (ChangeGameMode Learn)
                in
                Expect.equal updatedModel.gameMode Learn
        , test "Sets the game mode to GuessNotes" <|
            \_ ->
                let
                    updatedModel =
                        updateInitialModel (ChangeGameMode GuessNotes)
                in
                Expect.equal updatedModel.gameMode GuessNotes
        , test "Sets the game mode to FindNotes" <|
            \_ ->
                let
                    updatedModel =
                        updateInitialModel (ChangeGameMode FindNotes)
                in
                Expect.equal updatedModel.gameMode FindNotes
        ]
