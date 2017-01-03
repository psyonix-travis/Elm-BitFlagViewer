module Model exposing (..)

import Category.Models exposing (Category)
import Dict exposing (Dict)
import Set exposing (Set)


type alias CategoryList =
    Dict String Category


type alias Model =
    { input : Set Int
    , error : String
    , categories : CategoryList
    , category : String
    }


type alias FlagConversionRequest =
    { category : String
    , flag : String
    }


type alias FlagConversionResponse =
    { category : String
    , flag : String
    , values : List Int
    }
