module Main exposing (..)

import Browser
import DemoCss exposing (pageCss)
import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Swapper


type Person
    = Person String


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


renderPerson : Person -> String
renderPerson (Person name) =
    name


init : () -> ( Model, Cmd Msg )
init _ =
    ( { swapperState = Swapper.init data renderPerson getPersonValue }
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


view : Model -> Html Msg
view model =
    div
        []
        [ pageCss
        , div
            [ class "container" ]
            [ Swapper.view model.swapperState SwapperMsg ]
        ]


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
