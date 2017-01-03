port module Port exposing (..)

import Model exposing (FlagConversionRequest, FlagConversionResponse)


port convertFlag : FlagConversionRequest -> Cmd msg


port flagConverted : (FlagConversionResponse -> msg) -> Sub msg
