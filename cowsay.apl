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
⍝ /¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\
⍝ | Cowsay in GnuAPL. |
⍝ \___________________/
⍝                      \
⍝                       \
⍝                         ^__^
⍝                         (oo)\_______
⍝                         (__)\       )\/\
⍝                             ||----w |
⍝                             ||     ||
⍝



⍝ Matches a singular integer, with or withou a minus sign,  with any number of
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



⍝ Whether the program should end after the argument parsing is done. This may be
⍝ because of it outputting help information, an error with the input, or some
⍝ other Reason.
PARSE_EXIT_PROGRAM←0
⍝ The maximum width of the text bubble. Any text over the limit will be
⍝ word-wrapped. A width ≤ 0 indicates no word wrapping.
BUBBLE_WIDTH←40
⍝ When the text to display is specified in the arguments of the command, it will
⍝ be put into this variable. If not empty, it will have a trailing space.
ARGUMENT_TEXT←⍬

∇DISPLAY_HELP
  ⎕←"TODO: Display help information..."
∇

⍝ Parses the arguments supplied from the command line and updates the preceeding
⍝ value(s) accordingly.
∇PARSE_ARGUMENTS; ARGUMENTS;ARGUMENT;FOUND_DOUBLE_PLUS
  ARGUMENTS←4↓⎕ARG ⍝ ⎕ARG returns: apl --script cowsay.apl -- [ARG...]
  ⍝ Indicates whether a '++' was found in the arguments, which means that all
  ⍝ further values are to be interpreted as text.
  FOUND_DOUBLE_PLUS←0

  L_WHILE: →(0≡≢ARGUMENTS) / L_WHILE_END
    ARGUMENT←↑ARGUMENTS ◊ ARGUMENTS←1↓ARGUMENTS

    →(~FOUND_DOUBLE_PLUS) / L_PARSE_NORMALLY
      ARGUMENT_TEXT←ARGUMENT_TEXT,ARGUMENT," "
      →L_WHILE
    L_PARSE_NORMALLY:

    →({ARGUMENT≡⍵}¨"+h" "+v" "+W" "++") / L_HELP L_VERSION L_SET_BUBBLE_WIDTH L_DOUBLE_PLUS
    L_OTHERWISE:
      →('+'≢↑ARGUMENT) ↓ L_OPTION L_NOT_OPTION
      L_OPTION:
        ⎕←"ERROR: unknown option: '",ARGUMENT,"'!"
        PARSE_EXIT_PROGRAM←1 ◊ →L_END
      L_NOT_OPTION:
        ARGUMENT_TEXT←ARGUMENT_TEXT,ARGUMENT," "
        →L_SWITCH_END
    L_HELP: ⍝ +h
      DISPLAY_HELP
      PARSE_EXIT_PROGRAM←1 ◊ →L_END
    L_VERSION: ⍝ +v
      ⎕←"cowsaypl 1.0.0"
      PARSE_EXIT_PROGRAM←1 ◊ →L_END
    L_SET_BUBBLE_WIDTH: ⍝ +W
      →(0≡≢ARGUMENTS) ↓ L_WIDTH L_NO_WIDTH
      L_WIDTH:
        ARGUMENT←↑ARGUMENTS ◊ ARGUMENTS←1↓ARGUMENTS
        BUBBLE_WIDTH←"INVALID" CVTI ARGUMENT
        →("INVALID"≡BUBBLE_WIDTH) ↓ L_SWITCH_END L_INVALID_WIDTH
      L_NO_WIDTH:
        ⎕←"ERROR: No width supplied for the argument '+W'!"
        PARSE_EXIT_PROGRAM←1 ◊ →L_END
      L_INVALID_WIDTH:
        ⎕←"ERROR: Invalid width specified for argument '+W'! '",ARGUMENT,"' is not a number!"
        PARSE_EXIT_PROGRAM←1 ◊ →L_END
    L_DOUBLE_PLUS: ⍝ ++
      FOUND_DOUBLE_PLUS←1 ◊ →L_SWITCH_END
    L_SWITCH_END:
      →L_WHILE
  L_WHILE_END:

L_END:
∇


⍝PARSE_ARGUMENTS
⍝⎕←ARGUMENT_TEXT
⍝)OFF
