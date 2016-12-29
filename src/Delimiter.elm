module Delimiter exposing (format)


type alias FormatParams =
    { interval : Int
    , string : String
    }


format : Int -> String -> String -> String
format interval delimiter formatStr =
    formatInterval (FormatParams interval delimiter) "" formatStr


formatInterval : FormatParams -> String -> String -> String
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
