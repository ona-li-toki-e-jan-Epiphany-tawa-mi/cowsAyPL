#!/usr/bin/apl --script --

⍝ MIT License
⍝
⍝ Copyright (c) 2022-2024 ona-li-toki-e-jan-Epiphany-tawa-mi
⍝
⍝ Permission is hereby granted, free of charge, to any person obtaining a copy
⍝ of this software and associated documentation files (the "Software"), to
⍝ deal in the Software without restriction, including without limitation the
⍝ rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
⍝ sell copies of the Software, and to permit persons to whom the Software is
⍝ furnished to do so, subject to the following conditions:
⍝
⍝ The above copyright notice and this permission notice shall be included in
⍝ all copies or substantial portions of the Software.
⍝
⍝ THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
⍝ IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
⍝ FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
⍝ AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
⍝ LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
⍝ FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
⍝ IN THE SOFTWARE.

⍝ /¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\
⍝ | Cowsay in GnuAPL |
⍝ \__________________/
⍝                 \
⍝                  \
⍝                    ^__^
⍝                    (oo)\_______
⍝                    (__)\       )\/\
⍝                        ||----w |
⍝                        ||     ||



⍝ Reads up to 5,000 bytes in from file descriptor ⍵ as a byte vector.
FIO∆FREAD←{⎕FIO[6] ⍵}
⍝ Returns non-zero if EOF was reached for file descriptor ⍵.
FIO∆FEOF←{⎕FIO[10] ⍵}
⍝ Returns non-zero if an error ocurred reading file descriptor ⍵.
FIO∆FERROR←{⎕FIO[11] ⍵}
⍝ Splits a vector ⍵, where the given value ⍺ is present, into a vector of
⍝ vectors. The split value will not be present in the resulting subvectors.
FIO∆SPLIT←{⍺{⍵~⍺}¨⍵⊂⍨1++\⍺⍷⍵}

⍝ The file descriptor for stdin.
FIO∆STDIN←0
⍝ Reads input from stdin until EOF is reached and outputs the contents as a
⍝ vector of character vectors, each vector representing a line.
∇LINES←FIO∆READ_ENTIRE_STDIN
  LINES←⍬

  LREAD_LOOP:
    LINES←LINES,FIO∆FREAD FIO∆STDIN
    →(0≢FIO∆FEOF   FIO∆STDIN) ⍴ LEND_READ_LOOP
    →(0≢FIO∆FERROR FIO∆STDIN) ⍴ LEND_READ_LOOP
    →LREAD_LOOP
  LEND_READ_LOOP:

  ⍝ {19 ⎕CR ⎕UCS ⍵} converts the input from FIO∆FREAD into a UTF-8 string.
  LINES←(↑"\n") FIO∆SPLIT 19 ⎕CR ⎕UCS LINES
∇



