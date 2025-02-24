#!/usr/local/bin/apl --script

⍝ This file is part of cowsAyPL.
⍝
⍝ Copyright (c) 2024-2025 ona-li-toki-e-jan-Epiphany-tawa-mi
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

⍝ /¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\
⍝ | Cowsay in GNU APL |
⍝ \___________________/
⍝                  \
⍝                   \
⍝                     ^__^
⍝                     (oo)\_______
⍝                     (__)\       )\/\
⍝                         ||----w |
⍝                         ||     ||

⊣ ⍎")COPY_ONCE fio.apl"

⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝
⍝ Argument Parsing                                                             ⍝
⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝

⍝ The path to the apl interpreter used to call this program.
ARGS∆apl_path←⍬
⍝ The name of this file/program.
ARGS∆program_name←⍬
⍝ The maximum width of the text in the text bubble. Any text over the limit will be
⍝ word-wrapped. May be ≤ 0.
ARGS∆width←40
⍝ Whether to disable word wrapping. If set, the width of the bubble should be
⍝ that of the longest line, and TEXT_WIDTH should be ignored.
ARGS∆no_word_wrap←0
⍝ When the text to display is specified in the arguments of the command, it will
⍝ be put into this variable. The non-empty value will be a vector of character
⍝ vectors.
ARGS∆text←⍬
⍝ The eyes to use for the cow. Must be a character vector of dimension 2.
ARGS∆eyes←"oo"
⍝ The tounge to use for the cow. Must be a character vector of dimension 2.
ARGS∆tounge←"  "

⍝ Whether "++" was encountered, meaning all following option-like arguments are
⍝ to be treated as files.
ARGS∆end_of_options←0
⍝ For options with arguments. When set to 1, the next argument is evaluated as
⍝ the repsective option's argument.
ARGS∆expect_width←0
ARGS∆expect_eyes←0
ARGS∆expect_tounge←0

⍝ TODO make accept fd.
⍝ Displays a short help message.
∇ARGS∆DISPLAY_SHORT_HELP
  ⍞←"Try '",ARGS∆program_name," -- +h' for more information\n"
  ⍞←"Try '",ARGS∆apl_path," --script ",ARGS∆program_name," -- +h' for more information\n"
∇

⍝ TODO make accept fd.
⍝ Displays help information.
∇ARGS∆DISPLAY_HELP
  ⍞←"Usages:\n"
  ⍞←"  ",ARGS∆program_name," -- [options...] [TEXT...]\n"
  ⍞←"  ",ARGS∆apl_path," --script ",ARGS∆program_name," -- [options...] [TEXT...]\n"
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
  ⍞←"cowsaypl 1.2.3\n"
∇

⍝ Parses an scalar character OPTION (anything after a "+") and updates ARGS∆*
⍝ accordingly.
∇ARGS∆PARSE_OPTION option
  →(option≡¨'h' 'v' 'W' 'n' 'e' 'T' 'b' 'd' 'g' 'p' 's' 't' 'w' 'y') / lhelp lversion lset_width lno_word_wrap lset_eyes lset_tounge lborg_mode ldead lgreedy lparanoid lstoned ltired lwired lyouthful
  LDEFAULT:
    ⊣ FIO∆stderr FIO∆PRINTF_FD "ERROR: unknown option '+%s'\n" option
    ARGS∆DISPLAY_SHORT_HELP
    ⍎")OFF 1"
  lhelp:         ARGS∆DISPLAY_HELP    ◊ ⍎")OFF"    ◊ →lswitch_end
  lversion:      ARGS∆DISPLAY_VERSION ◊ ⍎")OFF"    ◊ →lswitch_end
  lset_width:    ARGS∆expect_width←1               ◊ →lswitch_end
  lno_word_wrap: ARGS∆no_word_wrap←1               ◊ →lswitch_end
  lset_eyes:     ARGS∆expect_eyes←1                ◊ →lswitch_end
  lset_tounge:   ARGS∆expect_tounge←1              ◊ →lswitch_end
  lborg_mode:    ARGS∆eyes←"=="                    ◊ →lswitch_end
  ldead:         ARGS∆eyes←"XX" ◊ ARGS∆tounge←"U " ◊ →lswitch_end
  lgreedy:       ARGS∆eyes←"$$"                    ◊ →lswitch_end
  lparanoid:     ARGS∆eyes←"@@"                    ◊ →lswitch_end
  lstoned:       ARGS∆eyes←"**" ◊ ARGS∆tounge←"U " ◊ →lswitch_end
  ltired:        ARGS∆eyes←"--"                    ◊ →lswitch_end
  lwired:        ARGS∆eyes←"OO"                    ◊ →lswitch_end
  lyouthful:     ARGS∆eyes←".."                    ◊ →lswitch_end
  lswitch_end:
∇

