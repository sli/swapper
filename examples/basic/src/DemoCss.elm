module DemoCss exposing (..)

import Css as C exposing (..)
import Css.Global as CG exposing (..)
import Html.Styled exposing (toUnstyled)


pageCss =
    toUnstyled <|
        global
            [ selector "div.container"
                [ width (pct 35)
                , margin2 zero auto
                ]
            , selector "div.swapper"
                [ padding (rem 2)
                , displayFlex
                , flexDirection row
                ]
            , selector "select.swapper__available"
                [ width (pct 100), padding (rem 1), flexGrow (int 2) ]
            , selector "select.swapper__enabled"
                [ width (pct 100), padding (rem 1), flexGrow (int 2) ]
            , selector "div.swapper__controls"
                [ displayFlex
                , flexDirection column
                , alignItems center
                , justifyContent center
                , paddingLeft (rem 1)
                , paddingRight (rem 1)
                ]
            ]
