module App exposing (..)

import Html exposing (Html, Attribute, div, text, input, program, span)
import Html.Attributes exposing (class)
import Category.View exposing (..)
import Category.Models exposing (..)
import Category.Messages exposing (..)
import Category.Update exposing (..)
import Commands exposing (..)
import Messages exposing (..)


-- MODEL


type alias Msg =
    Messages.Msg


type alias Model =
    { error : String
    , category : Category
    }


init : ( Model, Cmd Msg )
init =
    ( { error = "", category = Category.Models.default }, fetchAll )



-- MESSAGES
-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div [] [ span [ class "error" ] [ text model.error ] ]
        , Html.map CategoryMsg (Category.View.view model.category)
        ]



-- UPDATE


update : Messages.Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnFetchAll (Ok categories) ->
            ( { model | category = Maybe.withDefault model.category <| List.head categories }, Cmd.none )

        OnFetchAll (Err error) ->
            ( { model | error = httpErrorMapper error }, Cmd.none )

        CategoryMsg subMsg ->
            let
                ( newCategory, cmd ) =
                    Category.Update.update subMsg model.category
            in
                ( { model | category = newCategory }, Cmd.map CategoryMsg cmd )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
