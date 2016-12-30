module Flag.View exposing (list)

import Html exposing (..)
import Html.Attributes exposing (class, align, style)
import Flag.Models exposing (..)
import Flag.Messages exposing (..)


list : String -> List Flag -> Html Msg
list label flags =
    div []
        [ table []
            [ thead [ class "left p2", align "left" ] [ headerRow label ]
            , tbody [] (List.map flagRow flags)
            ]
        ]


headerRow : String -> Html Msg
headerRow label =
    tr []
        [ th [ class "p1", tdStyle ] [ text label ]
        , th [ tdStyle ] [ text "Value" ]
        , th [ tdStyle ] [ text "Comment" ]
        ]


flagRow : Flag -> Html Msg
flagRow flag =
    tr []
        [ td [ tdStyle ] [ text flag.label ]
        , td [ tdStyle ] [ text flag.value ]
        , td [ tdStyle ] [ text flag.comment ]
        ]


tdStyle : Attribute Msg
tdStyle =
    style
        [ ( "padding", "0 15px 0 0" )
        ]
