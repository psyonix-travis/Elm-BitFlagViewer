module Flag.View exposing (list)

import Html exposing (..)
import Flag.Models exposing (..)
import Flag.Messages exposing (..)


list : List Flag -> Html Msg
list flags =
    div []
        [ table []
            [ thead [] [ headerRow ]
            , tbody [] (List.map flagRow flags)
            ]
        ]


headerRow : Html Msg
headerRow =
    tr []
        [ th [] [ text "Value" ]
        , th [] [ text "Name" ]
        , th [] [ text "Comment" ]
        ]


flagRow : Flag -> Html Msg
flagRow flag =
    tr []
        [ td [] [ text flag.value ]
        , td [] [ text flag.label ]
        , td [] [ text flag.comment ]
        ]
