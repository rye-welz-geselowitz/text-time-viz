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

userReplace : String -> (Regex.Match -> String) -> String -> String
userReplace userRegex replacer string =
  case Regex.fromString userRegex of
    Nothing ->
      string

    Just regex ->
      Regex.replace regex replacer string

dePunctuate : String -> String
dePunctuate =
  userReplace "\\W[\\s\n]" (\_ -> "")


space : Regex.Regex
space =
  Maybe.withDefault Regex.never <|
    Regex.fromString "\\s|\n"

newLine : Regex.Regex
newLine =
  Maybe.withDefault Regex.never <|
    Regex.fromString "\n"

split : String -> List String
split =
    Regex.split space


fromRawText : String -> Text
fromRawText text =
    dePunctuate text
        |> Regex.split newLine
        |> List.map
            (Regex.split space)
