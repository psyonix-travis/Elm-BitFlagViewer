module Model exposing (Model)

import Category.Models exposing (Category)


type alias Model =
    { error : String
    , categories : List Category
    , category : Category
    }
