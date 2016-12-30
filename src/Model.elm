module Model exposing (Model)

import Category.Models exposing (Category)


type alias Model =
    { input : String
    , error : String
    , categories : List Category
    , category : Category
    }
