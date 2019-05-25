module Utils exposing (getWrappedIndex)


getWrappedIndex : List a -> Int -> Int
getWrappedIndex list virtualIndex =
    let
        listCount =
            list |> List.length

        wholeCycles =
            floor (toFloat virtualIndex / toFloat listCount)
    in
    if virtualIndex >= listCount then
        virtualIndex - wholeCycles * listCount

    else
        virtualIndex
