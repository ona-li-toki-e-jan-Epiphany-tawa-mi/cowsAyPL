#!/usr/bin/env dyalogscript
⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝
⍝ /¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\               
⍝ | Cowsay in Dyalog APL. |               
⍝ \_______________________/               
⍝                      \                  
⍝                       \                 
⍝                         ^__^            
⍝                         (oo)\_______    
⍝                         (__)\       )\/\
⍝                             ||----w |   
⍝                             ||     ||
⍝ 
⍝ Author: ona li toki e jan Epiphany tawa mi.
⍝⍝

EOFInterruptEvent←1005
inputInterruptEvent←1004

true←1



⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝
⍝ Command-line argument parsing.
⍝⍝
⍝ Option flags (e.x. "-W 25".)
optionFlags←'-W' '-e' '-T'
⍝ Non-option flags, switches, whatever (e.x. "-n" "-d".)
flags←'-n' '-b' '-d' '-g' '-p' '-s' '-t' '-w' '-y'

⍝ We drop the first argument as that is the name of the program.
arguments←1↓2⎕NQ#'GetCommandLineArgs'

setOptionFlags←0⍴''
setFlags←0⍴''
text←0⍴''

:If 0≢≢arguments
    :If optionFlags∊⍨lastFlag←¯1↑arguments
        ⎕←'Error: option flag "',lastFlag,'" has no argument!'
        ⎕OFF
    :EndIf

    ⍝ Groups together option flags and their arguments in 2-length arrays. Text and non-option flags are enclosed in 1-length
    ⍝   arrays.
    enclosedFlags←{⍵⊂⍨~¯1⌽⍵∊optionFlags}arguments
    ⍝ Separates out option flags.
    setOptionFlags←{⍵/⍨2=≢¨⍵}enclosedFlags ⋄ enclosedFlags←enclosedFlags~setOptionFlags
    ⍝ Unencloses remaining flags from their 1-length container.
    enclosedFlags←⊃¨enclosedFlags
    ⍝ Separates out non-option flags. 
    setFlags←{⍵/⍨flags∊⍨⍵}enclosedFlags ⋄ enclosedFlags←enclosedFlags~setFlags
    ⍝ Remaining is *probably* text.
    text←enclosedFlags
:EndIf

⍝ Takes a flag (i.e. '-n') and returns whether that flag has been set.
isFlagSet←{setFlags∊⍨⊃⍵}
⍝ Takes an option flag (i.e. '-W') and returns a 2-length array. The first element is a 0 if the flag is not set, else 1. The 
⍝   second element contains the argument of the flag, or an empty character array if not set.
getOptionFlag←{
    _flag←⍵
    _flagMap←{_flag≡⊃⍵}¨setOptionFlags
    (∨/_flagMap),¯1↑⊃_flagMap/setOptionFlags
}



⍝ Text coagulation.
:If 0≢≢text
    text←⊃{⍺,' ',⍵}/text
:Else
    ⍝ If no text is supplied via the arguments then it is pulled from stdin.
    text←''
    
    :Trap EOFInterruptEvent inputInterruptEvent
        :While true
            text←text,⍞
        :EndWhile
    :EndTrap
:EndIf

⍝ Changing the width of the text bubble.
width←40

:If ⊃userWidth←getOptionFlag '-W'
    userWidth←⊃¯1↑userWidth
    width←⎕VFI userWidth

    :If 0=⊃width
        ⎕←'Error: option argument "-W ',userWidth,'" contains an invalid number!'
        ⎕OFF
    :EndIf

    width←⊃¯1↑width
:ElseIf isFlagSet '-n'
    width←≢text
:EndIf

⍝ Changing the cow's appearance.
eyes←'oo'
tounge←'  '

:If isFlagSet '-b'
    ⍝ Borg mode.
    eyes←'=='
:ElseIf isFlagSet '-d'
    ⍝ Dead.
    eyes←'XX'
    tounge←'U '
:ElseIf isFlagSet '-g'
    ⍝ Greedy.
    eyes←'$$'
:ElseIf isFlagSet '-p'
    ⍝ Paranoid.
    eyes←'@@'
:ElseIf isFlagSet '-s'
    ⍝ Stoned.
    eyes←'**'
    tounge←'U '
:ElseIf isFlagSet '-t'
    ⍝ Tired.
    eyes←'--'
:ElseIf isFlagSet '-w'
    ⍝ Wired.
    eyes←'00'
:ElseIf isFlagSet '-y'
    ⍝ Young.
    eyes←'..'
:EndIf

:If ⊃userEyes←getOptionFlag '-e'
    userEyes←⊃¯1↑userEyes
    :If 2≢≢userEyes
        ⎕←'Invalid eye string "',userEyes,'"! Must be 2 characters long'
        ⎕OFF
    :EndIf

    eyes←userEyes
:EndIf

:If ⊃userTounge←getOptionFlag '-T'
    userTounge←⊃¯1↑userTounge
    :If 1≡≢userTounge
        userTounge←userTounge,' '
    :ElseIf 2≢≢userTounge
        ⎕←'Invalid tounge string "',userTounge,'"! Must be either 1 or 2 characters long'
        ⎕OFF
    :EndIf

    tounge←userTounge
:EndIf



⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝
⍝    ^__^
⍝    (oo)\_______
⍝    (__)\       )\/\
⍝        ||----w |
⍝        ||     ||
⍝⍝
cow←'\' ' \' '   ^__^' ('   (',eyes,')\_______') '   (__)\       )\/\' ('    ',tounge,' ||----w |') '       ||     ||'
⍝ Takes text on the right and a number on the left. The text is split into strings sized to that 
⍝   number. If there are insufficent characters to make the final string, spaces will be added.
splitText←{⍵{↓⍵⍴⍺,' '\⍨(×/⍵)-⍴⍺}(⌈⍺÷⍨⍴⍵),⍺}
⍝ Takes an array of strings and places a text bubble border around them. The strings must be of the 
⍝   same length for it to be displayed correctly, which can be achieved with splitText.  
textBubbleize←{⍵{⍵{(⊂'/¯','¯\',⍨⍵/'¯'),(⊂'\_','_/',⍨⍵/'_'),⍨⍺}⍴⊃⍺}{'| ',⍵,' |'}¨⍵}
⍝ Cowsay. Takes text on the left and a number on the left. The number is the maximum width of the 
⍝   text in the text bubble. 
cowsay←{⍵{↑(⍵{⍵,⍨⍺/' '}¨cow),⍨textBubbleize ⍵ splitText ⍺}⍺⌊≢⍵}

⎕←width cowsay text
