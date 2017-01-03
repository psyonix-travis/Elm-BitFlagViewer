module Main exposing (..)

import Html exposing (program)
import Messages exposing (..)
import View exposing (view)
import Update exposing (update)
import Model exposing (..)
import Init exposing (init)
import Port


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Port.flagConverted OnFlagConverted



-- MAIN


main : Program Never Model Msg
main =
    program
        { init = Init.init
        , view = View.view
        , update = Update.update
        , subscriptions = subscriptions
        }
