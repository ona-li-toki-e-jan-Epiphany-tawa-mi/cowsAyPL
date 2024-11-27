#!/usr/local/bin/apl --script

⍝ This file is part of cowsAyPL.
⍝
⍝ Copyright (c) 2024 ona-li-toki-e-jan-Epiphany-tawa-mi
⍝
⍝ cowsAyPL is free software: you can redistribute it and/or modify it under the
⍝ terms of the GNU General Public License as published by the Free Software
⍝ Foundation, either version 3 of the License, or (at your option) any later
⍝ version.
⍝
⍝ cowsAyPL is distributed in the hope that it will be useful, but WITHOUT ANY
⍝ WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
⍝ A PARTICULAR PURPOSE. See the GNU General Public License for more details.
⍝
⍝ You should have received a copy of the GNU General Public License along with
⍝ cowsAyPL. If not, see <https://www.gnu.org/licenses/>.

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

⊣ ⍎")COPY_ONCE fio.apl"
⊣ ⍎")COPY_ONCE logging.apl"



⍝ The path to the apl interpreter used to call this program.
ARGS∆APL_PATH←⍬
⍝ The name of this file/program.
ARGS∆PROGRAM_NAME←⍬
⍝ The maximum width of the text in the text bubble. Any text over the limit will be
⍝ word-wrapped. May be ≤ 0.
ARGS∆WIDTH←40
⍝ Whether to disable word wrapping. If set, the width of the bubble should be
⍝ that of the longest line, and TEXT_WIDTH should be ignored.
ARGS∆NO_WORD_WRAP←0
⍝ When the text to display is specified in the arguments of the command, it will
⍝ be put into this variable. The non-empty value will be a vector of character
⍝ vectors.
ARGS∆TEXT←⍬
⍝ The eyes to use for the cow. Must be a character vector of dimension 2.
ARGS∆EYES←"oo"
⍝ The tounge to use for the cow. Must be a character vector of dimension 2.
ARGS∆TOUNGE←"  "

⍝ Whether "++" was encountered, meaning all following option-like arguments are
⍝ to be treated as files.
ARGS∆END_OF_OPTIONS←0
⍝ For options with arguments. When set to 1, the next argument is evaluated as
⍝ the repsective option's argument.
ARGS∆EXPECT_WIDTH←0
ARGS∆EXPECT_EYES←0
ARGS∆EXPECT_TOUNGE←0

⍝ TODO make accept fd.
⍝ Displays a short help message.
∇ARGS∆DISPLAY_SHORT_HELP
  ⍞←"Try '",ARGS∆PROGRAM_NAME," -- +h' for more information\n"
  ⍞←"Try '",ARGS∆APL_PATH," --script ",ARGS∆PROGRAM_NAME," -- +h' for more information\n"
∇

