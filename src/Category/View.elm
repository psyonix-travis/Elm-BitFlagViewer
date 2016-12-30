module Category.View exposing (..)

import Html exposing (..)
import Category.Models exposing (..)
import Category.Messages exposing (..)
import Flag.View exposing (list)


view : Category -> Html Msg
view category =
    div []
        [ text category.label
        , Html.map FlagMsg (Flag.View.list category.flags)
        ]
