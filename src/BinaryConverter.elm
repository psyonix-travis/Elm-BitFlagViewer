module BinaryConverter exposing (convert, convertToList)

import Bitwise


convert : Int -> String
convert value =
    internalConvertList (abs value)
        |> List.reverse
        |> List.map (\x -> toString x)
        |> String.join ""


convertToList : Int -> List Int
convertToList value =
    internalConvertList value
        |> List.indexedMap (,)
        |> List.filterMap digitFilter


internalConvertList : Int -> List Int
internalConvertList value =
    if value <= 1 then
        [ (getLSB value) ]
    else
        (getLSB value) :: (internalConvertList (Bitwise.shiftRightBy 1 value))


getLSB : Int -> Int
getLSB value =
    if (Bitwise.and 1 value) /= 0 then
        1
    else
        0


digitFilter : ( Int, Int ) -> Maybe Int
digitFilter ( index, value ) =
    if (value /= 0) then
        Just (index + 1)
    else
        Nothing
