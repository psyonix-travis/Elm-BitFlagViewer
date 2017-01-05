module Category exposing (view, Category, default)

import Html exposing (Html, div)
import Flag exposing (view)
import Set exposing (Set)


type alias Category =
    { label : String
    , flags : List Flag.Model
    }


default : Category
default =
    { label = ""
    , flags = []
    }


view : Set Int -> Category -> Html Flag.Msg
view input category =
    div [] [ Flag.view input category.flags ]
