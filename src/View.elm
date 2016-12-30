module View exposing (view)

import Html exposing (Html, Attribute, div, text, input, span, select, option)
import Html.Attributes exposing (class)
import Category.View exposing (view)
import Category.Models exposing (..)
import Messages exposing (..)
import Model exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ select [] <| List.map categoryOption model.categories
            ]
        , div [] [ span [ class "error" ] [ text model.error ] ]
        , Html.map CategoryMsg (Category.View.view model.category)
        ]


categoryOption : Category -> Html msg
categoryOption category =
    option [] [ text category.label ]
