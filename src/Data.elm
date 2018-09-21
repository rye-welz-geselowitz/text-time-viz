module Data exposing (rawText, yearDictionary)

import Dict exposing (Dict)


type alias Word =
    { firstYear : String, token : String }


yearDictionary : Dict String String
yearDictionary =
    records |> List.foldl addRecord Dict.empty


addRecord : Word -> Dict String String -> Dict String String
addRecord val =
    Dict.insert (String.toLower val.token) val.firstYear


records : List Word
records =
    [ { firstYear = "1500", token = "the" }
    , { firstYear = "1500", token = "and" }
    , { firstYear = "1500", token = "to" }
    , { firstYear = "1500", token = "in" }
    , { firstYear = "1500", token = "a" }
    , { firstYear = "1500", token = "is" }
    , { firstYear = "1500", token = "that" }
    , { firstYear = "1500", token = "for" }
    , { firstYear = "1500", token = "was" }
    , { firstYear = "1500", token = "The" }
    , { firstYear = "1500", token = "as" }
    , { firstYear = "1500", token = "with" }
    , { firstYear = "1500", token = "I" }
    , { firstYear = "1500", token = "it" }
    , { firstYear = "1500", token = "at" }
    , { firstYear = "1500", token = "this" }
    , { firstYear = "1500", token = "you" }
    , { firstYear = "1500", token = "but" }
    , { firstYear = "1500", token = "all" }
    , { firstYear = "1500", token = "In" }
    , { firstYear = "1500", token = "would" }
    , { firstYear = "1500", token = "It" }
    , { firstYear = "1500", token = "so" }
    , { firstYear = "1500", token = "other" }
    , { firstYear = "1500", token = "A" }
    , { firstYear = "1500", token = "no" }
    , { firstYear = "1500", token = "my" }
    , { firstYear = "1500", token = "into" }
    , { firstYear = "1500", token = "time" }
    , { firstYear = "1500", token = "me" }
    , { firstYear = "1500", token = "This" }
    , { firstYear = "1500", token = "your" }
    , { firstYear = "1500", token = "first" }
    , { firstYear = "1500", token = "should" }
    , { firstYear = "1500", token = "But" }
    , { firstYear = "1500", token = "And" }
    , { firstYear = "1500", token = "where" }
    , { firstYear = "1500", token = "well" }
    , { firstYear = "1500", token = "now" }
    , { firstYear = "1500", token = "before" }
    , { firstYear = "1500", token = "way" }
    , { firstYear = "1500", token = "life" }
    , { firstYear = "1500", token = "For" }
    , { firstYear = "1500", token = "know" }
    , { firstYear = "1507", token = "You" }
    , { firstYear = "1500", token = "just" }
    , { firstYear = "1500", token = "As" }
    , { firstYear = "1500", token = "right" }
    , { firstYear = "1500", token = "still" }
    , { firstYear = "1500", token = "never" }
    , { firstYear = "1500", token = "number" }
    , { firstYear = "1500", token = "To" }
    , { firstYear = "1500", token = "came" }
    , { firstYear = "1500", token = "think" }
    , { firstYear = "1500", token = "That" }
    , { firstYear = "1500", token = "At" }
    , { firstYear = "1500", token = "took" }
    , { firstYear = "1500", token = "going" }
    , { firstYear = "1500", token = "No" }
    , { firstYear = "1500", token = "nothing" }
    , { firstYear = "1500", token = "All" }
    , { firstYear = "1500", token = "look" }
    , { firstYear = "1500", token = "night" }
    , { firstYear = "1500", token = "THE" }
    , { firstYear = "1500", token = "So" }
    , { firstYear = "1500", token = "With" }
    , { firstYear = "1505", token = "looked" }
    , { firstYear = "1500", token = "tell" }
    , { firstYear = "1500", token = "real" }
    , { firstYear = "1500", token = "My" }
    , { firstYear = "1500", token = "gave" }
    , { firstYear = "1500", token = "call" }
    , { firstYear = "1500", token = "Now" }
    , { firstYear = "1500", token = "i" }
    , { firstYear = "1500", token = "feel" }
    , { firstYear = "1500", token = "hard" }
    , { firstYear = "1500", token = "looking" }
    , { firstYear = "1500", token = "Is" }
    , { firstYear = "1584", token = "it's" }
    , { firstYear = "1592", token = "It's" }
    , { firstYear = "1500", token = "First" }
    , { firstYear = "1500", token = "AND" }
    , { firstYear = "1525", token = "trade" }
    , { firstYear = "1500", token = "ask" }
    , { firstYear = "1500", token = "fall" }
    , { firstYear = "1500", token = "Well" }
    , { firstYear = "1500", token = "met" }
    , { firstYear = "1500", token = "bad" }
    , { firstYear = "1500", token = "try" }
    , { firstYear = "1500", token = "soul" }
    , { firstYear = "1563", token = "I'll" }
    , { firstYear = "1500", token = "Other" }
    , { firstYear = "1500", token = "wish" }
    , { firstYear = "1507", token = "Your" }
    , { firstYear = "1500", token = "Where" }
    , { firstYear = "1600", token = "you're" }
    , { firstYear = "1507", token = "fell" }
    , { firstYear = "1500", token = "skin" }
    , { firstYear = "1500", token = "Life" }
    , { firstYear = "1500", token = "hot" }
    ]


rawText : String
rawText =
    """I threw a wish in the well
Don't ask me I'll never tell
I looked to you as it fell
And now you're in my way
I'd trade my soul for a wish
Pennies and dimes for a kiss
I wasn't looking for this
But now you're in my way
Your stare was holding
Ripped jeans, skin was showin'
Hot night, wind was blowin'
Where you think you're going baby?
Hey, I just met you and this is crazy
But here's my number, so call me maybe
It's hard to look right at you baby
But here's my number, so call me maybe
Hey I just met you and this is crazy
But here's my number, so call me maybe
And all the other boys try to chase me
But here's my number, so call me maybe
You took your time with the call
I took no time with the fall
You gave me nothing at all
But still you're in my way
I beg and borrow and steal
At first sight and it's real
I didn't know I would feel it
But it's in my way
Your stare was holding
Ripped jeans, skin was showin'
Hot night, wind was blowin'
Where you think you're going baby?
Hey, I just met you and this is crazy
But here's my number, so call me maybe
It's hard to look right at you baby
But here's my number, so call me maybe
Hey I just met you and this is crazy
But here's my number, so call me maybe
And all the other boys try to chase me
But here's my number, so call me maybe
Before you came into my life
I missed you so bad
I missed you so bad
I missed you so so bad
Before you came into my life
I missed you so bad
And you should know that
I missed you so so bad
It's hard to look right at you baby
But here's my number, so call me maybe
Hey, I just met you and this is crazy
But here's my number, so call me maybe
And all the other boys try to chase me
But here's my number, so call me maybe
Before you came into my life
I missed you so bad
I missed you so bad
I missed you so so bad
Before you came into my life
I missed you so bad
And you should know that
So call me maybe"""
