module Text exposing (Text, chunkEvery, fromRawText, toQueryStrings, wordsToQueryString)

import Json.Decode as JD
import Regex
import Set exposing (Set)


type alias Text =
    List Paragraph


type alias Paragraph =
    List String


type alias Word =
    String


toQueryStrings : Text -> List String
toQueryStrings =
    uniqueWords >> chunkEvery 3 >> List.map wordsToQueryString


wordsToQueryString : List Word -> String
wordsToQueryString words =
    let
        base =
            "http://phrasefinder.io/search?corpus=eng-gb&query="
    in
        base ++ String.join "/" words


chunkEvery : Int -> List a -> List (List a)
chunkEvery n list =
    if list == [] then
        []
    else
        (List.take n list) :: (chunkEvery n (List.drop n list))


uniqueWords : Text -> List Word
uniqueWords =
    List.concat >> unique


unique : List comparable -> List comparable
unique =
    Set.fromList >> Set.toList


dePunctuate : String -> String
dePunctuate =
    Regex.replace Regex.All (Regex.regex "\\W[\\s\n]") (\_ -> " ")


split : String -> List String
split =
    Regex.split Regex.All (Regex.regex "\\s|\n")


fromRawText : String -> Text
fromRawText text =
    dePunctuate text
        |> Regex.split Regex.All (Regex.regex "\n")
        |> List.map
            (Regex.split Regex.All (Regex.regex "\\s"))
