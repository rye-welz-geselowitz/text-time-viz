module Main exposing (..)

import Data
import Dict
import Html exposing (Html, div, img, text)
import Html.Attributes exposing (classList, src)
import Html.Events
import Http
import Poem exposing (Poem)
import Task exposing (Task)


---- MODEL ----


type alias Year =
    String


type alias Model =
    { poem : Poem, currentYear : Year }


init : ( Model, Cmd Msg )
init =
    ( { poem = Poem.poemFromText Data.rawText
      , currentYear = "1622"
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = UpdateYear String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateYear currentYear ->
            ( { model | currentYear = currentYear }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ Html.h1 [] [ text <| model.currentYear ]
        , slider model.currentYear
        , poemView model.currentYear model.poem
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


poemView : Year -> Poem -> Html msg
poemView currentYear poem =
    div [] (List.map (lineView currentYear) poem)


lineView : Year -> List String -> Html msg
lineView currentYear line =
    div [] <| List.map (wordView currentYear) line


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


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
