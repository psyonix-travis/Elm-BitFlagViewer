module Messages exposing (..)

import Http
import Category exposing (Category)
import Model exposing (..)
import Flag exposing (Msg(..))

type Msg
    = OnFetchAll (Result Http.Error (List Category))
    | InputChange String
    | OnFlagConverted FlagConversionResponse
    | CategoryChange String
    | FlagMsg Flag.Msg
