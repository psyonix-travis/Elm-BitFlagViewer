module View exposing (view)

import Html exposing (Html, Attribute, div, text, input, span, select, option)
import Html.Attributes exposing (class, placeholder)
import Html.Events exposing (onInput, on, targetValue)
import Category.View exposing (view)
import Category.Models exposing (..)
import Messages exposing (..)
import Model exposing (..)
import Json.Decode
import BinaryFormatter exposing (format)
import BinaryConverter exposing (convert)
import Dict


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ Dict.keys model.categories
                |> List.map categoryOption
                |> select [ onChange CategoryChange ]
            ]
        , input [ placeholder model.category.label, onInput InputChange ] []
        , text (inputToBits model.input)
        , div [] [ span [ class "error" ] [ text model.error ] ]
        , Html.map CategoryMsg (Category.View.view model.input model.category)
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


onChange : (String -> msg) -> Attribute msg
onChange tagger =
    on "change" (Json.Decode.map tagger targetValue)


categoryOption : String -> Html Msg
categoryOption label =
    option [] [ text label ]
