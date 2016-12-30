module View exposing (view)

import Html exposing (Html, Attribute, div, text, input, program, span)
import Html.Attributes exposing (class)
import Category.View exposing (view)
import Messages exposing (..)
import Model exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ div [] [ span [ class "error" ] [ text model.error ] ]
        , Html.map CategoryMsg (Category.View.view model.category)
        ]
