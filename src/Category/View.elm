module Category.View exposing (..)

import Bitwise
import Html exposing (Html, Attribute, div, text)
import Category.Models exposing (..)
import Category.Messages exposing (..)
import Flag.View exposing (list)
import Flag.Models exposing (Flag)


view : String -> Category -> Html Msg
view input category =
    div []
        [ filterFlags input category.flags
            |> Flag.View.list
            |> Html.map FlagMsg
        ]


filterFlags : String -> List Flag -> List Flag
filterFlags input flags =
    case String.toInt input of
        Err msg ->
            flags

        Ok val ->
            List.filter (filterFlagsTest val) flags


filterFlagsTest : Int -> Flag -> Bool
filterFlagsTest input flag =
    Bitwise.and flag.bits input /= 0
