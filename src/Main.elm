module Main exposing (..)

import Data
import Dict
import Html exposing (Html, div, img, text)
import Html.Attributes exposing (classList, src)
import Html.Events
import Http
import Text exposing (Text)
import Task exposing (Task)
import Browser


---- MODEL ----


type alias Year =
    String


type alias Model =
    { text : Text, currentYear : Year }


init : ( Model, Cmd Msg )
init =
    ( { text = Text.fromRawText Data.rawText
      , currentYear = "1622"
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = UpdateYear String


update : Msg -> (Model, Cmd Msg) -> ( Model, Cmd Msg )
update msg (model, cmd) =
    case msg of
        UpdateYear currentYear ->
            ( { model | currentYear = currentYear }, Cmd.none )



---- VIEW ----


view : (Model, Cmd Msg) -> Html Msg
view (model, cmd) =
    div []
        [ Html.h1 [] [ text <| model.currentYear ]
        , slider model.currentYear
        , fullTextView model.currentYear model.text
        ]


slider : Year -> Html Msg
slider currentYear =
    Html.input
        [ Html.Attributes.type_ "range"
        , Html.Attributes.min "1500"
        , Html.Attributes.max "2018"
        , Html.Attributes.value <| currentYear
        , Html.Events.onInput UpdateYear
        , Html.Attributes.class "slider"
        ]
        []


fullTextView : Year -> Text -> Html msg
fullTextView currentYear text =
    div [] (List.map (paragraphView currentYear) text)


paragraphView : Year -> List String -> Html msg
paragraphView currentYear paragraph =
    div [] <| List.map (wordView currentYear) paragraph


wordView : Year -> String -> Html msg
wordView currentYear word =
    let
        firstYearForWord =
            Dict.get (String.toLower word) Data.yearDictionary
                |> Maybe.withDefault "1500"
    in
        Html.span [ classList [ ( "invisible", firstYearForWord > currentYear ) ] ]
            [ text word ]



---- PROGRAM ----


main : Program () ( Model, Cmd Msg ) Msg
main =
    Browser.sandbox
        { view = view
        , init = init
        , update = update
        }
