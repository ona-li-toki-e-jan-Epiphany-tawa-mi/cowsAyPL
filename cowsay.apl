#!/usr/bin/apl --script --

⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝
⍝ MIT License                                                                  ⍝
⍝                                                                              ⍝
⍝ Copyright (c) 2022 ona-li-toki-e-jan-Epiphany-tawa-mi                        ⍝
⍝                                                                              ⍝
⍝ Permission is hereby granted, free of charge, to any person obtaining a copy ⍝
⍝ of this software and associated documentation files (the "Software"), to     ⍝
⍝ deal in the Software without restriction, including without limitation the   ⍝
⍝ rights to use, copy, modify, merge, publish, distribute, sublicense, and/or  ⍝
⍝ sell copies of the Software, and to permit persons to whom the Software is   ⍝
⍝ furnished to do so, subject to the following conditions:                     ⍝
⍝                                                                              ⍝
⍝ The above copyright notice and this permission notice shall be included in   ⍝
⍝ all copies or substantial portions of the Software.                          ⍝
⍝                                                                              ⍝
⍝ THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR   ⍝
⍝ IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,     ⍝
⍝ FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE  ⍝
⍝ AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER       ⍝
⍝ LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING      ⍝
⍝ FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS ⍝
⍝ IN THE SOFTWARE.                                                             ⍝
⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝

⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝
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
⍝



⍝ Partitions a vector ⍵, splitting it, where the given value ⍺ is present, into
⍝ a vector of vectors. The split value will not be present in the resulting
⍝ subvectors.
PARTITION_VOV←{⍺{⍵~⍺}¨⍵⊂⍨1++\⍺⍷⍵}

⍝ Matches a singular integer, with or without a minus sign, with any number of
⍝ leading or trailing spaces.
RE_MATCH_NUMBER←'^\s*-?[0-9]+\s*$'

⍝ Attempts to convert a character vector to scalar integer. If the vector does
⍝ not represent a valid integer, the default value will be returned instead.
∇INTEGER←DEFAULT CVTI CVECTOR
  CVECTOR←RE_MATCH_NUMBER ⎕RE CVECTOR ⍝ if CVECTOR is not a number, returns
                                      ⍝ empty vector.
  →(~×⍴CVECTOR) ↓ L_A_NUMBER L_NOT_A_NUMBER
  L_A_NUMBER:     INTEGER←⍎CVECTOR ◊ →L_END_IF
  L_NOT_A_NUMBER: INTEGER←DEFAULT  ◊ →L_END_IF
  L_END_IF:
∇

⍝ The file handle for stdin for working with ⎕FIO.
FIO_STDIN←0
⍝ Zb ← ⎕FIO[6] Bh    fread(Zi, 1, 5000, Bh) 1 byte per Zb.
⍝ ⎕FIO function. Reads up to 5000 bytes from the given handle and outputs them
⍝ as a byte vector.
FIO_FREAD←6
⍝ Zi ← ⎕FIO[10] Bh    feof(Bh).
⍝ ⎕FIO function. Checks the end-of-file flag of the handle, returning non-zero
⍝ if it is set.
FIO_FEOF←10
⍝ The numerical value of a line feed character.
FIO_LINE_FEED←10

⍝ TODO see if unicode characters can be added together to make ⎕UCS convert them
⍝ properly.
⍝ Reads input from stdin until EOF is reached and outputs the contents as a
⍝ vector of character vectors, each vector representing a line.
∇CCVECTOR←STDIN
  CCVECTOR←⍬
  L_READ_LOOP:
    CCVECTOR←CCVECTOR,(⎕FIO[FIO_FREAD] FIO_STDIN)
    →(0≢(⎕FIO[FIO_FEOF] FIO_STDIN)) ↓ L_READ_LOOP L_EOF
  L_EOF:
  CCVECTOR←⎕UCS¨ FIO_LINE_FEED PARTITION_VOV CCVECTOR
∇



