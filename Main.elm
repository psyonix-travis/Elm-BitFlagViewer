module App exposing (..)

import Html exposing (Html, Attribute, div, text, input, program)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import String
import Bitwise


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
                "BIN  " ++ formatBin (intToBits val)


intToBits : Int -> String
intToBits value =
    if value == 0 then
        ""
    else
        intToBits (Bitwise.shiftRightBy 1 value) ++ (getMSB value)


formatBin : String -> String
formatBin value =
    String.padLeft (formatBinGetLeftPadCount value) '0' value
        |> formatBinStep ""


formatBinSpaceInterval : Int
formatBinSpaceInterval =
    4


formatBinDelimiter : String
formatBinDelimiter =
    " "


formatBinGetLeftPadCount : String -> Int
formatBinGetLeftPadCount value =
    (String.length value) + (formatBinSpaceInterval - ((String.length value) % formatBinSpaceInterval))


formatBinStep : String -> String -> String
formatBinStep formatStr inStr =
    if (String.length inStr == 0) then
        formatStr
    else
        let
            newFormatStr =
                (String.right formatBinSpaceInterval inStr) ++ formatBinDelimiter ++ formatStr

            remainingStr =
                String.left (String.length inStr - formatBinSpaceInterval) inStr
        in
            formatBinStep newFormatStr remainingStr



--formatBinDigit : ( String, Int ) -> ( String, Int )
--formatBinDigit ( value, count ) =
--    if (count % formatBinSpaceInterval == 0) then
--        ( " " ++ (formatBinDigit (String.right 1 value)), count - 1 )
--    else
--        ( formatBinDigit (String.right 1 value), count - 1 )


getMSB : Int -> String
getMSB value =
    Bitwise.and 1 value
        |> toString



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
