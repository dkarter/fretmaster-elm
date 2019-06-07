module GuessChordGame exposing
    ( GuessChordGame
    , GuessState(..)
    , guessChordQualities
    , guessStateByGuessAnswer
    , init
    )

import Chord exposing (Quality)
import GuitarChord exposing (GuitarChord, StringSet)


type alias ChordGuess =
    { stringSet : Maybe StringSet
    , rootNote : Maybe String
    , quality : Maybe Quality
    , inversion : Maybe Int
    }


type GuessState
    = Correct
    | Incomplete
    | Incorrect


type alias GuessChordGame =
    { guess : ChordGuess
    , answer : Maybe GuitarChord
    , guessState : GuessState
    }


guessChordQualities : List ( Quality, String )
guessChordQualities =
    [ ( Chord.MajorSeventh, "Δ" )

    -- , ( AugmentedMajorSeventh, "Δ#5" )
    , ( Chord.Seventh, "7" )

    -- , ( SeventhFlatFive, "7b5" )
    -- , ( AugmentedSeventh, "7#5" )
    , ( Chord.MinorSeventh, "-7" )

    -- , ( MinorMajorSeventh, "-Δ" )
    , ( Chord.HalfDiminishedSeventh, "Ø7" )
    , ( Chord.DiminishedSeventh, "O7" )
    ]



-- [ Chord.Seventh
-- , Chord.MajorSeventh
-- , Chord.MinorMajorSeventh
-- , Chord.MinorSeventh
-- , Chord.HalfDiminishedSeventh
-- , Chord.DiminishedSeventh
-- , Chord.SeventhFlatFive
-- , Chord.AugmentedSeventh
-- , Chord.AugmentedMajorSeventh
-- , MajorTriad
-- , MinorTriad
-- , AugmentedTriad
-- , DiminishedTriad
-- ]


guessStateByGuessAnswer : ChordGuess -> Maybe GuitarChord -> GuessState
guessStateByGuessAnswer guess answer =
    case ( ( guess.rootNote, guess.stringSet ), ( guess.inversion, guess.quality ), answer ) of
        ( _, _, Nothing ) ->
            Incomplete

        ( ( Nothing, _ ), ( _, _ ), _ ) ->
            Incomplete

        ( ( _, Nothing ), ( _, _ ), _ ) ->
            Incomplete

        ( ( _, _ ), ( Nothing, _ ), _ ) ->
            Incomplete

        ( ( _, _ ), ( _, Nothing ), _ ) ->
            Incomplete

        ( ( _, _ ), ( _, _ ), Just ans ) ->
            let
                rootsMatch =
                    guess.rootNote == Just ans.rootNote

                inversionsMatch =
                    guess.inversion == Just ans.inversion

                qualitiesMatch =
                    guess.quality == Just ans.quality

                stringSetsMatch =
                    guess.stringSet == Just ans.stringSet
            in
            case rootsMatch && inversionsMatch && qualitiesMatch && stringSetsMatch of
                True ->
                    Correct

                False ->
                    Incorrect


initialGuess : ChordGuess
initialGuess =
    { stringSet = Nothing
    , rootNote = Nothing
    , quality = Nothing
    , inversion = Nothing
    }


init : GuessChordGame
init =
    { guess = initialGuess
    , answer = Nothing
    , guessState = Incomplete
    }
