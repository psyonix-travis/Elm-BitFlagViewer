module Test.BinaryFormatter exposing (tests)

import Test exposing (..)
import Expect
import BinaryFormatter exposing (..)


tests : Test
tests =
    describe "BinaryFormatter"
        [ describe "toBinary"
            [ test "0" <| \() -> Expect.equal "0000" (format "0")
            , test "1" <| \() -> Expect.equal "0001" (format "1")
            , test "10" <| \() -> Expect.equal "0010" (format "10")
            , test "1100100" <| \() -> Expect.equal "0110 0100" (format "1100100")
            , test "1111101000" <| \() -> Expect.equal "0011 1110 1000" (format "1111101000")
            , test "10011100010000" <| \() -> Expect.equal "0010 0111 0001 0000" (format "10011100010000")
            ]
        ]
