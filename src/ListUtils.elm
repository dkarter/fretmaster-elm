module ListUtils exposing (first, rotateR)

import List exposing ((::), tail)
import List.Extra exposing (last, unfoldr)


first : List a -> Maybe a
first l =
    case l of
        e :: _ ->
            Just e

        [] ->
            Nothing


rotateR : List a -> List a
rotateR l =
    case ( first l, tail l ) of
        ( Nothing, _ ) ->
            l

        ( Just e, Just t ) ->
            t ++ [ e ]

        _ ->
            l
