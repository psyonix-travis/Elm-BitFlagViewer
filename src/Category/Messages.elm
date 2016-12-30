module Category.Messages exposing (..)

import Category.Models exposing (Category)
import Flag.Messages


type Msg
    = InputChange String
    | FlagMsg Flag.Messages.Msg
