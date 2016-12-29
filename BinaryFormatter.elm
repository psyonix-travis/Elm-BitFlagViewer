module BinaryFormatter exposing (toBinary)

import Bitwise


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
        |> formatBinStep ""


delimiterInterval : Int
delimiterInterval =
    4


delimiter : String
delimiter =
    " "


formatBinGetLeftPadCount : String -> Int
formatBinGetLeftPadCount value =
    (String.length value) + (delimiterInterval - ((String.length value) % delimiterInterval))


formatBinStep : String -> String -> String
formatBinStep formatStr inStr =
    if (String.length inStr == 0) then
        formatStr
    else
        let
            newFormatStr =
                (String.right delimiterInterval inStr) ++ delimiter ++ formatStr

            remainingStr =
                String.left (String.length inStr - delimiterInterval) inStr
        in
            formatBinStep newFormatStr remainingStr


getMSB : Int -> String
getMSB value =
    Bitwise.and 1 value
        |> toString
