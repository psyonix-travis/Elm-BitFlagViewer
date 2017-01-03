module Flag.View exposing (list)

import Html exposing (..)
import Html.Attributes exposing (class, align, style)
import Flag.Models exposing (..)
import Flag.Messages exposing (..)


list : List Flag -> Html Msg
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


flagRow : Flag -> Html Msg
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
