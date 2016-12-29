module App exposing (..)

import Html exposing (Html, Attribute, div, text, input, program)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import BinaryFormatter exposing (format)
import BinaryConverter exposing (convert)


-- MODEL


type alias Model =
    String


init : ( Model, Cmd Msg )
init =
    ( "", Cmd.none )



-- MESSAGES


type Msg
    = Change String



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Object Flags", onInput Change ] []
        , div [] [ text (inputToBits model) ]
        ]


inputToBits : String -> String
inputToBits model =
    if String.length model == 0 then
        model
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
            ( newContent, Cmd.none )



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
