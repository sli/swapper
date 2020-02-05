module Swapper exposing (..)

import Html exposing (Html, button, div, text)
import Html.Attributes exposing (class, size)
import Html.Events exposing (onClick)
import MultiSelect exposing (Item, Options, multiSelect)


type alias Model =
    { items : List Item
    , available : List String
    , availableSelected : List String
    , enabled : List String
    , enabledSelected : List String
    }


type Msg
    = SelectAvailable (List String)
    | SelectEnabled (List String)
    | Enable
    | EnableAll
    | Disable
    | DisableAll


init : List a -> (a -> String) -> (Int -> a -> String) -> Model
init data renderItem getItemValue =
    let
        items =
            List.indexedMap
                (\i d ->
                    { value = getItemValue i d
                    , text = renderItem d
                    , enabled = True
                    }
                )
                data
    in
    { items = items
    , available = List.indexedMap getItemValue data
    , availableSelected = []
    , enabled = []
    , enabledSelected = []
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        SelectAvailable availableSelected ->
            { model | availableSelected = availableSelected }

        SelectEnabled enabledSelected ->
            { model | enabledSelected = enabledSelected }

        Enable ->
            let
                ( toEnable, available ) =
                    List.partition (\i -> List.member i model.availableSelected) model.available

                enabled =
                    List.sort <| List.concat [ model.enabled, toEnable ]
            in
            { model | enabled = enabled, available = available, availableSelected = [] }

        EnableAll ->
            let
                enabled =
                    List.sort <| List.concat [ model.available, model.enabled ]
            in
            { model | enabled = enabled, available = [], availableSelected = [] }

        Disable ->
            let
                ( toDisable, enabled ) =
                    List.partition (\i -> List.member i model.enabledSelected) model.enabled

                available =
                    List.sort <| List.concat [ model.available, toDisable ]
            in
            { model | enabled = enabled, available = available, enabledSelected = [] }

        DisableAll ->
            let
                available =
                    List.sort <| List.concat [ model.available, model.enabled ]
            in
            { model | enabled = [], available = available, enabledSelected = [] }


handleSelect : (Msg -> msg) -> (List String -> Msg) -> List String -> msg
handleSelect toMsg signal selected =
    toMsg (signal selected)


view : Model -> (Msg -> msg) -> Html msg
view model toMsg =
    let
        availableItems =
            List.filter (\i -> List.member i.value model.available) model.items

        enabledItems =
            List.filter (\i -> List.member i.value model.enabled) model.items
    in
    div
        [ class "swapper" ]
        [ multiSelect
            (Options availableItems <| handleSelect toMsg SelectAvailable)
            [ class "swapper__available", size 8 ]
            model.availableSelected
        , div
            [ class "swapper__controls" ]
            [ button [ class "swapper__button swapper__button-enableall", onClick <| toMsg EnableAll ] [ text "⇉" ]
            , button [ class "swapper__button swapper__button-enable", onClick <| toMsg Enable ] [ text "🡒" ]
            , button [ class "swapper__button swapper__button-disable", onClick <| toMsg Disable ] [ text "🡐" ]
            , button [ class "swapper__button swapper__button-disableall", onClick <| toMsg DisableAll ] [ text "⇇" ]
            ]
        , multiSelect
            (Options enabledItems <| handleSelect toMsg SelectEnabled)
            [ class "swapper__enabled", size 8 ]
            model.enabledSelected
        ]
