module Category.Commands exposing (..)

import Http
import Json.Decode as Decode exposing (field)
import Category.Messages exposing (..)
import Category.Models exposing (..)
import Flag.Models exposing (..)


fetchAll : Cmd Msg
fetchAll =
    Http.get flagsUrl collectionDecoder
        |> Http.send OnFetchAll


flagsUrl : String
flagsUrl =
    "./../flags.json"



-- DECODERS


collectionDecoder : Decode.Decoder (List Category)
collectionDecoder =
    (field "categories" (Decode.list categoryDecoder))


categoryDecoder : Decode.Decoder Category
categoryDecoder =
    Decode.map2 Category
        (field "label" Decode.string)
        (field "flags" (Decode.list flagDecoder))


flagDecoder : Decode.Decoder Flag
flagDecoder =
    Decode.map4 Flag
        (Decode.succeed [ 0 ])
        (field "label" Decode.string)
        (field "value" Decode.string)
        (field "comment" Decode.string)
