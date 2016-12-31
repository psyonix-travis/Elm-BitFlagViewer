module Init exposing (init)

import Model exposing (..)
import Category.Models exposing (..)
import Commands exposing (..)
import Messages exposing (..)
import Dict


init : ( Model, Cmd Msg )
init =
    ( { input = "", error = "", categories = Dict.empty, category = Category.Models.default }, fetchAll )
