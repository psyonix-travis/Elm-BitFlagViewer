module Messages exposing (..)

import Http
import Category.Models exposing (..)
import Category.Messages exposing (..)


type Msg
    = OnFetchAll (Result Http.Error (List Category))
    | CategoryMsg Category.Messages.Msg
