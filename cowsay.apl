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

⍝ Parses the arguments supplied from the command line and updates the preceeding
⍝ value(s) accordingly.
∇PARSE_ARGUMENTS
  ARGUMENTS←4↓⎕ARG ⍝ ⎕ARG returns: apl --script cowsay.apl [ARG...]
  L_WHILE: →(0≡≢ARGUMENTS) / L_WHILE_END
    ARGUMENT←↑ARGUMENTS ◊ ARGUMENTS←1↓ARGUMENTS
    →({ARGUMENT≡⍵}¨"+h" "++help" "+v" "++version") / L_HELP L_HELP L_VERSION L_VERSION
    L_OTHERWISE:  ⎕←"ERROR: unknown argument: '",ARGUMENT,"'" ◊ →L_SWITCH_END
    L_HELP:       ⎕←"TODO: Display help information..."       ◊ →L_SWITCH_END
    L_VERSION:    ⎕←"cowsaypl 1.0.0"                          ◊ →L_SWITCH_END
    L_SWITCH_END: →L_WHILE
  L_WHILE_END:
∇
PARSE_ARGUMENTS

)OFF
