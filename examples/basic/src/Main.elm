module Main exposing (..)

import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Swapper


type alias Person =
    { name : String
    , age : Int
    , cats : Int
    }


data : List Person
data =
    [ Person "Bob"
    , Person "Jack"
    , Person "Jane"
    , Person "William"
    , Person "Jolene"
    , Person "Billy"
    , Person "Holly"
    , Person "Xavier"
    , Person "Jimmy"
    , Person "John"
    , Person "Ashley"
    , Person "Michael"
    , Person "Eva"
    , Person "Claire"
    , Person "Lindsay"
    , Person "Natalie"
    ]


type alias Model =
    { swapperState : Swapper.Model }


type Msg
    = SwapperMsg Swapper.Msg


getPersonValue : Int -> Person -> String
getPersonValue index _ =
    String.fromInt index


init : Session -> ( Model, Cmd Msg )
init session =
    ( { swapperState = Swapper.init data .name getPersonValue }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SwapperMsg swapperMsg ->
            ( { model | swapperState = Swapper.update swapperMsg model.swapperState }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view : Model -> { title : String, content : Html Msg }
view model =
    { title = "Home"
    , content =
        div
            [ class "content-wide" ]
            [ div
                [ class "paper mt-4 flex" ]
                [ div
                    [ class "my-0 mx-auto w-1/2" ]
                    [ Swapper.view model.swapperState SwapperMsg ]
                ]
            ]
    }
