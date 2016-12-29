module BinaryConverter exposing (convert)

import Bitwise


convert : Int -> String
convert value =
    if value < 0 then
        internalConvert ((Bitwise.complement value) + 1)
    else
        internalConvert value


internalConvert : Int -> String
internalConvert value =
    if value <= 1 then
        getMSB value
    else
        convert (Bitwise.shiftRightBy 1 value) ++ (getMSB value)


getMSB : Int -> String
getMSB value =
    if (Bitwise.and 1 value) /= 0 then
        "1"
    else
        "0"