HELP_MESSAGE←"""
    cowsaypl - cowsay written in GnuAPL.

SYNOPSIS:
    cowsaypl [+bdgpstwy] [+h] [+v] [+e EYES] [+T TOUNGE] [+n|+W WIDTH] [++]
             [TEXT...]

DESCRIPTION:
    Prints out ASCII art of a cow saying the supplied text within a speech
    bubble. If no text is supplied as arguments to the function, it will instead
    be pulled from STDIN until an EOF is reached.

    The maximum width of the text bubble defaults to 40. If any lines of text
    supplied exceed that length, they will be word-wrapped. If the max line size
    is smaller than the max width, the max line size will be used for the size of
    the text bubble. The max width can be set with +W WIDTH, or word-wrapping
    can be disabled completely using +n.

    The cow's appearance can either be set to a preset (using any of +bdgpstwy)
    or custom set using +e EYES and/or +T TOUNGE.

    Note that you cannot specify multiple options with one plus, i.e. '+be 00'
    is invalid, and instead you would use '+b +e 00'.

    Currently cowsaypl cannot print out Unicode characters. might fix at a later
    date.

COMMAND LINE OPTIONS:
    +h
        Displays this help message and exits.

    +W WIDTH
        Integer. Sets the maximum WIDTH of lines within the generated text
        bubbles. Incompatible with +n.

    +n
        Prevents word wrapping. Width of the text bubble is the length of the
        largest line from TEXT. Incompatible with +W.

    +e EYES
        Sets the string for the EYES, must be 2 characters long. Incompatible
        with appearance presets.

    +T TOUNGE
        Sets the string for the TOUNGE, must be either 1 or 2 characters long.
        If only 1 character is supplied a space will be appended to it.
        Incompatible with a few appearance presets.

    +b
        Borg mode. Appearance preset. Incompatible with +e EYES and other
        presets.

    +d
        Dead. Appearance preset. Incompatible with +e EYES, +T TOUNGE, and other
        presets.

    +g
        Greedy. Appearance preset. Incompatible with +e EYES and other presets.

    +p
        Paranoid. Appearance preset. Incompatible with +e EYES and other
        presets.

    +s
        Stoned. Appearance preset. Incompatible with +e EYES, +T TOUNGE, and
        other presets.

    +t
        Tired. Appearance preset. Incompatible with +e EYES and other presets.

    +w
        Wired. Appearance preset. Incompatible with +e EYES and other presets.

    +y
        Young. Appearance preset. Incompatible with +e EYES and other presets.

AUTHOR(S):
    ona li toki e jan Epiphany tawa mi.

BUGS:
    Report bugs to <https://github.com/ona-li-toki-e-jan-Epiphany-tawa-mi/cowsAy
    PL/issues>.

COPYRIGHT:
    MIT License

    Copyright (c) 2022 ona-li-toki-e-jan-Epiphany-tawa-mi

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the Software), to
    deal in the Software without restriction, including without limitation the
    rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
    sell copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
    IN THE SOFTWARE.
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

⍝ Parses the arguments supplied from the command line and updates the preceeding
⍝ variable(s) accordingly.
∇PARSE_ARGUMENTS; ARGUMENTS;ARGUMENT;FOUND_DOUBLE_PLUS
  ARGUMENTS←4↓⎕ARG ⍝ ⎕ARG returns: apl --script cowsay.apl -- [ARG...]
  ⍝ Indicates whether a '++' was found in the arguments, which means that all
  ⍝ further values are to be interpreted as text.
  FOUND_DOUBLE_PLUS←0

  L_WHILE: →(0≡≢ARGUMENTS) / L_WHILE_END
    ARGUMENT←↑ARGUMENTS ◊ ARGUMENTS←1↓ARGUMENTS

    →(~FOUND_DOUBLE_PLUS) / L_PARSE_NORMALLY
      ARGUMENT_TEXT←ARGUMENT_TEXT,⊂ARGUMENT
      →L_WHILE
    L_PARSE_NORMALLY:

    →({ARGUMENT≡⍵}¨"+h" "+v" "+W" "++" "+n" "+e" "+T" "+b" "+d" "+g" "+p" "+s" "+t" "+w" "+y") / L_HELP L_VERSION L_SET_TEXT_WIDTH L_DOUBLE_PLUS L_DISABLE_WORD_WRAP L_SET_EYES L_SET_TOUNGE L_SET_BORG_MODE L_SET_DEAD L_SET_GREEDY L_SET_PARANOID L_SET_STONED L_SET_TIRED L_SET_WIRED L_SET_YOUTHFUL
    L_OTHERWISE:
      →('+'≢↑ARGUMENT) ↓ L_OPTION L_NOT_OPTION
      L_OPTION:
        ⎕←"ERROR: unknown option: '",ARGUMENT,"'!"
        PARSE_EXIT_PROGRAM←1 ◊ →L_ABORT
      L_NOT_OPTION:
        ARGUMENT_TEXT←ARGUMENT_TEXT,⊂ARGUMENT
        →L_SWITCH_END
    L_HELP: ⍝ +h
      ⍞←⊃HELP_MESSAGE
      PARSE_EXIT_PROGRAM←1 ◊ →L_ABORT
    L_VERSION: ⍝ +v
      ⎕←"cowsaypl 1.0.0"
      PARSE_EXIT_PROGRAM←1 ◊ →L_ABORT
    L_SET_TEXT_WIDTH: ⍝ +W WIDTH
      →(0≡≢ARGUMENTS) ↓ L_WIDTH L_NO_WIDTH
      L_WIDTH:
        ARGUMENT←↑ARGUMENTS ◊ ARGUMENTS←1↓ARGUMENTS
        TEXT_WIDTH←"INVALID" CVTI ARGUMENT
        →("INVALID"≡TEXT_WIDTH) ↓ L_SWITCH_END L_INVALID_WIDTH
      L_NO_WIDTH:
        ⎕←"ERROR: No width supplied for the argument '+W'!"
        PARSE_EXIT_PROGRAM←1 ◊ →L_ABORT
      L_INVALID_WIDTH:
        ⎕←"ERROR: Invalid width specified for argument '+W'! '",ARGUMENT,"' is not a number!"
        PARSE_EXIT_PROGRAM←1 ◊ →L_ABORT
    L_DOUBLE_PLUS: ⍝ ++
      FOUND_DOUBLE_PLUS←1 ◊ →L_SWITCH_END
    L_DISABLE_WORD_WRAP: ⍝ +n
      DISABLE_WORD_WRAP←1 ◊ →L_SWITCH_END
    L_SET_EYES: ⍝ +e EYE_STRING
      →(0≡≢ARGUMENTS) ↓ L_EYES L_NO_EYES
      L_EYES:
        EYES←↑ARGUMENTS ◊ ARGUMENTS←1↓ARGUMENTS
        →(2≢≢EYES) ↓ L_SWITCH_END L_INVALID_EYES
      L_NO_EYES:
        ⎕←"ERROR: No eye string supplied for the argument '+e'!"
        PARSE_EXIT_PROGRAM←1 ◊ →L_ABORT
      L_INVALID_EYES:
        ⎕←"ERROR: Invalid eye string ",EYES,"supplied for the argument '+e'! Must be 2 characters in length!"
        PARSE_EXIT_PROGRAM←1 ◊ →L_ABORT
    L_SET_TOUNGE: ⍝ +T TOUNGE_STRING
      →(0≡≢ARGUMENTS) ↓ L_TOUNGE L_NO_TOUNGE
      L_TOUNGE:
        TOUNGE←↑ARGUMENTS ◊ ARGUMENTS←1↓ARGUMENTS
        →(2≢≢TOUNGE) ↓ L_SWITCH_END L_INVALID_TOUNGE
      L_NO_TOUNGE:
        ⎕←"ERROR: No tounge string supplied for the argument '+T'!"
        PARSE_EXIT_PROGRAM←1 ◊ →L_ABORT
      L_INVALID_TOUNGE:
        ⎕←"ERROR: Invalid tounge string ",TOUNGE,"supplied for the argument '+T'! Must be 2 characters in length!"
        PARSE_EXIT_PROGRAM←1 ◊ →L_ABORT
    L_SET_BORG_MODE: ⍝ +b
      EYES←"==" ◊ →L_SWITCH_END
    L_SET_DEAD: ⍝ +d
      EYES←"XX" ◊ TOUNGE←"U " ◊ →L_SWITCH_END
    L_SET_GREEDY: ⍝ +g
      EYES←"$$" ◊ →L_SWITCH_END
    L_SET_PARANOID: ⍝ +p
      EYES←"@@" ◊ →L_SWITCH_END
    L_SET_STONED: ⍝ +s
      EYES←"**" ◊ TOUNGE←"U " ◊ →L_SWITCH_END
    L_SET_TIRED: ⍝ +t
      EYES←"--" ◊ →L_SWITCH_END
    L_SET_WIRED: ⍝ +w
      EYES←"OO" ◊ →L_SWITCH_END
    L_SET_YOUTHFUL: ⍝ +y
      EYES←".." ◊ →L_SWITCH_END
    L_SWITCH_END:
      →L_WHILE
  L_WHILE_END:

L_ABORT:
∇
PARSE_ARGUMENTS



∇DISPLAY_COW; TEXT;WIDTH;COW
  ⍝ Because we can't use )OFF in a function, nor jumps outside of a function,
  ⍝ there is no way to conditionally exit the program. So instead, if we need to
  ⍝ exit, we just jump to the end of this function, where we later exit.
  →(PARSE_EXIT_PROGRAM) / L_ABORT

  ⍝ Gets the TEXT to go in text bubble, resulting in a vector of character
  ⍝ vectors, with each subvector being a line of text.
  →(0≡≢ARGUMENT_TEXT) ↓ L_USE_ARGUMENT_TEXT L_USE_STDIN
  L_USE_ARGUMENT_TEXT: TEXT←{⍺,' ',⍵}/ARGUMENT_TEXT ◊ →L_END_IF
  L_USE_STDIN:         TEXT←STDIN                   ◊ →L_END_IF
  L_END_IF:

  ⍝ If DISABLE_WORD_WRAP≡1, the maximum width will be the width of the longest
  ⍝ line, else the width will be a maximum of TEXT_WIDTH.
  WIDTH←↑(DISABLE_WORD_WRAP+1)⌷{(⍵⌊1⌈TEXT_WIDTH),⍵}⌈/≢¨TEXT
  ⍝ Pads each line with spaces, so that it's length is divisible by WIDTH, and
  ⍝ splits them apart to be WIDTH characters long, returning a character matrix.
  TEXT←↑⍪/ WIDTH{⍺{⍵⍴⍨⍺,⍨⍺÷⍨≢⍵}⍵,' '/⍨⍺{⍵-⍨⍺×1⌈⌈⍺÷⍨⍵}≢⍵}¨TEXT
  ⍝ Creates a border around the TEXT that makes it look like a speech bubble.
  TEXT←WIDTH{⍺{('/¯',(⍺/'¯'),'¯\')⍪⍵⍪'\_',(⍺/'_'),'_/'}⍵{(⍵⍴'| '),⍺,⍵⍴' |'}2,⍨↑⍴⍵}TEXT
  ⍝ Say.
  COW←⊃('\') (' \') ('   ^__^') ('   (',EYES,')\_______') ('   (__)\       )\/\') ('    ',TOUNGE,' ||----w |') ('       ||     ||')
  ⍝ Offset cow to end of text bubble and print the finished product.
  ⍞←TEXT
  ⍞←(COW,⍨' '⍴⍨WIDTH,⍨↑⍴COW)

L_ABORT:
∇
DISPLAY_COW



)OFF
