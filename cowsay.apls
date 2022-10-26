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
    notFlagArguments←~¯1⌽arguments∊optionFlags
    ⍝ If a '--' is present and it is not a flag argument, that means that everything after that is not a flag, even if it starts
    ⍝   with a '-'. This will filter to find any arguments before that string.
    possibleFlagsMap←~×+\notFlagArguments∧{'--'≡⍵}¨arguments
    possibleFlags←arguments/⍨possibleFlagsMap

    :If optionFlags∊⍨lastFlag←¯1↑possibleFlags
        ⎕←'Error: option flag "',lastFlag,'" has no argument!'
        ⎕OFF
    :EndIf

    ⍝ Groups together option flags and their arguments in 2-length arrays. Text and non-option flags are enclosed in 1-length
    ⍝   arrays. 
    enclosedFlags←{⍵⊂⍨notFlagArguments⍴⍨≢⍵}possibleFlags
    ⍝ Separates out option flags.
    setOptionFlags←{⍵/⍨2=≢¨⍵}enclosedFlags ⋄ enclosedFlags←enclosedFlags~setOptionFlags
    ⍝ Unencloses remaining flags from their 1-length container.
    enclosedFlags←⊃¨enclosedFlags
    ⍝ Separates out non-option flags. 
    setFlags←{⍵/⍨flags∊⍨⍵}enclosedFlags ⋄ enclosedFlags←enclosedFlags~setFlags
    ⍝ Remaining is text and can be prepended to the arguments ruled as not being flags due to '--'.
    text←enclosedFlags,(⊂'--')~⍨arguments/⍨~possibleFlagsMap
:EndIf

⍝ Takes a flag (i.e. '-n') and returns whether that flag has been set.
isFlagSet←{setFlags∊⍨⊂⍵}
⍝ Takes an option flag (i.e. '-W') and returns a 2-length array. The first element is a 0 if the flag is not set, else 1. The 
⍝   second element contains the argument of the flag, or an empty character array if not set.
getOptionFlag←{
    _flag←⍵
    _flagMap←{_flag≡⊃⍵}¨setOptionFlags
    (∨/_flagMap),¯1↑⊃_flagMap/setOptionFlags
}



⍝ Changing the maximum width of the text bubble.
width←40

:If ⊃userWidth←getOptionFlag '-W'
    userWidth←⊃¯1↑userWidth
    width←⎕VFI userWidth

    :If 0=⊃width
        ⎕←'Error: option argument "-W ',userWidth,'" contains an invalid number!'
        ⎕OFF
    :EndIf

    width←⊃⊃¯1↑width
:ElseIf isFlagSet '-n'
    ⍝ ¯1 means no word wrapping.
    width←¯1
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

⍝ Text coagulation.
:If 0≢≢text
    text←{⍺,' ',⍵}/text
:Else
    ⍝ If no text is supplied via the arguments then it is pulled from stdin.
    :Trap EOFInterruptEvent inputInterruptEvent
        text←⊂⍞
        :While true
            text←text,⊂⍞
        :EndWhile
    :EndTrap
:EndIf



⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝
⍝    ^__^
⍝    (oo)\_______
⍝    (__)\       )\/\
⍝        ||----w |
⍝        ||     ||
⍝⍝
trueWidth←⌈/≢¨text
:If ¯1≢width
    ⍝ If -n is not set the width of the text may need to be set to the word wrap limit if a line's length is larger so that it will
    ⍝   be properly wrapped.
    trueWidth←width⌊trueWidth
:EndIf
)copy display
cow←'\' ' \' '   ^__^' ('   (',eyes,')\_______') '   (__)\       )\/\' ('    ',tounge,' ||----w |') '       ||     ||'
⍝ Splits text into trueWidth-long character arrays, padding with spaces where necessary.
splitText←⊃,/trueWidth{⍵{↓⍵⍴⍺,' '/⍨(×/⍵)-≢⍺}⍺,⍨⌈⍺÷⍨≢⍵}¨text
⍝ Produces a text bubble around the split text.
textBubble←(2+trueWidth){(⊂'/','\',⍨⍺/'¯'),⍵,⊂'\','/',⍨⍺/'_'}{'| ',⍵,' |'}¨splitText
⍝ Offsets cow to near the end of the bubble and prepends the text bubble.
⎕←↑textBubble,{⍵,⍨trueWidth/' '}¨cow
