 #!/usr/bin/env dyalogscript

⍝ MIT License
⍝
⍝ Copyright (c) 2022 ona-li-toki-e-jan-Epiphany-tawa-mi
⍝
⍝ Permission is hereby granted, free of charge, to any person obtaining a copy
⍝ of this software and associated documentation files (the "Software"), to deal
⍝ in the Software without restriction, including without limitation the rights
⍝ to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
⍝ copies of the Software, and to permit persons to whom the Software is
⍝ furnished to do so, subject to the following conditions:
⍝
⍝ The above copyright notice and this permission notice shall be included in all
⍝ copies or substantial portions of the Software.
⍝
⍝ THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
⍝ IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
⍝ FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
⍝ AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
⍝ LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
⍝ OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
⍝ SOFTWARE.


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

⍝ Constants.
EOFInterruptEvent←1005
true←1



⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝
⍝ Command-line argument parsing.
⍝⍝
⍝ Option flags (e.x. "-W 25".)
optionFlags←'-W' '-e' '-T'
⍝ Non-option flags, switches, whatever (e.x. "-n" "-d".)
flags←'-n' '-b' '-d' '-g' '-p' '-s' '-t' '-w' '-y' '-h' '--help'

arguments←2⎕NQ#'GetCommandLineArgs'
programName←⊃arguments
arguments←1↓arguments

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



