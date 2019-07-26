module Tone exposing
    ( Tone, Key(..), Adjustment(..)
    , newTone, keyToValue, keyFromValue, keyFromString
    , adjustmentToValue, adjustmentFromValue, adjustmentFromString
    , diatonicKeyValue, diatonicKeyFromValue
    , chromaticTones, toString, toneToIndex
    )

{-| This module provides types and functions to manipulate musical tones.
It allows you to represent tones (pitches) like `C`, `C Sharp` and so on, as
well as helpers to represent these as numerical values.


# Types

@docs Tone, Key, Adjustment


# Common Helpers

@docs newTone, keyToValue, keyFromValue, keyFromString
@docs adjustmentToValue, adjustmentFromValue, adjustmentFromString
@docs diatonicKeyValue, diatonicKeyFromValue

-}

import String exposing (toLower)


{-| Key represents a Pitch class without adjustment
-}
type Key
    = C
    | D
    | E
    | F
    | G
    | A
    | B


{-| Adjustment represents an adjustment applied to a key
-}
type Adjustment
    = Natural
    | Sharp
    | Flat
    | SharpSharp
    | FlatFlat


{-| Tone represents a pitch and is defined by a key and an adjustment
-}
type alias Tone =
    { key : Key, adjustment : Adjustment }


{-| newTone is a helper function to create a tone
-}
newTone : Key -> Adjustment -> Tone
newTone key adjustment =
    { key = key, adjustment = adjustment }


{-| toneToIndex returns the index in an octave of the provided note. C would be zero,
while E Flat would be 3, or G Sharp would be 8.
-}
toneToIndex : Tone -> Int
toneToIndex t =
    modBy 12 (keyToValue t.key + adjustmentToValue t.adjustment)


{-| chromaticTones returns the chromatic scale tones starting at C.
The adjusted tones will be sharped or flatted according to the provided Adjustment.
This is mostly a helper function.
-}
chromaticTones : Adjustment -> List Tone
chromaticTones adj =
    let
        sharpedTones =
            [ newTone C Natural
            , newTone C Sharp
            , newTone D Natural
            , newTone D Sharp
            , newTone E Natural
            , newTone F Natural
            , newTone F Sharp
            , newTone G Natural
            , newTone G Sharp
            , newTone A Natural
            , newTone A Sharp
            , newTone B Natural
            ]

        flattedTones =
            [ newTone C Natural
            , newTone D Flat
            , newTone D Natural
            , newTone E Flat
            , newTone E Natural
            , newTone F Natural
            , newTone G Flat
            , newTone G Natural
            , newTone A Flat
            , newTone A Natural
            , newTone B Flat
            , newTone B Natural
            ]
    in
    case adj of
        Natural ->
            sharpedTones

        Sharp ->
            sharpedTones

        Flat ->
            flattedTones

        SharpSharp ->
            sharpedTones

        FlatFlat ->
            flattedTones


{-| keyToValue returns the chromatic position of a Key relative to an octave
as a numeric value
-}
keyToValue : Key -> Int
keyToValue key =
    case key of
        C ->
            0

        D ->
            2

        E ->
            4

        F ->
            5

        G ->
            7

        A ->
            9

        B ->
            11


{-| keyFromValue given a position relative to an octave returns the
corresponding key
-}
keyFromValue : Int -> Maybe Key
keyFromValue value =
    case value of
        0 ->
            Just C

        2 ->
            Just D

        4 ->
            Just E

        5 ->
            Just F

        7 ->
            Just G

        9 ->
            Just A

        11 ->
            Just B

        _ ->
            Nothing


{-| keyFromString parses a Key from a String
-}
keyFromString : String -> Maybe Key
keyFromString key =
    case toLower key of
        "c" ->
            Just C

        "d" ->
            Just D

        "e" ->
            Just E

        "f" ->
            Just F

        "g" ->
            Just G

        "a" ->
            Just A

        "b" ->
            Just B

        _ ->
            Nothing


{-| adjustmentToValue returns the numbers of semitones to apply to a
Key when calculating its position.
-}
adjustmentToValue : Adjustment -> Int
adjustmentToValue adjustment =
    case adjustment of
        Flat ->
            -1

        FlatFlat ->
            -2

        Natural ->
            0

        Sharp ->
            1

        SharpSharp ->
            2


{-| adjustmentFromValue returns the adjustment corresponding to a given
number of semitones
-}
adjustmentFromValue : Int -> Adjustment
adjustmentFromValue value =
    case ( value, negate value ) of
        ( _, 2 ) ->
            FlatFlat

        ( _, 1 ) ->
            Flat

        ( 0, _ ) ->
            Natural

        ( 1, _ ) ->
            Sharp

        ( 2, _ ) ->
            SharpSharp

        ( _, _ ) ->
            Natural


{-| adjustmentFromString parses an adjustment from a String
-}
adjustmentFromString : String -> Maybe Adjustment
adjustmentFromString adj =
    case toLower adj of
        "" ->
            Just Natural

        "natural" ->
            Just Natural

        "#" ->
            Just Sharp

        "sharp" ->
            Just Sharp

        "b" ->
            Just Flat

        "flat" ->
            Just Flat

        _ ->
            Nothing


{-| diatonicKeyValue returns the diatonic position of a Key relative to an octave
(composed of only natural notes (white notes of your piano)) as a numeric value.
-}
diatonicKeyValue : Key -> Int
diatonicKeyValue key =
    case key of
        C ->
            0

        D ->
            1

        E ->
            2

        F ->
            3

        G ->
            4

        A ->
            5

        B ->
            6


{-| diatonicKeyFromValue given a position relative to an octave
(composed of only natural notes (white notes of your piano)) returns the
corresponding key.
-}
diatonicKeyFromValue : Int -> Maybe Key
diatonicKeyFromValue value =
    case value of
        0 ->
            Just C

        1 ->
            Just D

        2 ->
            Just E

        3 ->
            Just F

        4 ->
            Just G

        5 ->
            Just A

        6 ->
            Just B

        _ ->
            Nothing


toString : Tone -> String
toString tone =
    let
        note =
            case tone.key of
                A ->
                    "A"

                B ->
                    "B"

                C ->
                    "C"

                D ->
                    "D"

                E ->
                    "E"

                F ->
                    "F"

                G ->
                    "G"

        adjustment =
            case tone.adjustment of
                Sharp ->
                    "#"

                Flat ->
                    "b"

                Natural ->
                    ""

                SharpSharp ->
                    "##"

                FlatFlat ->
                    "bb"
    in
    note ++ adjustment
