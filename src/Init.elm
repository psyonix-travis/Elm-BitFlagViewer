module Init exposing (init)

import Model exposing (..)
import Category.Models exposing (..)
import Commands exposing (..)
import Messages exposing (..)
import Dict
import Set


init : ( Model, Cmd Msg )
init =
    ( { input = Set.empty, error = "", categories = Dict.empty, category = "" }, fetchAll )
