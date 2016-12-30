module Flag.Models exposing (..)


type alias Flag =
    { bits : List Int
    , value : String
    , label : String
    , comment : String
    }
