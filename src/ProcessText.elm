module ProcessText exposing (dummyText, getQueryString, yearDictionary)

import Dict exposing (Dict)
import Regex


type alias RawText =
    String


type alias Url =
    String


data =
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


yearDictionary : Dict String String
yearDictionary =
    data
        |> List.foldl
            (\val acc ->
                Dict.insert (String.toLower val.token) val.firstYear acc
            )
            Dict.empty


baseUrl : Url
baseUrl =
    "http://phrasefinder.io/search?corpus=eng-us&query="


split : RawText -> List String
split rawText =
    Regex.split Regex.All (Regex.regex "\\s|\n") rawText


dePunctuate : String -> String
dePunctuate =
    Regex.replace Regex.All (Regex.regex "\\W[\\s\n]") (\_ -> " ")


getQueryString : RawText -> Url
getQueryString rawText =
    baseUrl
        ++ (dePunctuate rawText
                |> split
                |> List.indexedMap (,)
                |> List.foldl
                    (\( index, val ) acc ->
                        if index == 0 then
                            val
                        else
                            acc ++ "/" ++ val
                    )
                    ""
           )


dummyText : String
dummyText =
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


dummyJsonResponse : String
dummyJsonResponse =
    """{"phrases":[{"tks":[{"tt":"the","tg":2}],"mc":16977752813,"vc":3332956,"fy":1500,"ly":2009,"id":1103806595073,"sc":0.213549},{"tks":[{"tt":"and","tg":2}],"mc":8169066412,"vc":3332948,"fy":1500,"ly":2009,"id":1103806595076,"sc":0.102752},{"tks":[{"tt":"to","tg":2}],"mc":7021393210,"vc":3332719,"fy":1500,"ly":2009,"id":1103806595077,"sc":0.0883162},{"tks":[{"tt":"in","tg":2}],"mc":5457466530,"vc":3333000,"fy":1500,"ly":2009,"id":1103806595078,"sc":0.0686449},{"tks":[{"tt":"a","tg":2}],"mc":5362936806,"vc":3332863,"fy":1500,"ly":2009,"id":1103806595079,"sc":0.0674558},{"tks":[{"tt":"is","tg":2}],"mc":2993815184,"vc":3330824,"fy":1500,"ly":2009,"id":1103806595081,"sc":0.0376567},{"tks":[{"tt":"that","tg":2}],"mc":2879609242,"vc":3327153,"fy":1500,"ly":2009,"id":1103806595082,"sc":0.0362202},{"tks":[{"tt":"for","tg":2}],"mc":2237494424,"vc":3331304,"fy":1500,"ly":2009,"id":1103806595083,"sc":0.0281435},{"tks":[{"tt":"was","tg":2}],"mc":2073893689,"vc":3299535,"fy":1500,"ly":2009,"id":1103806595087,"sc":0.0260858},{"tks":[{"tt":"The","tg":2}],"mc":1999222185,"vc":3330776,"fy":1500,"ly":2009,"id":1103806595088,"sc":0.0251465},{"tks":[{"tt":"as","tg":2}],"mc":1912169684,"vc":3325960,"fy":1500,"ly":2009,"id":1103806595089,"sc":0.0240516},{"tks":[{"tt":"with","tg":2}],"mc":1896990934,"vc":3330538,"fy":1500,"ly":2009,"id":1103806595090,"sc":0.0238606},{"tks":[{"tt":"I","tg":2}],"mc":1701439641,"vc":3291102,"fy":1500,"ly":2009,"id":1103806595093,"sc":0.021401},{"tks":[{"tt":"it","tg":2}],"mc":1686686947,"vc":3321894,"fy":1500,"ly":2009,"id":1103806595094,"sc":0.0212154},{"tks":[{"tt":"at","tg":2}],"mc":1189333862,"vc":3327489,"fy":1500,"ly":2009,"id":1103806595104,"sc":0.0149596},{"tks":[{"tt":"this","tg":2}],"mc":1024399171,"vc":3326352,"fy":1500,"ly":2009,"id":1103806595107,"sc":0.0128851},{"tks":[{"tt":"you","tg":2}],"mc":950006304,"vc":2954580,"fy":1500,"ly":2009,"id":1103806595110,"sc":0.0119493},{"tks":[{"tt":"but","tg":2}],"mc":791724336,"vc":3298746,"fy":1500,"ly":2009,"id":1103806595114,"sc":0.00995843},{"tks":[{"tt":"all","tg":2}],"mc":722941287,"vc":3317263,"fy":1500,"ly":2009,"id":1103806595118,"sc":0.00909327},{"tks":[{"tt":"In","tg":2}],"mc":573160418,"vc":3289516,"fy":1500,"ly":2009,"id":1103806595123,"sc":0.0072093},{"tks":[{"tt":"would","tg":2}],"mc":552605104,"vc":3261902,"fy":1500,"ly":2009,"id":1103806595127,"sc":0.00695075},{"tks":[{"tt":"It","tg":2}],"mc":497893347,"vc":3287907,"fy":1500,"ly":2009,"id":1103806595132,"sc":0.00626258},{"tks":[{"tt":"so","tg":2}],"mc":495581448,"vc":3285515,"fy":1500,"ly":2009,"id":1103806595133,"sc":0.0062335},{"tks":[{"tt":"other","tg":2}],"mc":466117642,"vc":3301435,"fy":1500,"ly":2009,"id":1103806595134,"sc":0.0058629},{"tks":[{"tt":"A","tg":2}],"mc":455716596,"vc":3321480,"fy":1500,"ly":2009,"id":1103806595139,"sc":0.00573207},{"tks":[{"tt":"no","tg":2}],"mc":452779722,"vc":3287243,"fy":1500,"ly":2009,"id":1103806595140,"sc":0.00569513},{"tks":[{"tt":"my","tg":2}],"mc":432887674,"vc":2881878,"fy":1500,"ly":2009,"id":1103806595144,"sc":0.00544493},{"tks":[{"tt":"into","tg":2}],"mc":432663977,"vc":3294150,"fy":1500,"ly":2009,"id":1103806595145,"sc":0.00544211},{"tks":[{"tt":"time","tg":2}],"mc":421149605,"vc":3291888,"fy":1500,"ly":2009,"id":1103806595148,"sc":0.00529728},{"tks":[{"tt":"me","tg":2}],"mc":380317003,"vc":2832837,"fy":1500,"ly":2009,"id":1103806595154,"sc":0.00478369},{"tks":[{"tt":"This","tg":2}],"mc":342391301,"vc":3306146,"fy":1500,"ly":2009,"id":1103806595161,"sc":0.00430665},{"tks":[{"tt":"your","tg":2}],"mc":319527320,"vc":2788730,"fy":1500,"ly":2009,"id":1103806595165,"sc":0.00401906},{"tks":[{"tt":"first","tg":2}],"mc":306184915,"vc":3278593,"fy":1500,"ly":2009,"id":1103806595166,"sc":0.00385124},{"tks":[{"tt":"should","tg":2}],"mc":285576139,"vc":3215691,"fy":1500,"ly":2009,"id":1103806595170,"sc":0.00359202},{"tks":[{"tt":"But","tg":2}],"mc":278110916,"vc":3041552,"fy":1500,"ly":2009,"id":1103806595174,"sc":0.00349812},{"tks":[{"tt":"And","tg":2}],"mc":241260782,"vc":2893643,"fy":1500,"ly":2009,"id":1103806595182,"sc":0.00303462},{"tks":[{"tt":"where","tg":2}],"mc":229743842,"vc":3258896,"fy":1500,"ly":2009,"id":1103806595189,"sc":0.00288975},{"tks":[{"tt":"well","tg":2}],"mc":224698448,"vc":3244789,"fy":1500,"ly":2009,"id":1103806595191,"sc":0.00282629},{"tks":[{"tt":"now","tg":2}],"mc":223361097,"vc":3198629,"fy":1500,"ly":2009,"id":1103806595193,"sc":0.00280947},{"tks":[{"tt":"before","tg":2}],"mc":218125316,"vc":3234708,"fy":1500,"ly":2009,"id":1103806595195,"sc":0.00274361},{"tks":[{"tt":"way","tg":2}],"mc":211287856,"vc":3226680,"fy":1500,"ly":2009,"id":1103806595199,"sc":0.00265761},{"tks":[{"tt":"life","tg":2}],"mc":210628221,"vc":3055958,"fy":1500,"ly":2009,"id":1103806595201,"sc":0.00264931},{"tks":[{"tt":"For","tg":2}],"mc":184030047,"vc":3251459,"fy":1500,"ly":2009,"id":1103806595220,"sc":0.00231476},{"tks":[{"tt":"know","tg":2}],"mc":181397129,"vc":3065257,"fy":1500,"ly":2009,"id":1103806595222,"sc":0.00228164},{"tks":[{"tt":"You","tg":2}],"mc":176654343,"vc":2588192,"fy":1507,"ly":2009,"id":1103806595227,"sc":0.00222199},{"tks":[{"tt":"just","tg":2}],"mc":175293737,"vc":3168327,"fy":1500,"ly":2009,"id":1103806595231,"sc":0.00220487},{"tks":[{"tt":"As","tg":2}],"mc":164596762,"vc":3224073,"fy":1500,"ly":2009,"id":1103806595238,"sc":0.00207032},{"tks":[{"tt":"right","tg":2}],"mc":156138269,"vc":3135419,"fy":1500,"ly":2009,"id":1103806595243,"sc":0.00196393},{"tks":[{"tt":"still","tg":2}],"mc":145908352,"vc":3179851,"fy":1500,"ly":2009,"id":1103806595251,"sc":0.00183526},{"tks":[{"tt":"never","tg":2}],"mc":145906987,"vc":3074212,"fy":1500,"ly":2009,"id":1103806595252,"sc":0.00183524},{"tks":[{"tt":"number","tg":2}],"mc":137389844,"vc":3092781,"fy":1500,"ly":2009,"id":1103806595262,"sc":0.00172811},{"tks":[{"tt":"To","tg":2}],"mc":131505456,"vc":3213938,"fy":1500,"ly":2009,"id":1103806595269,"sc":0.0016541},{"tks":[{"tt":"came","tg":2}],"mc":121717337,"vc":2872139,"fy":1500,"ly":2009,"id":1103806595288,"sc":0.00153098},{"tks":[{"tt":"think","tg":2}],"mc":116576584,"vc":2851278,"fy":1500,"ly":2009,"id":1103806595302,"sc":0.00146632},{"tks":[{"tt":"That","tg":2}],"mc":116326662,"vc":3015454,"fy":1500,"ly":2009,"id":1103806595303,"sc":0.00146317},{"tks":[{"tt":"At","tg":2}],"mc":102999591,"vc":3179807,"fy":1500,"ly":2009,"id":1103806595326,"sc":0.00129554},{"tks":[{"tt":"took","tg":2}],"mc":89639368,"vc":2836307,"fy":1500,"ly":2009,"id":1103806595367,"sc":0.0011275},{"tks":[{"tt":"going","tg":2}],"mc":89560191,"vc":2881570,"fy":1500,"ly":2009,"id":1103806595368,"sc":0.0011265},{"tks":[{"tt":"No","tg":2}],"mc":85705988,"vc":3165665,"fy":1500,"ly":2009,"id":1103806595388,"sc":0.00107802},{"tks":[{"tt":"nothing","tg":2}],"mc":79371499,"vc":2852535,"fy":1500,"ly":2009,"id":1103806595419,"sc":0.000998347},{"tks":[{"tt":"All","tg":2}],"mc":78072831,"vc":3246160,"fy":1500,"ly":2009,"id":1103806595424,"sc":0.000982012},{"tks":[{"tt":"look","tg":2}],"mc":77038804,"vc":2953666,"fy":1500,"ly":2009,"id":1103806595428,"sc":0.000969006},{"tks":[{"tt":"night","tg":2}],"mc":75718150,"vc":2564030,"fy":1500,"ly":2009,"id":1103806595437,"sc":0.000952395},{"tks":[{"tt":"THE","tg":2}],"mc":75607423,"vc":2827582,"fy":1500,"ly":2009,"id":1103806595439,"sc":0.000951002},{"tks":[{"tt":"So","tg":2}],"mc":70713814,"vc":2885598,"fy":1500,"ly":2009,"id":1103806595466,"sc":0.000889449},{"tks":[{"tt":"With","tg":2}],"mc":66878930,"vc":3117082,"fy":1500,"ly":2009,"id":1103806595495,"sc":0.000841213},{"tks":[{"tt":"looked","tg":2}],"mc":65263035,"vc":2488226,"fy":1505,"ly":2009,"id":1103806595510,"sc":0.000820889},{"tks":[{"tt":"tell","tg":2}],"mc":63693788,"vc":2670463,"fy":1500,"ly":2009,"id":1103806595518,"sc":0.00080115},{"tks":[{"tt":"real","tg":2}],"mc":63522110,"vc":2917253,"fy":1500,"ly":2009,"id":1103806595519,"sc":0.000798991},{"tks":[{"tt":"My","tg":2}],"mc":61544832,"vc":2500741,"fy":1500,"ly":2009,"id":1103806595533,"sc":0.00077412},{"tks":[{"tt":"gave","tg":2}],"mc":60974147,"vc":2812538,"fy":1500,"ly":2009,"id":1103806595538,"sc":0.000766942},{"tks":[{"tt":"call","tg":2}],"mc":54855827,"vc":2897737,"fy":1500,"ly":2009,"id":1103806595593,"sc":0.000689985},{"tks":[{"tt":"Now","tg":2}],"mc":54246241,"vc":2803732,"fy":1500,"ly":2009,"id":1103806595598,"sc":0.000682318},{"tks":[{"tt":"i","tg":2}],"mc":54024443,"vc":2545717,"fy":1500,"ly":2009,"id":1103806595602,"sc":0.000679528},{"tks":[{"tt":"feel","tg":2}],"mc":53980643,"vc":2716161,"fy":1500,"ly":2009,"id":1103806595603,"sc":0.000678977},{"tks":[{"tt":"hard","tg":2}],"mc":50333840,"vc":2908284,"fy":1500,"ly":2009,"id":1103806595649,"sc":0.000633107},{"tks":[{"tt":"looking","tg":2}],"mc":42042925,"vc":2694943,"fy":1500,"ly":2009,"id":1103806595776,"sc":0.000528822},{"tks":[{"tt":"Is","tg":2}],"mc":41744207,"vc":2707669,"fy":1500,"ly":2009,"id":1103806595781,"sc":0.000525065},{"tks":[{"tt":"it's","tg":2}],"mc":39287081,"vc":1619130,"fy":1584,"ly":2009,"id":1103806595838,"sc":0.000494159},{"tks":[{"tt":"It's","tg":2}],"mc":39207232,"vc":1568729,"fy":1592,"ly":2009,"id":1103806595842,"sc":0.000493155},{"tks":[{"tt":"First","tg":2}],"mc":39125700,"vc":2932841,"fy":1500,"ly":2009,"id":1103806595846,"sc":0.000492129},{"tks":[{"tt":"AND","tg":2}],"mc":37992788,"vc":2441286,"fy":1500,"ly":2009,"id":1103806595872,"sc":0.000477879},{"tks":[{"tt":"trade","tg":2}],"mc":36659688,"vc":2080226,"fy":1525,"ly":2009,"id":1103806595914,"sc":0.000461111},{"tks":[{"tt":"ask","tg":2}],"mc":35729068,"vc":2578009,"fy":1500,"ly":2009,"id":1103806595941,"sc":0.000449406},{"tks":[{"tt":"fall","tg":2}],"mc":35005600,"vc":2905115,"fy":1500,"ly":2009,"id":1103806595958,"sc":0.000440306},{"tks":[{"tt":"Well","tg":2}],"mc":34555691,"vc":2074430,"fy":1500,"ly":2009,"id":1103806595970,"sc":0.000434647},{"tks":[{"tt":"met","tg":2}],"mc":33710787,"vc":2690301,"fy":1500,"ly":2009,"id":1103806595998,"sc":0.000424019},{"tks":[{"tt":"bad","tg":2}],"mc":33528702,"vc":2572815,"fy":1500,"ly":2009,"id":1103806596007,"sc":0.000421729},{"tks":[{"tt":"try","tg":2}],"mc":32279438,"vc":2684999,"fy":1500,"ly":2009,"id":1103806596048,"sc":0.000406016},{"tks":[{"tt":"soul","tg":2}],"mc":30098509,"vc":1815937,"fy":1500,"ly":2009,"id":1103806596132,"sc":0.000378584},{"tks":[{"tt":"I'll","tg":2}],"mc":29570109,"vc":1374349,"fy":1563,"ly":2009,"id":1103806596153,"sc":0.000371937},{"tks":[{"tt":"Other","tg":2}],"mc":28962303,"vc":2618423,"fy":1500,"ly":2009,"id":1103806596175,"sc":0.000364292},{"tks":[{"tt":"wish","tg":2}],"mc":28497345,"vc":2652953,"fy":1500,"ly":2009,"id":1103806596204,"sc":0.000358444},{"tks":[{"tt":"Your","tg":2}],"mc":28062767,"vc":2055988,"fy":1507,"ly":2009,"id":1103806596221,"sc":0.000352978},{"tks":[{"tt":"Where","tg":2}],"mc":27534021,"vc":2618158,"fy":1500,"ly":2009,"id":1103806596242,"sc":0.000346327},{"tks":[{"tt":"you're","tg":2}],"mc":25874636,"vc":1229644,"fy":1600,"ly":2009,"id":1103806596313,"sc":0.000325455},{"tks":[{"tt":"fell","tg":2}],"mc":25464265,"vc":2312846,"fy":1507,"ly":2009,"id":1103806596336,"sc":0.000320293},{"tks":[{"tt":"skin","tg":2}],"mc":23745209,"vc":1792429,"fy":1500,"ly":2009,"id":1103806596426,"sc":0.000298671},{"tks":[{"tt":"Life","tg":2}],"mc":23634397,"vc":2238111,"fy":1500,"ly":2009,"id":1103806596436,"sc":0.000297277},{"tks":[{"tt":"hot","tg":2}],"mc":23310068,"vc":2253269,"fy":1500,"ly":2009,"id":1103806596455,"sc":0.000293198}]}"""
