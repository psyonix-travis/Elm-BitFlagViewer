module Update exposing (update)

import Http
import Messages exposing (..)
import Model exposing (..)
import Category.Update exposing (..)
import Category.Models exposing (..)
import Dict


update : Messages.Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnFetchAll (Ok categories) ->
            let
                categoryList =
                    categoryListToDict categories
            in
                ( { model | categories = categoryList, category = Maybe.withDefault model.category <| List.head <| Dict.values categoryList }, Cmd.none )

        OnFetchAll (Err error) ->
            ( { model | error = httpErrorMapper error }, Cmd.none )

        InputChange input ->
            ( { model | input = input }, Cmd.none )

        CategoryChange label ->
            ( setCategoryByLabel label model, Cmd.none )

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


setCategoryByLabel : String -> Model -> Model
setCategoryByLabel label model =
    case Dict.get label model.categories of
        Nothing ->
            { model | category = Category.Models.default, error = "Invalid category: " ++ label }

        Just category ->
            { model | category = category }


categoryListToDict : List Category -> CategoryList
categoryListToDict inList =
    List.map (\x -> ( x.label, x )) inList
        |> Dict.fromList