HELP_MESSAGE←"""
Usages:
  cowsaypl [options...] [TEXT...]
  ./cowsay.apl [options...] [TEXT...]
  apl --script ahd.apl -- [options...] [TEXT...]

Prints out text art of a cow saying the supplied TEXT within a speech bubble. If
no TEXT is supplied as arguments to the function, it will instead be pulled from
stdin until an EOF is reached.

Options:
  +h
    Displays this help message and exits.
  +W WIDTH
    Unsinged integer. Sets the maximum WIDTH of lines within the generated text
    bubbles. Defaults to 40 Incompatible with +n.
  +n
    Prevents word wrapping. Width of the text bubble is the length of the
    largest line from TEXT. Incompatible with +W.
  +e EYES
    Sets the string for the EYES, must be 2 characters long. Incompatible with
    appearance presets.
  +T TOUNGE
    Sets the string for the TOUNGE, must be either 1 or 2 characters long. If
    only 1 character is supplied a space will be appended to it. Incompatible
    with a few appearance presets.
  +b
    Borg mode. Appearance preset. Incompatible with +e EYES and other presets.
  +d
    Dead. Appearance preset. Incompatible with +e EYES, +T TOUNGE, and other
    presets.
  +g
    Greedy. Appearance preset. Incompatible with +e EYES and other presets.
  +p
    Paranoid. Appearance preset. Incompatible with +e EYES and other presets.
  +s
    Stoned. Appearance preset. Incompatible with +e EYES, +T TOUNGE, and other
    presets.
  +t
    Tired. Appearance preset. Incompatible with +e EYES and other presets.
  +w
    Wired. Appearance preset. Incompatible with +e EYES and other presets
  +y
    Young. Appearance preset. Incompatible with +e EYES and other presets.
"""
⍝ Whether the program should end after the argument parsing is done. This may be
⍝ because of it outputting help information, an error with the input, or some
⍝ other reason.
PARSE_EXIT_PROGRAM←0
⍝ The maximum width of the text in the text bubble. Any text over the limit will be
⍝ word-wrapped. May be ≤ 0.
TEXT_WIDTH←40
⍝ Whether to disable word wrapping. If set, the width of the bubble should be
⍝ that of the longest line, and TEXT_WIDTH should be ignored.
DISABLE_WORD_WRAP←0
⍝ When the text to display is specified in the arguments of the command, it will
⍝ be put into this variable. The non-empty value will be a vector of character
⍝ vectors.
ARGUMENT_TEXT←⍬
⍝ The eyes to use for the cow. Must be a character vector of dimension 2.
EYES←"oo"
⍝ The tounge to use for the cow. Must be a character vector of dimension 2.
TOUNGE←"  "

⍝ Matches a singular integer, with or without a minus sign, with any number of
⍝ leading or trailing spaces.
RE_MATCH_NUMBER←'^\s*-?[0-9]+\s*$'

⍝ Attempts to convert a character vector to scalar integer. If the vector does
⍝ not represent a valid integer, the default value will be returned instead.
∇INTEGER←DEFAULT CVTI CVECTOR
  CVECTOR←RE_MATCH_NUMBER ⎕RE CVECTOR ⍝ if CVECTOR is not a number, returns
                                      ⍝ empty vector.
  →(~×⍴CVECTOR) ↓ LA_NUMBER LNOT_A_NUMBER
  LA_NUMBER:     INTEGER←⍎CVECTOR ◊ →LEND_IF
  LNOT_A_NUMBER: INTEGER←DEFAULT  ◊ →LEND_IF
  LEND_IF:
∇

