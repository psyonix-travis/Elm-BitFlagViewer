module Tests exposing (..)

import Test exposing (..)
import Expect
import Fuzz exposing (list, int, tuple, string)
import String
import Test.BinaryFormatter as BinaryFormatter
import Test.Delimiter as Delimiter


all : Test
all =
    describe "All Tests"
        [ BinaryFormatter.tests
        , Delimiter.tests
        ]
