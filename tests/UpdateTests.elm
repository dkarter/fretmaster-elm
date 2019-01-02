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
    let
        updatedMode toMode =
            updateInitialModel (ChangeGameMode toMode)
                |> .gameMode
    in
    describe "ChangeGameMode"
        [ test "Sets the game mode to Learn" <|
            \_ ->
                Expect.equal (updatedMode Learn) Learn
        , test "Sets the game mode to GuessNotes" <|
            \_ ->
                Expect.equal (updatedMode GuessNotes) GuessNotes
        , test "Sets the game mode to FindNotes" <|
            \_ ->
                Expect.equal (updatedMode FindNotes) FindNotes
        ]
