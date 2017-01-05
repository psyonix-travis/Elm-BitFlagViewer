module BinaryFormatter exposing (format)

import Delimiter exposing (format)


interval : Int
interval =
    4


format : String -> String
format value =
    String.padLeft (getLeftPadCount <| String.length value) '0' value
        |> Delimiter.format interval " "


getLeftPadCount : Int -> Int
getLeftPadCount strLen =
    let
        modulo =
            strLen % interval
    in
        if (modulo == 0) then
            strLen
        else
            strLen + interval - modulo