⍝ Parses the arguments supplied from the command line and updates the preceeding
⍝ variable(s) accordingly.
∇PARSE_ARGUMENTS; ARGUMENTS;ARGUMENT;FOUND_DOUBLE_PLUS
  ⍝ ⎕ARG returns: apl --script cowsay.apl -- [ARG...]. We need to check if there
  ⍝ are not more than 4 arguments before dropping the first four to avoid some
  ⍝ weird error from being printed.
  →(4<≢⎕ARG) / LSTART_PARSING
    →LABORT
  LSTART_PARSING:
  ARGUMENTS←4↓⎕ARG

  ⍝ Indicates whether a '++' was found in the arguments, which means that all
  ⍝ further values are to be interpreted as text.
  FOUND_DOUBLE_PLUS←0

  LWHILE: →(0≡≢ARGUMENTS) / LWHILE_END
    ARGUMENT←↑ARGUMENTS
    ⍝ We need to check before dropping arugments to avoid a weird error message.
    →(1≡≢ARGUMENTS) / LFINALARGUMENT
      ARGUMENTS←1↓ARGUMENTS ◊ →LNOT_FINALARGUMENT
    LFINALARGUMENT:
      ARGUMENTS←⍬
    LNOT_FINALARGUMENT:

    →(~FOUND_DOUBLE_PLUS) / LPARSE_NORMALLY
      ARGUMENT_TEXT←ARGUMENT_TEXT,⊂ARGUMENT
      →LWHILE
    LPARSE_NORMALLY:

    →({ARGUMENT≡⍵}¨"+h" "+v" "+W" "++" "+n" "+e" "+T" "+b" "+d" "+g" "+p" "+s" "+t" "+w" "+y") / LHELP LVERSION LSET_TEXT_WIDTH LDOUBLE_PLUS LDISABLE_WORD_WRAP LSET_EYES LSET_TOUNGE LSET_BORG_MODE LSET_DEAD LSET_GREEDY LSET_PARANOID LSET_STONED LSET_TIRED LSET_WIRED LSET_YOUTHFUL
    LOTHERWISE:
      →('+'≢↑ARGUMENT) ↓ LOPTION LNOT_OPTION
      LOPTION:
        ⎕←"ERROR: unknown option: '",ARGUMENT,"'!"
        PARSE_EXIT_PROGRAM←1 ◊ →LABORT
      LNOT_OPTION:
        ARGUMENT_TEXT←ARGUMENT_TEXT,⊂ARGUMENT
        →LSWITCH_END
    LHELP: ⍝ +h
      ⍞←⊃HELP_MESSAGE
      PARSE_EXIT_PROGRAM←1 ◊ →LABORT
    LVERSION: ⍝ +v
      ⎕←"cowsaypl 1.1.0"
      PARSE_EXIT_PROGRAM←1 ◊ →LABORT
    LSET_TEXT_WIDTH: ⍝ +W WIDTH
      →(0≡≢ARGUMENTS) ↓ LWIDTH LNO_WIDTH
      LWIDTH:
        ARGUMENT←↑ARGUMENTS ◊ ARGUMENTS←1↓ARGUMENTS
        TEXT_WIDTH←"INVALID" CVTI ARGUMENT
        →("INVALID"≡TEXT_WIDTH) ↓ LSWITCH_END LINVALID_WIDTH
      LNO_WIDTH:
        ⎕←"ERROR: No width supplied for the argument '+W'!"
        PARSE_EXIT_PROGRAM←1 ◊ →LABORT
      LINVALID_WIDTH:
        ⎕←"ERROR: Invalid width specified for argument '+W'! '",ARGUMENT,"' is not a number!"
        PARSE_EXIT_PROGRAM←1 ◊ →LABORT
    LDOUBLE_PLUS: ⍝ ++
      FOUND_DOUBLE_PLUS←1 ◊ →LSWITCH_END
    LDISABLE_WORD_WRAP: ⍝ +n
      DISABLE_WORD_WRAP←1 ◊ →LSWITCH_END
    LSET_EYES: ⍝ +e EYE_STRING
      →(0≡≢ARGUMENTS) ↓ LEYES LNO_EYES
      LEYES:
        EYES←↑ARGUMENTS ◊ ARGUMENTS←1↓ARGUMENTS
        →(2≢≢EYES) ↓ LSWITCH_END LINVALID_EYES
      LNO_EYES:
        ⎕←"ERROR: No eye string supplied for the argument '+e'!"
        PARSE_EXIT_PROGRAM←1 ◊ →LABORT
      LINVALID_EYES:
        ⎕←"ERROR: Invalid eye string ",EYES,"supplied for the argument '+e'! Must be 2 characters in length!"
        PARSE_EXIT_PROGRAM←1 ◊ →LABORT
    LSET_TOUNGE: ⍝ +T TOUNGE_STRING
      →(0≡≢ARGUMENTS) ↓ LTOUNGE LNO_TOUNGE
      LTOUNGE:
        TOUNGE←↑ARGUMENTS ◊ ARGUMENTS←1↓ARGUMENTS
        →(2≢≢TOUNGE) ↓ LSWITCH_END LINVALID_TOUNGE
      LNO_TOUNGE:
        ⎕←"ERROR: No tounge string supplied for the argument '+T'!"
        PARSE_EXIT_PROGRAM←1 ◊ →LABORT
      LINVALID_TOUNGE:
        ⎕←"ERROR: Invalid tounge string ",TOUNGE,"supplied for the argument '+T'! Must be 2 characters in length!"
        PARSE_EXIT_PROGRAM←1 ◊ →LABORT
    LSET_BORG_MODE: ⍝ +b
      EYES←"==" ◊ →LSWITCH_END
    LSET_DEAD: ⍝ +d
      EYES←"XX" ◊ TOUNGE←"U " ◊ →LSWITCH_END
    LSET_GREEDY: ⍝ +g
      EYES←"$$" ◊ →LSWITCH_END
    LSET_PARANOID: ⍝ +p
      EYES←"@@" ◊ →LSWITCH_END
    LSET_STONED: ⍝ +s
      EYES←"**" ◊ TOUNGE←"U " ◊ →LSWITCH_END
    LSET_TIRED: ⍝ +t
      EYES←"--" ◊ →LSWITCH_END
    LSET_WIRED: ⍝ +w
      EYES←"OO" ◊ →LSWITCH_END
    LSET_YOUTHFUL: ⍝ +y
      EYES←".." ◊ →LSWITCH_END
    LSWITCH_END:
      →LWHILE
  LWHILE_END:

LABORT:
∇
PARSE_ARGUMENTS



⍝ Takes a block of text ⍵ and splits it into strings that are ⍺ characters
⍝ long, and pads the final line with spaces to match the desired length.
⍝ Returns a character matrix.
SLICE_TEXT←{↑⍪/ ⍺{⍺{⍵⍴⍨⍺,⍨⍺÷⍨≢⍵}⍵,' '/⍨⍺{⍵-⍨⍺×1⌈⌈⍺÷⍨⍵}≢⍵}¨⍵}

⍝ Takes a character matrix ⍵ and adds characters to make it look like the text
⍝ is enveloped in a text bubble.
BUBBLIFY←{(2⌷⍴⍵){⍺{('/¯',(⍺/'¯'),'¯\')⍪⍵⍪'\_',(⍺/'_'),'_/'}⍵{(⍵⍴'| '),⍺,⍵⍴' |'}2,⍨↑⍴⍵}⍵}

∇DISPLAY_COW; TEXT;WIDTH
  ⍝ Because we can't use )OFF in a function, nor jumps outside of a function,
  ⍝ there is no way to conditionally exit the program. So instead, if we need to
  ⍝ exit, we just jump to the end of this function, where we later exit.
  →(PARSE_EXIT_PROGRAM) / LABORT

  ⍝ Gets the TEXT to go in text bubble, resulting in a vector of character
  ⍝ vectors, with each subvector being a line of text.
  →(0≡≢ARGUMENT_TEXT) ⍴ LUSE_STDIN
    TEXT←{⍺,' ',⍵}/ARGUMENT_TEXT ◊ →LDONT_USE_STDIN
  LUSE_STDIN:
    TEXT←FIO∆READ_ENTIRE_STDIN
  LDONT_USE_STDIN:

  ⍝ If DISABLE_WORD_WRAP≡1, the maximum width will be the width of the longest
  ⍝ line, else the width will be a maximum of TEXT_WIDTH.
  WIDTH←↑(DISABLE_WORD_WRAP+1)⌷{(⍵⌊1⌈TEXT_WIDTH),⍵}⌈/≢¨TEXT
  ⍝ Prints out the text bubble.
  ⍞←BUBBLIFY WIDTH SLICE_TEXT TEXT
  ⍝ Say.
  ⍞←{⍵,⍨' '⍴⍨WIDTH,⍨↑⍴⍵}⊃('\') (' \') ('   ^__^') ('   (',EYES,')\_______') ('   (__)\       )\/\') ('    ',TOUNGE,' ||----w |') ('       ||     ||')

LABORT:
∇
DISPLAY_COW



)OFF
