module Test.BinaryConverter exposing (tests)

import Test exposing (..)
import Expect
import BinaryConverter exposing (..)


tests : Test
tests =
    describe "BinaryConverter"
        [ describe "int"
            [ test "0" <| \() -> Expect.equal "0" (int 0)
            , test "1" <| \() -> Expect.equal "1" (int 1)
            , test "2" <| \() -> Expect.equal "10" (int 2)
            , test "3" <| \() -> Expect.equal "11" (int 3)
            , test "100" <| \() -> Expect.equal "1100100" (int 100)
            , test "1000" <| \() -> Expect.equal "1111101000" (int 1000)
            , test "10000" <| \() -> Expect.equal "10011100010000" (int 10000)
            , test "2147483647" <| \() -> Expect.equal "1111111111111111111111111111111" (int 2147483647)
            ]
        , describe "intToList"
            [ test "1" <| \() -> Expect.equal [ 1 ] (intToList 1)
            , test "2" <| \() -> Expect.equal [ 2 ] (intToList 2)
            , test "3" <| \() -> Expect.equal [ 1, 2 ] (intToList 3)
            , test "100" <| \() -> Expect.equal [ 3, 6, 7 ] (intToList 100)
            ]
        , describe "listToString"
            [ test "[ 1 ]" <| \() -> Expect.equal "1" (listToString [ 1 ])
            , test "[ 2 ]" <| \() -> Expect.equal "10" (listToString [ 2 ])
            , test "[ 1, 2 ]" <| \() -> Expect.equal "11" (listToString [ 1, 2 ])
            , test "[ 3, 6, 7 ]" <| \() -> Expect.equal "1100100" (listToString [ 3, 6, 7 ])
            , test "[ 1, 2, 3, 4 ]" <| \() -> Expect.equal "1111" (listToString [ 1, 2, 3, 4 ])
            ]
        ]
