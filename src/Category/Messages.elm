module Category.Messages exposing (..)

import Flag.Messages


type Msg
    = NoOp
    | FlagMsg Flag.Messages.Msg
