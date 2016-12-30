module Update exposing (update)

import Messages exposing (..)
import Model exposing (..)
import Category.Update exposing (..)


update : Messages.Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnFetchAll (Ok categories) ->
            ( { error = model.error, categories = categories, category = Maybe.withDefault model.category <| List.head categories }, Cmd.none )

        OnFetchAll (Err error) ->
            ( { model | error = httpErrorMapper error }, Cmd.none )

        CategoryMsg subMsg ->
            let
                ( newCategory, cmd ) =
                    Category.Update.update subMsg model.category
            in
                ( { model | category = newCategory }, Cmd.map CategoryMsg cmd )