⍝ TODO make accept fd.
⍝ Displays help information.
∇ARGS∆DISPLAY_HELP
  ⍞←"Usages:\n"
  ⍞←"  ",ARGS∆PROGRAM_NAME," -- [options...] [TEXT...]\n"
  ⍞←"  ",ARGS∆APL_PATH," --script ",ARGS∆PROGRAM_NAME," -- [options...] [TEXT...]\n"
  ⍞←"\n"
  ⍞←"Prints out text art of a cow saying the supplied TEXT within a speech bubble. If\n"
  ⍞←"no TEXT is supplied as arguments to the function, it will instead be pulled from\n"
  ⍞←"stdin until an EOF is reached.\n"
  ⍞←"\n"
  ⍞←"Options:\n"
  ⍞←"  +h\n"
  ⍞←"    Displays this help message and exits.\n"
  ⍞←"  +W WIDTH\n"
  ⍞←"    Unsinged integer. Sets the maximum WIDTH of lines within the generated text\n"
  ⍞←"    bubbles. Defaults to 40 Incompatible with +n.\n"
  ⍞←"  +n\n"
  ⍞←"    Prevents word wrapping. Width of the text bubble is the length of the\n"
  ⍞←"    largest line from TEXT. Incompatible with +W.\n"
  ⍞←"  +e EYES\n"
  ⍞←"    Sets the string for the EYES, must be 2 characters long. Incompatible with\n"
  ⍞←"    appearance presets.\n"
  ⍞←"  +T TOUNGE\n"
  ⍞←"    Sets the string for the TOUNGE, must be either 1 or 2 characters long. If\n"
  ⍞←"    only 1 character is supplied a space will be appended to it. Incompatible\n"
  ⍞←"    with a few appearance presets.\n"
  ⍞←"  +b\n"
  ⍞←"    Borg mode. Appearance preset. Incompatible with +e EYES and other presets.\n"
  ⍞←"  +d\n"
  ⍞←"    Dead. Appearance preset. Incompatible with +e EYES, +T TOUNGE, and other\n"
  ⍞←"    presets.\n"
  ⍞←"  +g\n"
  ⍞←"    Greedy. Appearance preset. Incompatible with +e EYES and other presets.\n"
  ⍞←"  +p\n"
  ⍞←"    Paranoid. Appearance preset. Incompatible with +e EYES and other presets.\n"
  ⍞←"  +s\n"
  ⍞←"    Stoned. Appearance preset. Incompatible with +e EYES, +T TOUNGE, and other\n"
  ⍞←"    presets.\n"
  ⍞←"  +t\n"
  ⍞←"    Tired. Appearance preset. Incompatible with +e EYES and other presets.\n"
  ⍞←"  +w\n"
  ⍞←"    Wired. Appearance preset. Incompatible with +e EYES and other presets\n"
  ⍞←"  +y\n"
  ⍞←"    Young. Appearance preset. Incompatible with +e EYES and other presets.\n"
∇

⍝ TODO make accept fd.
⍝ Displays the version.
∇ARGS∆DISPLAY_VERSION
  ⍞←"cowsaypl 1.2.2\n"
∇

⍝ Parses an scalar character OPTION (anything after a "+") and updates ARGS∆*
⍝ accordingly.
∇ARGS∆PARSE_OPTION OPTION
  →(OPTION≡¨'h' 'v' 'W' 'n' 'e' 'T' 'b' 'd' 'g' 'p' 's' 't' 'w' 'y') / LHELP LVERSION LSET_WIDTH LNO_WORD_WRAP LSET_EYES LSET_TOUNGE LBORG_MODE LDEAD LGREEDY LPARANOID LSTONED LTIRED LWIRED LYOUTHFUL
  LDEFAULT:
    ⊣ FIO∆STDERR FIO∆PRINTF_FD "ERROR: unknown option '+%s'\n" OPTION
    ARGS∆DISPLAY_SHORT_HELP
    ⍎")OFF 1"
  LHELP:         ARGS∆DISPLAY_HELP    ◊ ⍎")OFF"    ◊ →LSWITCH_END
  LVERSION:      ARGS∆DISPLAY_VERSION ◊ ⍎")OFF"    ◊ →LSWITCH_END
  LSET_WIDTH:    ARGS∆EXPECT_WIDTH←1               ◊ →LSWITCH_END
  LNO_WORD_WRAP: ARGS∆NO_WORD_WRAP←1               ◊ →LSWITCH_END
  LSET_EYES:     ARGS∆EXPECT_EYES←1                ◊ →LSWITCH_END
  LSET_TOUNGE:   ARGS∆EXPECT_TOUNGE←1              ◊ →LSWITCH_END
  LBORG_MODE:    ARGS∆EYES←"=="                    ◊ →LSWITCH_END
  LDEAD:         ARGS∆EYES←"XX" ◊ ARGS∆TOUNGE←"U " ◊ →LSWITCH_END
  LGREEDY:       ARGS∆EYES←"$$"                    ◊ →LSWITCH_END
  LPARANOID:     ARGS∆EYES←"@@"                    ◊ →LSWITCH_END
  LSTONED:       ARGS∆EYES←"**" ◊ ARGS∆TOUNGE←"U " ◊ →LSWITCH_END
  LTIRED:        ARGS∆EYES←"--"                    ◊ →LSWITCH_END
  LWIRED:        ARGS∆EYES←"OO"                    ◊ →LSWITCH_END
  LYOUTHFUL:     ARGS∆EYES←".."                    ◊ →LSWITCH_END
  LSWITCH_END:
∇

⍝ Parses a single character vector ARGUMENT and updates ARGS∆* accordingly.
∇ARGS∆PARSE_ARG ARGUMENT
  ⍝ If "++" was encountered, everything is text.
  →ARGS∆END_OF_OPTIONS ⍴ LTEXT
  ⍝ Handles arguments to options with arguments.
  →ARGS∆EXPECT_WIDTH ARGS∆EXPECT_EYES ARGS∆EXPECT_TOUNGE / LSET_WIDTH LSET_EYES LSET_TOUNGE
  ⍝ Handles "++".
  →("++"≡ARGUMENT) ⍴ LDOUBLE_PLUS
  ⍝ Handles options.
  →((1<≢ARGUMENT)∧'+'≡↑ARGUMENT) ⍴ LOPTION
  LTEXT:        ARGS∆TEXT←ARGS∆TEXT,⊂ARGUMENT  ◊ →LSWITCH_END
  LOPTION:      ARGS∆PARSE_OPTION¨ 1↓ARGUMENT  ◊ →LSWITCH_END
  LDOUBLE_PLUS: ARGS∆END_OF_OPTIONS←1          ◊ →LSWITCH_END
  LSET_WIDTH:
    →(∨/ARGUMENT∊"0123456789") ⍴ LVALID_WIDTH
      ⊣ FIO∆STDERR FIO∆PRINTF_FD "ERROR: invalid argument '%s' for option '+W': expected a whole number\n" ARGUMENT
      ARGS∆DISPLAY_SHORT_HELP
      ⍎")OFF 1"
    LVALID_WIDTH:
      ARGS∆WIDTH←⍎ARGUMENT
      ARGS∆EXPECT_WIDTH←0 ◊ →LSWITCH_END
  LSET_EYES:
    →(2≡≢ARGUMENT) ⍴ LVALID_EYES
      ⊣ FIO∆STDERR FIO∆PRINTF_FD "ERROR: invalid argument '%s' for option '+e': expected a string of length 2\n" ARGUMENT
      ARGS∆DISPLAY_SHORT_HELP
      ⍎")OFF 1"
    LVALID_EYES:
      ARGS∆EYES←ARGUMENT
      ARGS∆EXPECT_EYES←0 ◊ →LSWITCH_END
  LSET_TOUNGE:
    →(2≡≢ARGUMENT) ⍴ LVALID_TOUNGE
      ⊣ FIO∆STDERR FIO∆PRINTF_FD "ERROR: invalid argument '%s' for option '+T': expected a string of length 2\n" ARGUMENT
      ARGS∆DISPLAY_SHORT_HELP
      ⍎")OFF 1"
    LVALID_TOUNGE:
      ARGS∆TOUNGE←ARGUMENT
      ARGS∆EXPECT_TOUNGE←0 ◊ →LSWITCH_END
  LSWITCH_END:
∇

