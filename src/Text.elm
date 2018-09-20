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

replace : String -> (Regex.Match -> String) -> String -> String
replace input replacer string =
  case Regex.fromString input of
    Nothing ->
      string

    Just regex ->
      Regex.replace regex replacer string

dePunctuate : String -> String
dePunctuate =
  replace "\\W[\\s\n]" (\_ -> "")

getRegex : String -> Regex.Regex
getRegex =
  Maybe.withDefault Regex.never <<
    Regex.fromString

space : Regex.Regex
space =
  getRegex "\\s|\n"

newLine : Regex.Regex
newLine =
  getRegex "\n"

fromRawText : String -> Text
fromRawText text =
    dePunctuate text
        |> Regex.split newLine
        |> List.map
            (Regex.split space)
