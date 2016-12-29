module BinaryFormatter exposing (format)

import Delimiter exposing (Params, format)


interval : Int
interval =
    4


format : String -> String
format value =
    String.padLeft (getLeftPadCount value) '0' value
        |> Delimiter.format (Delimiter.Params interval " ")


getLeftPadCount : String -> Int
getLeftPadCount value =
    let
        strLen =
            String.length value
    in
        strLen + (interval - (strLen % interval))
