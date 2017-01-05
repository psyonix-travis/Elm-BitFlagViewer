module View exposing (view)

import Html exposing (Html, Attribute, div, text, input, span, select, option)
import Html.Attributes exposing (class, placeholder)
import Html.Events exposing (onInput)
import Category exposing (Category, view, default)
import Messages exposing (Msg(..))
import Model exposing (..)
import BinaryFormatter exposing (format)
import BinaryConverter exposing (listToString)
import Dict
import Set exposing (Set, isEmpty)


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ Dict.keys model.categories
                |> List.map categoryOption
                |> select [ onInput CategoryChange ]
            ]
        , input [ placeholder model.category, onInput InputChange ] []
        , div [] [ text (inputToBits model.input) ]
        , div [] [ span [ class "error" ] [ text model.error ] ]
        , Html.map FlagMsg (Category.view model.input <| getActiveCategory model)
        ]


getActiveCategory : Model -> Category
getActiveCategory model =
    case Dict.get model.category model.categories of
        Nothing ->
            Category.default

        Just category ->
            category


inputToBits : Set Int -> String
inputToBits model =
    if Set.isEmpty model then
        " "
    else
        "BIN  "
            ++ BinaryFormatter.format
                (Set.toList model
                    |> BinaryConverter.listToString
                )


categoryOption : String -> Html Msg
categoryOption label =
    option [] [ text label ]
