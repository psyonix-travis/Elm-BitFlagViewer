module App exposing (..)

import Html exposing (Html, Attribute, div, text, input, program)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import BinaryFormatter exposing (format)
import BinaryConverter exposing (convert)
import Category.View exposing (..)
import Category.Models exposing (..)
import Category.Messages exposing (..)


-- MODEL


type alias Model =
    { input : String
    , category : Category
    }


init : ( Model, Cmd Msg )
init =
    ( { input = "", category = Category.Models.stub }, Cmd.none )



-- MESSAGES


type Msg
    = Change String
    | CategoryMsg Category.Messages.Msg



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Object Flags", onInput Change ] []
        , div []
            [ text (inputToBits model.input)
            , Html.map CategoryMsg (Category.View.view model.category)
            ]
        ]


inputToBits : String -> String
inputToBits model =
    if String.length model == 0 then
        ""
    else
        case String.toInt model of
            Err msg ->
                msg

            Ok val ->
                "BIN  " ++ BinaryFormatter.format (BinaryConverter.convert val)



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Change newContent ->
            ( { model | input = newContent }, Cmd.none )

        CategoryMsg catMsg ->
            ( model, Cmd.none )



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