⍝ Parses a single character vector argument and updates ARGS∆* accordingly.
∇ARGS∆PARSE_ARG argument
  ⍝ If "++" was encountered, everything is text.
  →ARGS∆end_of_options ⍴ ltext
  ⍝ Handles arguments to options with arguments.
  →ARGS∆expect_width ARGS∆expect_eyes ARGS∆expect_tounge / lset_width lset_eyes lset_tounge
  ⍝ Handles "++".
  →("++"≡argument) ⍴ ldouble_plus
  ⍝ Handles options.
  →((1<≢argument)∧'+'≡↑argument) ⍴ loption
  ltext:        ARGS∆text←ARGS∆text,⊂argument  ◊ →lswitch_end
  loption:      ARGS∆PARSE_OPTION¨ 1↓argument  ◊ →lswitch_end
  ldouble_plus: ARGS∆end_of_options←1          ◊ →lswitch_end
  lset_width:
    →(∨/argument∊"0123456789") ⍴ lvalid_width
      ⊣ FIO∆stderr FIO∆PRINTF_FD "ERROR: invalid argument '%s' for option '+W': expected a whole number\n" argument
      ARGS∆DISPLAY_SHORT_HELP
      ⍎")OFF 1"
    lvalid_width:
      ARGS∆width←⍎argument
      ARGS∆expect_width←0 ◊ →lswitch_end
  lset_eyes:
    →(2≡≢argument) ⍴ lvalid_eyes
      ⊣ FIO∆stderr FIO∆PRINTF_FD "ERROR: invalid argument '%s' for option '+e': expected a string of length 2\n" argument
      ARGS∆DISPLAY_SHORT_HELP
      ⍎")OFF 1"
    lvalid_eyes:
      ARGS∆eyes←argument
      ARGS∆expect_eyes←0 ◊ →lswitch_end
  lset_tounge:
    →(2≡≢argument) ⍴ lvalid_tounge
      ⊣ FIO∆stderr FIO∆PRINTF_FD "ERROR: invalid argument '%s' for option '+T': expected a string of length 2\n" argument
      ARGS∆DISPLAY_SHORT_HELP
      ⍎")OFF 1"
    lvalid_tounge:
      ARGS∆tounge←argument
      ARGS∆expect_tounge←0 ◊ →lswitch_end
  lswitch_end:
∇

⍝ Parses a vector of character vectors arguments and updates ARGS∆* accordingly.
∇ARGS∆PARSE_ARGS arguments; invalid_option
  ⍝ ⎕ARG looks like "apl --script <script> -- [user arguments...]"

  ARGS∆apl_path←↑arguments[1]
  ARGS∆program_name←↑arguments[3]
  →(4≥≢arguments) ⍴ lno_arguments
    ARGS∆PARSE_ARG¨ 4↓arguments
  lno_arguments:

  ⍝ Tests for any options with arguments that were not supplied an argument.
  →(~∨/ARGS∆expect_width ARGS∆expect_eyes ARGS∆expect_tounge) ⍴ lno_invalid_options
  →ARGS∆expect_width ARGS∆expect_eyes ARGS∆expect_tounge / lset_width lset_eyes lset_tounge
  lset_width:  invalid_option←"W" ◊ →lswitch_end
  lset_eyes:   invalid_option←"e" ◊ →lswitch_end
  lset_tounge: invalid_option←"T" ◊ →lswitch_end
  lswitch_end:
    ⊣ FIO∆stderr FIO∆PRINTF_FD "ERROR: expected argument for option for option '+%s'\n" invalid_option
    ARGS∆DISPLAY_SHORT_HELP
    ⍎")OFF 1"
  lno_invalid_options:
∇

⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝
⍝ Cowsay                                                                       ⍝
⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝

⍝ Takes a block of text ⍵ and splits it into strings that are ⍺ characters
⍝ long, and pads the final line with spaces to match the desired length.
⍝ Returns a character matrix.
SLICE_TEXT←{↑⍪/ ⍺{⍺{⍵⍴⍨⍺,⍨⍺÷⍨≢⍵}⍵,' '/⍨⍺{⍵-⍨⍺×1⌈⌈⍺÷⍨⍵}≢⍵}¨⍵}

⍝ Takes a character matrix ⍵ and adds characters to make it look like the text
⍝ is enveloped in a text bubble.
BUBBLIFY←{(2⌷⍴⍵){⍺{('/¯',(⍺/'¯'),'¯\')⍪⍵⍪'\_',(⍺/'_'),'_/'}⍵{(⍵⍴'| '),⍺,⍵⍴' |'}2,⍨↑⍴⍵}⍵}

∇MAIN; text;width
  ARGS∆PARSE_ARGS ⎕ARG

  ⍝ Gets the text to go in text bubble, resulting in a vector of character
  ⍝ vectors, with each subvector being a line of text.
  →(0≡≢ARGS∆text) ⍴ luse_stdin
    text←{⍺,' ',⍵}/ARGS∆text ◊ →ldont_use_stdin
  luse_stdin:
    text←FIO∆READ_ENTIRE_FD FIO∆stdin
    →(↑text) ⍴ lread_success
      ⊣ FIO∆stderr FIO∆PRINTF_FD "ERROR: unable to read from stdin: %s" (↑1↓text)
    lread_success:
    text←"\n" FIO∆SPLIT FIO∆BYTES_TO_UTF8 ↑1↓text
  ldont_use_stdin:

  ⍝ If ARGS∆no_word_wrap≡1, the maximum width will be the width of the longest
  ⍝ line, else the width will be a maximum of ARGS∆width.
  width←↑(ARGS∆no_word_wrap+1)⌷{(⍵⌊1⌈ARGS∆width),⍵}⌈/≢¨text
  ⍝ say.
  ⍞←BUBBLIFY width SLICE_TEXT text
  ⍝ cow. TODO make cow not move to the right.
  ⍞←{⍵,⍨' '⍴⍨width,⍨↑⍴⍵}⊃('\') (' \') ('   ^__^') ('   (',ARGS∆eyes,')\_______') ('   (__)\       )\/\') ('    ',ARGS∆tounge,' ||----w |') ('       ||     ||')
∇
MAIN

)OFF
