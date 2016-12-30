module Category.View exposing (..)

import Html exposing (..)
import Category.Models exposing (..)
import Category.Messages exposing (..)
import Flag.View exposing (list)
import Flag.Models exposing (Flag)
import Bitwise


view : Category -> String -> Html Msg
view category input =
    div []
        [ Html.map FlagMsg (Flag.View.list category.label (filterFlags input category.flags))
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
