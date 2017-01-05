module Main exposing (..)

import Dict
import Set
import Html exposing (program)
import View exposing (view)
import Update exposing (update)
import Port
import Model exposing (Model)
import Commands exposing (fetchAll)
import Messages exposing (Msg(OnFlagConverted))


init : ( Model, Cmd Msg )
init =
    ( { input = Set.empty
      , error = ""
      , categories = Dict.empty
      , category = ""
      }
    , fetchAll
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Port.flagConverted OnFlagConverted


main : Program Never Model Msg
main =
    program
        { init = init
        , view = View.view
        , update = Update.update
        , subscriptions = subscriptions
        }
