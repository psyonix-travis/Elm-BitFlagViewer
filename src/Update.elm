module Update exposing (update)

import Http
import Messages exposing (..)
import Model exposing (..)
import Category.Models exposing (..)
import Dict
import Port
import Flag.Models
import Set


update : Messages.Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnFetchAll (Ok categories) ->
            let
                categoryList =
                    categoryListToDict categories

                firstCategory =
                    Maybe.withDefault Category.Models.default <| List.head <| Dict.values categoryList
            in
                ( { model | categories = categoryList, category = firstCategory.label }, Cmd.batch <| List.map requestCategoryFlagConversion categories )

        OnFetchAll (Err error) ->
            ( { model | error = httpErrorMapper error }, Cmd.none )

        InputChange input ->
            ( model, Port.convertFlag (FlagConversionRequest "input" input) )

        OnFlagConverted response ->
            if response.category == "input" then
                ( { model | input = Set.fromList response.values }, Cmd.none )
            else
                ( { model | categories = (handleFlagConverted response model.categories) }, Cmd.none )

        CategoryChange label ->
            ( { model | category = label }, Cmd.none )

        CategoryMsg subMsg ->
            ( model, Cmd.none )


requestCategoryFlagConversion : Category -> Cmd msg
requestCategoryFlagConversion category =
    List.map (\x -> Port.convertFlag (FlagConversionRequest category.label x.value)) category.flags
        |> Cmd.batch


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


categoryListToDict : List Category -> CategoryList
categoryListToDict inList =
    List.map (\x -> ( x.label, x )) inList
        |> Dict.fromList


handleFlagConverted : FlagConversionResponse -> CategoryList -> CategoryList
handleFlagConverted response categories =
    Dict.update response.category (updateCat response) categories


updateCat : FlagConversionResponse -> Maybe Category -> Maybe Category
updateCat response category =
    case category of
        Nothing ->
            Nothing

        Just category ->
            Just { category | flags = (updateCategoryFlag response category.flags) }


updateCategoryFlag : FlagConversionResponse -> List Flag.Models.Flag -> List Flag.Models.Flag
updateCategoryFlag response flags =
    let
        select existingFlag =
            if existingFlag.value == response.flag then
                { existingFlag | bits = Set.fromList response.values }
            else
                existingFlag
    in
        List.map select flags
