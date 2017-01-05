module BinaryConverter exposing (int, intToList, listToString)

import Bitwise


int : Int -> String
int value =
    internalIntList (abs value)
        |> List.reverse
        |> List.map (\x -> toString x)
        |> String.join ""


intToList : Int -> List Int
intToList value =
    internalIntList value
        |> List.indexedMap (,)
        |> List.filterMap digitFilter


internalIntList : Int -> List Int
internalIntList value =
    if value <= 1 then
        [ (getLSB value) ]
    else
        (getLSB value) :: (internalIntList (Bitwise.shiftRightBy 1 value))


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


listToString : List Int -> String
listToString list =
    listToStringIter 1 list


listToStringIter : Int -> List Int -> String
listToStringIter count list =
    case List.head list of
        Just value ->
            listToStringIter (count + 1) (listToStringConditionalDrop value count list) ++ (listValueToStr value count)

        Nothing ->
            ""


listToStringConditionalDrop : Int -> Int -> List Int -> List Int
listToStringConditionalDrop value count list =
    if (value == count) then
        (List.drop 1 list)
    else
        list


listValueToStr : Int -> Int -> String
listValueToStr value count =
    if (value == count) then
        "1"
    else
        "0"
