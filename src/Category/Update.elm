module Category.Update exposing (..)

import Category.Messages exposing (..)
import Category.Models exposing (..)


update : Msg -> Category -> ( Category, Cmd Msg )
update msg category =
    case msg of
        InputChange newContent ->
            ( { category | input = newContent }, Cmd.none )

        FlagMsg subMsg ->
            ( category, Cmd.none )
