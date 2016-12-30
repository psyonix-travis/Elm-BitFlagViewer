module Category.Update exposing (..)

import Http
import Category.Messages exposing (..)
import Category.Models exposing (..)


update : Msg -> Category -> ( UpdateMsg, Cmd Msg )
update msg category =
    case msg of
        OnFetchAll (Ok categories) ->
            ( CategorySelected (Maybe.withDefault category (List.head categories)), Cmd.none )

        OnFetchAll (Err error) ->
            ( UpdateError (httpErrorMapper error), Cmd.none )

        FlagMsg subMsg ->
            ( CategorySelected category, Cmd.none )


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