⍝ Parses a vector of character vectors ARGUMENTS and updates ARGS∆* accordingly.
∇ARGS∆PARSE_ARGS ARGUMENTS; INVALID_OPTION
  ⍝ ⎕ARG looks like "apl --script <script> -- [user arguments...]"

  ARGS∆APL_PATH←↑ARGUMENTS[1]
  ARGS∆PROGRAM_NAME←↑ARGUMENTS[3]
  →(4≥≢ARGUMENTS) ⍴ LNO_ARGUMENTS
    ARGS∆PARSE_ARG¨ 4↓ARGUMENTS
  LNO_ARGUMENTS:

  ⍝ Tests for any options with arguments that were not supplied an argument.
  →(~∨/ARGS∆EXPECT_WIDTH ARGS∆EXPECT_EYES ARGS∆EXPECT_TOUNGE) ⍴ LNO_INVALID_OPTIONS
  →ARGS∆EXPECT_WIDTH ARGS∆EXPECT_EYES ARGS∆EXPECT_TOUNGE / LSET_WIDTH LSET_EYES LSET_TOUNGE
  LSET_WIDTH:  INVALID_OPTION←"W" ◊ →LSWITCH_END
  LSET_EYES:   INVALID_OPTION←"e" ◊ →LSWITCH_END
  LSET_TOUNGE: INVALID_OPTION←"T" ◊ →LSWITCH_END
  LSWITCH_END:
    ⊣ FIO∆STDERR FIO∆PRINTF_FD "ERROR: expected argument for option for option '+%s'\n" INVALID_OPTION
    ARGS∆DISPLAY_SHORT_HELP
    ⍎")OFF 1"
  LNO_INVALID_OPTIONS:
∇



⍝ Takes a block of text ⍵ and splits it into strings that are ⍺ characters
⍝ long, and pads the final line with spaces to match the desired length.
⍝ Returns a character matrix.
SLICE_TEXT←{↑⍪/ ⍺{⍺{⍵⍴⍨⍺,⍨⍺÷⍨≢⍵}⍵,' '/⍨⍺{⍵-⍨⍺×1⌈⌈⍺÷⍨⍵}≢⍵}¨⍵}

⍝ Takes a character matrix ⍵ and adds characters to make it look like the text
⍝ is enveloped in a text bubble.
BUBBLIFY←{(2⌷⍴⍵){⍺{('/¯',(⍺/'¯'),'¯\')⍪⍵⍪'\_',(⍺/'_'),'_/'}⍵{(⍵⍴'| '),⍺,⍵⍴' |'}2,⍨↑⍴⍵}⍵}

∇MAIN; TEXT;WIDTH
  ARGS∆PARSE_ARGS ⎕ARG

  ⍝ Gets the TEXT to go in text bubble, resulting in a vector of character
  ⍝ vectors, with each subvector being a line of text.
  →(0≡≢ARGS∆TEXT) ⍴ LUSE_STDIN
    TEXT←{⍺,' ',⍵}/ARGS∆TEXT ◊ →LDONT_USE_STDIN
  LUSE_STDIN:
    TEXT←FIO∆READ_ENTIRE_FD FIO∆STDIN
    →(↑TEXT) ⍴ LREAD_SUCCESS
      ⊣ FIO∆STDERR FIO∆PRINTF_FD "ERROR: unable to read from stdin: %s" (↑1↓TEXT)
    LREAD_SUCCESS:
    TEXT←"\n" FIO∆SPLIT FIO∆BYTES_TO_UTF8 ↑1↓TEXT
  LDONT_USE_STDIN:

  ⍝ If ARGS∆NO_WORD_WRAP≡1, the maximum width will be the width of the longest
  ⍝ line, else the width will be a maximum of ARGS∆WIDTH.
  WIDTH←↑(ARGS∆NO_WORD_WRAP+1)⌷{(⍵⌊1⌈ARGS∆WIDTH),⍵}⌈/≢¨TEXT
  ⍝ say.
  ⍞←BUBBLIFY WIDTH SLICE_TEXT TEXT
  ⍝ cow. TODO make cow not move to the right.
  ⍞←{⍵,⍨' '⍴⍨WIDTH,⍨↑⍴⍵}⊃('\') (' \') ('   ^__^') ('   (',ARGS∆EYES,')\_______') ('   (__)\       )\/\') ('    ',ARGS∆TOUNGE,' ||----w |') ('       ||     ||')
∇
MAIN

)OFF
