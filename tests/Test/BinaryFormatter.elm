module Test.BinaryFormatter exposing (tests)

import Test exposing (..)
import Expect
import BinaryFormatter exposing (..)


tests : Test
tests =
    describe "BinaryFormatter"
        [ describe "toBinary"
            [ test "0" <| \() -> Expect.equal "0000" (toBinary 0)
            , test "1" <| \() -> Expect.equal "0001" (toBinary 1)
            , test "2" <| \() -> Expect.equal "0010" (toBinary 2)
            , test "3" <| \() -> Expect.equal "0011" (toBinary 3)
            , test "100" <| \() -> Expect.equal "0110 0100" (toBinary 100)
            , test "1000" <| \() -> Expect.equal "0011 1110 1000" (toBinary 1000)
            , test "10000" <| \() -> Expect.equal "0010 0111 0001 0000" (toBinary 10000)
            ]
        ]
