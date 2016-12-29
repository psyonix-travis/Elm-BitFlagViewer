module Delimiter exposing (..)


type alias Params =
    { interval : Int
    , string : String
    }


format : Params -> String -> String
format del str =
    formatInterval del "" str


formatInterval : Params -> String -> String -> String
formatInterval del formatStr inStr =
    if (String.length inStr == 0) then
        formatStr
    else
        let
            newFormatStr =
                (String.right del.interval inStr) ++ (conditionalAddDelimiter del.string formatStr)

            remainingStr =
                String.left (String.length inStr - del.interval) inStr
        in
            formatInterval del newFormatStr remainingStr


conditionalAddDelimiter : String -> String -> String
conditionalAddDelimiter delString val =
    if (String.length val == 0) then
        val
    else
        delString ++ val
