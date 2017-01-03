module Category.View exposing (..)

import Html exposing (Html, Attribute, div, text)
import Category.Models exposing (..)
import Category.Messages exposing (..)
import Flag.View exposing (list)
import Flag.Models exposing (Flag)
import Set exposing (Set, intersect, isEmpty)


view : Set Int -> Category -> Html Msg
view input category =
    div []
        [ filterFlags input category.flags
            |> Flag.View.list
            |> Html.map FlagMsg
        ]


filterFlags : Set Int -> List Flag -> List Flag
filterFlags input flags =
    if Set.isEmpty input then
        flags
    else
        List.filter (filterFlagsTest input) flags


filterFlagsTest : Set Int -> Flag -> Bool
filterFlagsTest input flag =
    Set.intersect input flag.bits
        |> (not << Set.isEmpty)
