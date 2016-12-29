module Delimiter exposing (format)


format : Int -> String -> String -> String
format interval delimiter formatStr =
    splitByInterval interval formatStr
        |> List.reverse
        |> String.join delimiter


splitByInterval : Int -> String -> List String
splitByInterval interval formatStr =
    if (String.length formatStr == 0) then
        []
    else
        splitByInterval interval (String.dropRight interval formatStr)
            |> List.append [ String.right interval formatStr ]
