module Flag exposing (view, Model, Msg(..))

import Html exposing (Html, Attribute, div, text, table, tr, td, th, thead, tbody)
import Html.Attributes exposing (class, align, style)
import Set exposing (Set, intersect, isEmpty)


type alias Model =
    { bits : Set Int
    , value : String
    , label : String
    , comment : String
    }


type Msg
    = NoOp


view : Set Int -> List Model -> Html Msg
view input flags =
    filterFlags input flags
        |> list


filterFlags : Set Int -> List Model -> List Model
filterFlags input flags =
    if Set.isEmpty input then
        flags
    else
        List.filter (filterFlagsTest input) flags


filterFlagsTest : Set Int -> Model -> Bool
filterFlagsTest input flag =
    Set.intersect input flag.bits
        |> (not << Set.isEmpty)


list : List Model -> Html Msg
list flags =
    div []
        [ table []
            [ thead [ align "left" ] [ headerRow ]
            , tbody [] (List.map flagRow flags)
            ]
        ]


headerRow : Html Msg
headerRow =
    tr []
        [ th [ tdStyle ] [ text "Name" ]
          --, th [ tdStyle ] [ text "Bits" ]
        , th [ tdStyle ] [ text "Value" ]
        , th [ tdStyle ] [ text "Comment" ]
        ]


flagRow : Model -> Html Msg
flagRow flag =
    tr []
        [ td [ tdStyle ] [ text flag.label ]
          --, td [ tdStyle ] [ text <| toString <| Set.toList flag.bits ]
        , td [ tdStyle ] [ text flag.value ]
        , td [ tdStyle ] [ text flag.comment ]
        ]


tdStyle : Attribute Msg
tdStyle =
    style
        [ ( "padding", "0 15px 0 0" )
        ]
