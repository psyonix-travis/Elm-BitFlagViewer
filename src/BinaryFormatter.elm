module BinaryFormatter exposing (toBinary)

import Bitwise
import Delimiter exposing (Params, format)


delimiterInterval : Int
delimiterInterval =
    4


toBinary : Int -> String
toBinary val =
    formatBin (intToBits val)


intToBits : Int -> String
intToBits value =
    if value == 0 then
        ""
    else
        intToBits (Bitwise.shiftRightBy 1 value) ++ (getMSB value)


getMSB : Int -> String
getMSB value =
    if (Bitwise.and 1 value) /= 0 then
        "1"
    else
        "0"


formatBin : String -> String
formatBin value =
    String.padLeft (getLeftPadCount value) '0' value
        |> format (Delimiter.Params delimiterInterval " ")


getLeftPadCount : String -> Int
getLeftPadCount value =
    let
        strLen =
            String.length value
    in
        strLen + delimiterInterval - (strLen % delimiterInterval)
