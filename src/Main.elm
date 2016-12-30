module App exposing (..)

import Html exposing (Html, Attribute, div, text, input, program, span)
import Html.Attributes exposing (class)
import Category.View exposing (..)
import Category.Models exposing (..)
import Category.Messages exposing (..)
import Category.Commands exposing (..)
import Category.Update exposing (..)


-- MODEL


type alias Model =
    { error : String
    , category : Category
    }


init : ( Model, Cmd Msg )
init =
    ( { error = "", category = Category.Models.default }, Cmd.map CategoryMsg fetchAll )



-- MESSAGES


type Msg
    = CategoryMsg Category.Messages.Msg



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div [] [ span [ class "error" ] [ text model.error ] ]
        , Html.map CategoryMsg (Category.View.view model.category)
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CategoryMsg subMsg ->
            let
                ( updateMsg, cmd ) =
                    Category.Update.update subMsg model.category
            in
                case updateMsg of
                    Category.Messages.CategorySelected newCategory ->
                        ( { model | category = newCategory }, Cmd.map CategoryMsg cmd )

                    Category.Messages.UpdateError error ->
                        ( { model | error = error }, Cmd.none )



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
