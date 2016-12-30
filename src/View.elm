module View exposing (view)

import Html exposing (Html, Attribute, div, text, input, span, select, option)
import Html.Attributes exposing (class)
import Html.Events exposing (on, targetValue)
import Category.View exposing (view)
import Category.Models exposing (..)
import Messages exposing (..)
import Model exposing (..)
import Json.Decode


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ select [ onChange CategoryChange ] <| List.map categoryOption model.categories
            ]
        , div [] [ span [ class "error" ] [ text model.error ] ]
        , Html.map CategoryMsg (Category.View.view model.category)
        ]


onChange : (String -> msg) -> Attribute msg
onChange tagger =
    on "change" (Json.Decode.map tagger targetValue)


categoryOption : Category -> Html Msg
categoryOption category =
    option [] [ text category.label ]
