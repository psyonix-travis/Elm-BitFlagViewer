module Commands exposing (..)

import Http
import Json.Decode as Decode exposing (field)
import ParseInt exposing (parseIntHex)
import Category.Models exposing (..)
import Flag.Models exposing (..)
import BinaryConverter exposing (convertToList)
import Messages exposing (..)


fetchAll : Cmd Msg
fetchAll =
    Http.get flagsUrl collectionDecoder
        |> Http.send OnFetchAll


flagsUrl : String
flagsUrl =
    "http://localhost:4000/categories"



-- DECODERS


collectionDecoder : Decode.Decoder (List Category)
collectionDecoder =
    Decode.list categoryDecoder


categoryDecoder : Decode.Decoder Category
categoryDecoder =
    Decode.map2 Category
        (field "label" Decode.string)
        (field "flags" (Decode.list flagDecoder))


flagDecoder : Decode.Decoder Flag
flagDecoder =
    Decode.map4 Flag
        (field "value" decodeFlagValue)
        (field "value" Decode.string)
        (field "label" Decode.string)
        (field "comment" Decode.string)


decodeFlagValue : Decode.Decoder Int
decodeFlagValue =
    Decode.map parseFlagValue Decode.string


parseFlagValue : String -> Int
parseFlagValue value =
    if (String.left 2 value == "0x") then
        parseFlagValue (String.dropLeft 2 value)
    else
        case (parseIntHex value) of
            Err error ->
                0

            Ok value ->
                value
