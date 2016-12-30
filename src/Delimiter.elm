module Delimiter exposing (format)


format : Int -> String -> String -> String
format interval delimiter formatStr =
    splitByInterval interval formatStr
        |> String.join delimiter


splitByInterval : Int -> String -> List String
splitByInterval interval formatStr =
    if (String.length formatStr == 0) then
        []
    else
        [ (String.right interval formatStr) ]
            |> List.append (splitByInterval interval (String.dropRight interval formatStr))
