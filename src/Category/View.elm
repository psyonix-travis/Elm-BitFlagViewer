module Category.View exposing (..)

import Bitwise
import Html exposing (Html, Attribute, div, text, input, program, span)
import Html.Attributes exposing (placeholder)
import Html.Events exposing (onInput)
import Category.Models exposing (..)
import Category.Messages exposing (..)
import Flag.View exposing (list)
import Flag.Models exposing (Flag)
import BinaryFormatter exposing (format)
import BinaryConverter exposing (convert)


view : Category -> Html Msg
view category =
    div []
        [ input [ placeholder category.label, onInput InputChange ] []
        , div []
            [ text (inputToBits category.input)
            , filterFlags category.input category.flags
                |> Flag.View.list
                |> Html.map FlagMsg
            ]
        ]


inputToBits : String -> String
inputToBits model =
    if String.length model == 0 then
        " "
    else
        case String.toInt model of
            Err msg ->
                msg

            Ok val ->
                "BIN  " ++ BinaryFormatter.format (BinaryConverter.convert val)


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
