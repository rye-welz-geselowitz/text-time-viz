module Poem exposing (Poem, chunkEvery, poemFromText, toQueryStrings, wordsToQueryString)

import Json.Decode as JD
import Regex
import Set exposing (Set)


type alias Poem =
    List Line


type alias Line =
    List String


type alias Word =
    String


toQueryStrings : Poem -> List String
toQueryStrings =
    uniqueWords >> chunkEvery 3 >> List.map wordsToQueryString



--     -- get unique words
--     -- chunk
--     -- convert chunk to query string


wordsToQueryString : List Word -> String
wordsToQueryString words =
    let
        base =
            "http://phrasefinder.io/search?corpus=eng-gb&query="
    in
    base ++ String.join "/" words


chunkEvery : Int -> List a -> List (List a)
chunkEvery n =
    List.foldl
        (\val acc ->
            case acc of
                [] ->
                    [ val ] :: acc

                x :: xs ->
                    if List.length x == n then
                        [ val ] :: acc
                    else
                        (x ++ [ val ]) :: xs
        )
        []
        >> List.reverse


uniqueWords : Poem -> List Word
uniqueWords =
    List.concat >> unique


unique : List comparable -> List comparable
unique =
    Set.fromList >> Set.toList


dePunctuate : String -> String
dePunctuate =
    Regex.replace Regex.All (Regex.regex "\\W[\\s\n]") (\_ -> " ")


split : String -> List String
split rawText =
    Regex.split Regex.All (Regex.regex "\\s|\n") rawText


poemFromText : String -> Poem
poemFromText text =
    dePunctuate text
        |> Regex.split Regex.All (Regex.regex "\n")
        |> List.map
            (\line ->
                Regex.split Regex.All (Regex.regex "\\s") line
            )
