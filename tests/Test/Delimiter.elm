module Test.Delimiter exposing (tests)

import Test exposing (..)
import Expect
import Delimiter exposing (..)


tests : Test
tests =
    describe "Delimiter"
        [ describe "format"
            [ test "12 34 56" <|
                \() -> Expect.equal "12 34 56" (format (Params 2 " ") "123456")
            , test "123,456" <|
                \() -> Expect.equal "123,456" (format (Params 3 ",") "123456")
            , test "1,234,567" <|
                \() -> Expect.equal "1,234,567" (format (Params 3 ",") "1234567")
            , test "0010 0111 0111 1111" <|
                \() -> Expect.equal "0010 0111 0111 1111" (format (Params 4 " ") "0010011101111111")
            ]
        ]
