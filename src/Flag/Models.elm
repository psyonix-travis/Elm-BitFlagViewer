module Flag.Models exposing (..)


type alias Flag =
    { bits : Int
    , value : String
    , label : String
    , comment : String
    }
