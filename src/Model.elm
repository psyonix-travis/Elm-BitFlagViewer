module Model exposing (Model, CategoryList)

import Category.Models exposing (Category)
import Dict exposing (Dict)


type alias CategoryList =
    Dict String Category


type alias Model =
    { input : String
    , error : String
    , categories : CategoryList
    , category : Category
    }
