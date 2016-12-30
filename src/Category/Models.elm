module Category.Models exposing (..)

import Flag.Models


type alias Category =
    { label : String
    , flags : List Flag.Models.Flag
    }


default : Category
default =
    { label = ""
    , flags = []
    }


stub : Category
stub =
    { label = "EPackageFlags"
    , flags =
        [ Flag.Models.Flag [ 1 ] "PKG_AllowDownload" "0x00000001" "Allow downloading package."
        , Flag.Models.Flag [ 2 ] "PKG_ClientOptional" "0x00000002" "Purely optional for clients."
        , Flag.Models.Flag [ 3 ] "PKG_ServerSideOnly" "0x00000004" "Only needed on the server side."
        ]
    }
