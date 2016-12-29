module Test.BinaryConverter exposing (tests)

import Test exposing (..)
import Expect
import BinaryConverter exposing (..)


tests : Test
tests =
    describe "BinaryConverter"
        [ describe "convert"
            [ test "0" <| \() -> Expect.equal "0" (convert 0)
            , test "1" <| \() -> Expect.equal "1" (convert 1)
            , test "2" <| \() -> Expect.equal "10" (convert 2)
            , test "3" <| \() -> Expect.equal "11" (convert 3)
            , test "100" <| \() -> Expect.equal "1100100" (convert 100)
            , test "1000" <| \() -> Expect.equal "1111101000" (convert 1000)
            , test "10000" <| \() -> Expect.equal "10011100010000" (convert 10000)
            , test "2147483647" <| \() -> Expect.equal "1111111111111111111111111111111" (convert 2147483647)
            ]
        ]
