module Category.Messages exposing (..)

import Http
import Category.Models exposing (Category)
import Flag.Messages


type Msg
    = OnFetchAll (Result Http.Error (List Category))
    | InputChange String
    | FlagMsg Flag.Messages.Msg


type UpdateMsg
    = CategorySelected Category
    | UpdateError String
