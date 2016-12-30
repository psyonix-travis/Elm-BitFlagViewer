module Model exposing (Model)

import Category.Models exposing (Category)


type alias Model =
    { error : String
    , category : Category
    }