:If ∨/isFlagSet¨'-h' '--help'
    ⍝ Lines should be outputted with a maximum length of 80 characters.
    tab←'        '


    ⎕←'NAME:'
    ⎕←tab,programName,' - cowsay written in Dyalog APL.'

    ⎕←''
    ⎕←'SYNOPSIS:'
    ⎕←tab,programName,' [-bdgpstwy] [-h] [-e EYES] [-T TOUNGE]'
    ⎕←tab,(' '/⍨≢programName),' [-n|-W WIDTH] [TEXT...]'

    ⎕←''
    ⎕←'DESCRIPTION:'
    ⎕←tab,'Prints out ASCII art of a cow saying the supplied text within a speech'
    ⎕←tab,'bubble. If no text is supplied as arguments to the function, it will'
    ⎕←tab,'instead be pulled from STDIN until an EOF is reached.'
    ⎕←''
    ⎕←tab,'The maximum width of the text bubble defaults to 40. If any lines of'
    ⎕←tab,'text supplied exceed that length, they will be word-wrapped. If the max'
    ⎕←tab,'line size is smaller than the max width, the max line size will be used'
    ⎕←tab,'for the size of the text bubble. The max width can be set with -W WIDTH,'
    ⎕←tab,'or word-wrapping can be disabled completely using -n.'
    ⎕←''
    ⎕←tab,'The cow''s appearance can either be set to a preset (using any of'
    ⎕←tab,'-bdgpstwy) or custom set using -e EYES and/or -T TOUNGE.'

    ⎕←''
    ⎕←'COMMAND LINE OPTIONS:'
    ⎕←tab,'-h, --help'
    ⎕←tab,tab,'Displays this help message and exits.'
    ⎕←''
    ⎕←tab,'-W WIDTH'
    ⎕←tab,tab,'Integer. Sets the maximum WIDTH of lines within the'
    ⎕←tab,tab,'generated text bubbles. Incompatible with -n.'
    ⎕←''
    ⎕←tab,'-n'
    ⎕←tab,tab,'Prevents word wrapping. Width of the text bubble is the'
    ⎕←tab,tab,'length of the largest line from TEXT. Incompatible with -W'
    ⎕←tab,tab,'WIDTH.'
    ⎕←''
    ⎕←tab,'-e EYES'
    ⎕←tab,tab,'Sets the string for the EYES, must be 2 characters long.'
    ⎕←tab,tab,'Incompatible with appearance presets.'
    ⎕←''
    ⎕←tab,'-T TOUNGE'
    ⎕←tab,tab,'Sets the string for the TOUNGE, must be either 1 or 2'
    ⎕←tab,tab,'characters long. If only 1 character is supplied a space'
    ⎕←tab,tab,'will be appended to it. Incompatible with a few appearance'
    ⎕←tab,tab,'presets.'
    ⎕←''
    ⎕←tab,'-b'
    ⎕←tab,tab,'Borg mode. Appearance preset. Incompatible with -e EYES and'
    ⎕←tab,tab,'other presets.'
    ⎕←''
    ⎕←tab,'-d'
    ⎕←tab,tab,'Dead. Appearance preset. Incompatible with -e EYES, -T'
    ⎕←tab,tab,'TOUNGE, and other presets.'
    ⎕←''
    ⎕←tab,'-g'
    ⎕←tab,tab,'Greedy. Appearance preset. Incompatible with -e EYES and'
    ⎕←tab,tab,'other presets.'
    ⎕←''
    ⎕←tab,'-p'
    ⎕←tab,tab,'Paranoid. Appearance preset. Incompatible with -e EYES and'
    ⎕←tab,tab,'other presets.'
    ⎕←''
    ⎕←tab,'-s'
    ⎕←tab,tab,'Stoned. Appearance preset. Incompatible with -e EYES, -T'
    ⎕←tab,tab,'TOUNGE, and other presets.'
    ⎕←''
    ⎕←tab,'-t'
    ⎕←tab,tab,'Tired. Appearance preset. Incompatible with -e EYES and'
    ⎕←tab,tab,'other presets.'
    ⎕←''
    ⎕←tab,'-w'
    ⎕←tab,tab,'Wired. Appearance preset. Incompatible with -e EYES and'
    ⎕←tab,tab,'other presets.'
    ⎕←''
    ⎕←tab,'-y'
    ⎕←tab,tab,'Young. Appearance preset. Incompatible with -e EYES and'
    ⎕←tab,tab,'other presets.'

    ⎕←''
    ⎕←'AUTHOR(S):'
    ⎕←tab,'ona li toki e jan Epiphany tawa mi.'

    ⎕←''
    ⎕←'BUGS:
    ⎕←tab,'Report bugs to <https://github.com/ona-li-toki-e-jan-Epiphany-tawa-mi/co'
    ⎕←tab,'wsAyPL/issues>'

    ⎕←''
    ⎕←'COPYRIGHT:'
    ⎕←tab,'Copyright © 2022 ona-li-toki-e-jan-Epiphany-tawa-mi. License: MIT. This'
    ⎕←tab,'is free software; you are free to modify and redistribute it. See the'
    ⎕←tab,'source or visit <https://mit-license.org> for the full terms of the'
    ⎕←tab,'license. THIS SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY'
    ⎕←tab,'KIND.'

    ⎕←''
    ⎕←'SEE ALSO:'
    ⎕←tab,'Source code avalible at <https://github.com/ona-li-toki-e-jan-Epiphany-t'
    ⎕←tab,'awa-mi/cowsAyPL>'


    ⎕OFF
:EndIf



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
    :Trap EOFInterruptEvent
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

cow←'\' ' \' '   ^__^' ('   (',eyes,')\_______') '   (__)\       )\/\' ('    ',tounge,' ||----w |') '       ||     ||'
⍝ Splits text into trueWidth-long character arrays, padding with spaces where necessary. Empty lines are
⍝   populated with spaces.
splitText←⊃,/trueWidth{⍵{↓⍵⍴⍺,' '/⍨(×/⍵)-≢⍺}⍺,⍨(0≡≢⍵)+⌈⍺÷⍨≢⍵}¨text
⍝ Produces a text bubble around the split text.
textBubble←(2+trueWidth){(⊂'/','\',⍨⍺/'¯'),⍵,⊂'\','/',⍨⍺/'_'}{'| ',⍵,' |'}¨splitText
⍝ Offsets cow to near the end of the bubble and prepends the text bubble.
⎕←↑textBubble,{⍵,⍨trueWidth/' '}¨cow
