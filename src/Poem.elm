module Poem exposing (Poem, poemFromText)

import Json.Decode as JD
import Regex


type alias Poem =
    List Line


type alias Line =
    List String


type alias Word =
    String


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
