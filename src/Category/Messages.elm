module Category.Messages exposing (..)

import Http
import Category.Models exposing (Category)
import Flag.Messages


type Msg
    = OnFetchAll (Result Http.Error (List Category))
    | FlagMsg Flag.Messages.Msg


type UpdateMsg
    = CategorySelected Category
    | UpdateError String
