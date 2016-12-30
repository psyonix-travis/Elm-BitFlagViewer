module Category.Models exposing (..)

import Flag.Models


type alias Category =
    { label : String
    , flags : List Flag.Models.Flag
    }


default : Category
default =
    { label = ""
    , flags = []
    }
