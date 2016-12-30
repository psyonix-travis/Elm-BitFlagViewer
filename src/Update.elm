module Update exposing (update)

import Http
import Messages exposing (..)
import Model exposing (..)
import Category.Update exposing (..)
import Category.Models exposing (..)


update : Messages.Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnFetchAll (Ok categories) ->
            ( { model | categories = categories, category = Maybe.withDefault model.category <| List.head categories }, Cmd.none )

        OnFetchAll (Err error) ->
            ( { model | error = httpErrorMapper error }, Cmd.none )

        InputChange input ->
            ( { model | input = input }, Cmd.none )

        CategoryChange label ->
            ( { model | category = lookupCategoryByLabel label model.categories }, Cmd.none )

        CategoryMsg subMsg ->
            let
                ( newCategory, cmd ) =
                    Category.Update.update subMsg model.category
            in
                ( { model | category = newCategory }, Cmd.map CategoryMsg cmd )


httpErrorMapper : Http.Error -> String
httpErrorMapper err =
    case err of
        Http.BadUrl str ->
            "HTTP Bad URL: " ++ str

        Http.Timeout ->
            "HTTP Timeout"

        Http.NetworkError ->
            "HTTP NetworkError"

        Http.BadStatus response ->
            "HTTP BadStatus: " ++ response.status.message

        Http.BadPayload s response ->
            "HTTP BadPayload: " ++ s


lookupCategoryByLabel : String -> List Category -> Category
lookupCategoryByLabel label categories =
    case List.head categories of
        Nothing ->
            Category.Models.default

        Just category ->
            if (category.label == label) then
                category
            else
                lookupCategoryByLabel label <| List.drop 1 categories
