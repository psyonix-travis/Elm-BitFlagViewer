module Messages exposing (..)

import Http
import Category.Models exposing (..)
import Category.Messages exposing (..)
import Model exposing (..)


type Msg
    = OnFetchAll (Result Http.Error (List Category))
    | InputChange String
    | OnFlagConverted FlagConversionResponse
    | CategoryChange String
    | CategoryMsg Category.Messages.Msg
