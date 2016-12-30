module Init exposing (init)

import Model exposing (..)
import Category.Models exposing (..)
import Commands exposing (..)
import Messages exposing (..)


init : ( Model, Cmd Msg )
init =
    ( { input = "", error = "", categories = [], category = Category.Models.default }, fetchAll )
