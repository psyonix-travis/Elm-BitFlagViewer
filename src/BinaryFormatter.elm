module BinaryFormatter exposing (toBinary)

import Bitwise
import Delimiter exposing (Params, format)


delimiterInterval : Int
delimiterInterval =
    4


delimiter : String
delimiter =
    " "


toBinary : Int -> String
toBinary val =
    formatBin (intToBits val)


intToBits : Int -> String
intToBits value =
    if value == 0 then
        ""
    else
        intToBits (Bitwise.shiftRightBy 1 value) ++ (getMSB value)


formatBin : String -> String
formatBin value =
    String.padLeft (formatBinGetLeftPadCount value) '0' value
        |> format (Delimiter.Params delimiterInterval delimiter)


formatBinGetLeftPadCount : String -> Int
formatBinGetLeftPadCount value =
    (String.length value) + (delimiterInterval - ((String.length value) % delimiterInterval))


getMSB : Int -> String
getMSB value =
    Bitwise.and 1 value
        |> toString
