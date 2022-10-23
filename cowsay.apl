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
true←1


⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝
⍝    ^__^
⍝    (oo)\_______
⍝    (__)\       )\/\
⍝        ||----w |
⍝        ||     ||
⍝⍝
cow←'\' ' \' '   ^__^' '   (oo)\_______' '   (__)\       )\/\' '       ||----w |' '       ||     ||'
⍝ Takes text on the right and a number on the left. The text is split into strings sized to that 
⍝ number. If there are insufficent characters to make the final string, spaces will be added.
splitText←{⍵{↓⍵⍴⍺,' '\⍨(×/⍵)-⍴⍺}(⌈⍺÷⍨⍴⍵),⍺}
⍝ Takes an array of strings and places a text bubble border around them. The strings must be of the 
⍝ same length for it to be displayed correctly, which can be achieved with splitText.  
textBubbleize←{⍵{⍵{(⊂'/¯','¯\',⍨⍵/'¯'),(⊂'\_','_/',⍨⍵/'_'),⍨⍺}⍴⊃⍺}{'| ',⍵,' |'}¨⍵}
⍝ Cowsay. Takes text on the left and a number on the left. The number is the maximum width of the 
⍝ text in the text bubble. 
cowsay←{⍵{↑(⍵{⍵,⍨⍺/' '}¨cow),⍨textBubbleize ⍵ splitText ⍺}⍺⌊≢⍵}
⍝ Oneliner version: {⍵{↑(⍵{⍵,⍨⍺/' '}¨'\' ' \' '   ^__^' '   (oo)\_______' '   (__)\       )\/\' '       ||----w |' '       ||     ||'),⍨{⍵{⍵{(⊂'/¯','¯\',⍨⍵/'¯'),(⊂'\_','_/',⍨⍵/'_'),⍨⍺}⍴⊃⍺}{'| ',⍵,' |'}¨⍵}⍵{⍵{↓⍵⍴⍺,' '\⍨(×/⍵)-⍴⍺}(⌈⍺÷⍨⍴⍵),⍺}⍺}⍺⌊⍴⍵}



⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝
⍝ Command-line argument parsing.
⍝⍝
⍝ Option flags and their default arguments when not specified (e.x. "-W 25".)
optionFlags←⊂'-W'
⍝ Non-option flags, switches, whatever (e.x. "-n" "-d".)
flags←⊂'-n'

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
    ⍝ arrays.
    enclosedFlags←{⍵⊂⍨~{¯1⌽⍵}⍵∊optionFlags}arguments
    ⍝ Separates out option flags.
    setOptionFlags←{⍵/⍨2=≢¨⍵}enclosedFlags
    ⍝ Separates out non-option flags. Note: flags are still enclosed.
    setFlags←{⍵/⍨{(~setOptionFlags∊⍨⊂⍵)∧'-'≡⊃⊃⍵}¨⍵}enclosedFlags
    ⍝ Separates and unencloses text.
    text←⊃¨setFlags~⍨enclosedFlags~setOptionFlags
    setFlags←⊃¨setFlags
:EndIf



:If 0≢≢text
    text←⊃{⍺,' ',⍵}/text
:Else
    ⍝ If no text is supplied via the arguments then it is pulled from stdin.
    text←''
    
    :Trap EOFInterruptEvent
        :While true
            text←text,⍞
        :EndWhile
    :EndTrap
:EndIf

width←40
:If ∨/userWidth←{'-W'≡⊃⍵}¨setOptionFlags
    userWidth←⊃¯1↑⊃userWidth/setOptionFlags
    width←⎕VFI userWidth

    :If 0=⊃width
        ⎕←'Error: option argument "-W ',userWidth,'" contains an invalid number!'
        ⎕OFF
    :EndIf

    width←⊃¯1↑width
:ElseIf setFlags∊⍨⊂'-n'
    width←≢text
:EndIf



⎕←width cowsay text
