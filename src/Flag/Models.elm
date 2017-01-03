module Flag.Models exposing (..)

import Set exposing (Set)


type alias Flag =
    { bits : Set Int
    , value : String
    , label : String
    , comment : String
    }
