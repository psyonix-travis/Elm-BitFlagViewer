module Messages exposing (..)

import Http
import Category.Models exposing (..)
import Category.Messages exposing (..)


type Msg
    = OnFetchAll (Result Http.Error (List Category))
    | CategoryChange String
    | CategoryMsg Category.Messages.Msg
