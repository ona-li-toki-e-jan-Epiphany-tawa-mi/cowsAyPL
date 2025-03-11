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

⍝ Data types:
⍝  string - a character vector.

⍝ /¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\
⍝ | Cowsay in GNU APL |
⍝ \___________________/
⍝         \
⍝          \
⍝            ^__^
⍝            (oo)\_______
⍝            (__)\       )\/\
⍝                ||----w |
⍝                ||     ||

⊣ ⍎")COPY_ONCE fio.apl"

⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝
⍝ Argument Parsing                                                             ⍝
⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝

⍝ The path to the apl interpreter used to call this program.
⍝ Type: string.
ARGS∆apl_path←⍬
⍝ The name of this file/program.
⍝ Type: string.
ARGS∆program_name←⍬
⍝ The maximum width of the text in the text bubble. Any text over the limit will be
⍝ word-wrapped. May be ≤ 0.
ARGS∆width←40
⍝ Whether to disable word wrapping. If set, the width of the bubble should be
⍝ that of the longest line, and TEXT_WIDTH should be ignored.
ARGS∆no_word_wrap←0
⍝ When the text to display is specified in the arguments of the command, it will
⍝ be put into this variable.
⍝ Type: vector<string>.
ARGS∆text←⍬
⍝ The eyes to use for the cow. Must be a character vector of dimension 2.
⍝ Type: string.
ARGS∆eyes←"oo"
⍝ Type: string.
⍝ The tounge to use for the cow. Must be a character vector of dimension 2.
ARGS∆tounge←"  "

⍝ Displays help information.
∇ARGS∆DISPLAY_HELP
  ⍞←"Usages:\n"
  ⍞←"  ",ARGS∆program_name," -- [options...] [++] [TEXT...]\n"
  ⍞←"  ",ARGS∆apl_path," --script ",ARGS∆program_name," -- [options...] [++] [TEXT...]\n"
  ⍞←"\n"
  ⍞←"Prints out text art of a cow saying the supplied TEXT within a speech bubble. If\n"
  ⍞←"no TEXT is supplied as arguments to the function, it will instead be pulled from\n"
  ⍞←"stdin until an EOF is reached.\n"
  ⍞←"\n"
  ⍞←"Options:\n"
  ⍞←"  +h    Displays help and exits.\n"
  ⍞←"  +v    Displays version and exits.\n"
  ⍞←"  +l    Displays license and exits.\n"
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

⍝ Displays the version.
∇ARGS∆DISPLAY_VERSION
  ⍞←"cowsaypl 2.0.0\n"
∇

⍝ Displays the license and sources.
∇ARGS∆DISPLAY_LICENSE
  ⍞←"Copyright (c) 2024-2025 ona-li-toki-e-jan-Epiphany-tawa-mi\n"
  ⍞←"\n"
  ⍞←"cowsAyPL is free software: you can redistribute it and/or modify it under the\n"
  ⍞←"terms of the GNU General Public License as published by the Free Software\n"
  ⍞←"Foundation, either version 3 of the License, or (at your option) any later\n"
  ⍞←"version.\n"
  ⍞←"\n"
  ⍞←"cowsAyPL is distributed in the hope that it will be useful, but WITHOUT ANY\n"
  ⍞←"WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR\n"
  ⍞←"A PARTICULAR PURPOSE. See the GNU General Public License for more details.\n"
  ⍞←"\n"
  ⍞←"You should have received a copy of the GNU General Public License along with\n"
  ⍞←"cowsAyPL. If not, see <https://www.gnu.org/licenses/>.\n"
  ⍞←"\n"
  ⍞←"Source (paltepuk):\n"
  ⍞←"  https://paltepuk.xyz/cgit/cowsAyPL.git/about/\n"
  ⍞←"  (I2P) http://oytjumugnwsf4g72vemtamo72vfvgmp4lfsf6wmggcvba3qmcsta.b32.i2p/cgit/cowsAyPL.git/about/\n"
  ⍞←"  (Tor) http://4blcq4arxhbkc77tfrtmy4pptf55gjbhlj32rbfyskl672v2plsmjcyd.onion/cgit/cowsAyPL.git/about/\n"
  ⍞←"\n"
  ⍞←"Source (GitHub):\n"
  ⍞←"  https://github.com/ona-li-toki-e-jan-Epiphany-tawa-mi/cowsAyPL\n"
∇

⍝ Displays a short help message.
∇ARGS∆DISPLAY_SHORT_HELP
  ⍞←"Try '",ARGS∆program_name," -- +h' for more information\n"
  ⍞←"Try '",ARGS∆apl_path," --script ",ARGS∆program_name," -- +h' for more information\n"
∇

⍝ Argument parser width state.
⍝ →arguments: vector<string> - remaining command line arguments.
∇ARGS∆PARSE_WIDTH arguments; argument
  →(0≢≢arguments) ⍴ lhas_arguments
     ⊣ FIO∆stderr FIO∆PRINT_FD "ERROR: +W specified without argument\n"
     ARGS∆DISPLAY_SHORT_HELP
     ⍎")OFF 1"
  lhas_arguments:
  argument←↑arguments
  arguments←1↓arguments

  →(∨/argument∊"0123456789") ⍴ lvalid_width
    ⊣ FIO∆stderr FIO∆PRINTF_FD "ERROR: invalid argument '%s' for option +W: expected a whole number\n" argument
    ARGS∆DISPLAY_SHORT_HELP
    ⍎")OFF 1"
  lvalid_width:

  ARGS∆width←⍎argument
  ARGS∆PARSE_ARGUMENT arguments
∇

⍝ Argument parser eyes state.
⍝ →arguments: vector<string> - remaining command line arguments.
∇ARGS∆PARSE_EYES arguments; argument
  →(0≢≢arguments) ⍴ lhas_arguments
     ⊣ FIO∆stderr FIO∆PRINT_FD "ERROR: +e specified without argument\n"
     ARGS∆DISPLAY_SHORT_HELP
     ⍎")OFF 1"
  lhas_arguments:
  argument←↑arguments
  arguments←1↓arguments

  →(2≡≢argument) ⍴ lvalid_eyes
    ⊣ FIO∆stderr FIO∆PRINTF_FD "ERROR: invalid argument '%s' for option +e: expected a string of length 2\n" argument
    ARGS∆DISPLAY_SHORT_HELP
    ⍎")OFF 1"
  lvalid_eyes:

  ARGS∆eyes←argument
  ARGS∆PARSE_ARGUMENT arguments
∇

⍝ Argument parser tounge state.
⍝ →arguments: vector<string> - remaining command line arguments.
∇ARGS∆PARSE_TOUNGE arguments; argument
  →(0≢≢arguments) ⍴ lhas_arguments
     ⊣ FIO∆stderr FIO∆PRINT_FD "ERROR: +T specified without argument\n"
     ARGS∆DISPLAY_SHORT_HELP
     ⍎")OFF 1"
  lhas_arguments:
  argument←↑arguments
  arguments←1↓arguments

  →(2≥≢argument) ⍴ lvalid_tounge
    ⊣ FIO∆stderr FIO∆PRINTF_FD "ERROR: invalid argument '%s' for option +T: expected a string of length 2\n" argument
    ARGS∆DISPLAY_SHORT_HELP
    ⍎")OFF 1"
  lvalid_tounge:

  ARGS∆tounge←argument," "⍴⍨1≡≢argument
  ARGS∆PARSE_ARGUMENT arguments
∇

⍝ Argument parser options state.
⍝ →arguments: vector<string> - remaining command line arguments.
⍝ →options: string - options without leading '+'.
∇arguments ARGS∆PARSE_OPTIONS options; option
  →(0≢≢options) ⍴ lhas_options
    ARGS∆PARSE_ARGUMENT arguments ◊ →lend
  lhas_options:
  option←↑options
  options←1↓options

  →(option="hvlWneTbdgpstwy") / lhelp lversion llicense lset_width lno_word_wrap lset_eyes lset_tounge lborg_mode ldead lgreedy lparanoid lstoned ltired lwired lyouthful
    ⊣ FIO∆stderr FIO∆PRINTF_FD "ERROR: unknown option '+%s'\n" option
    ARGS∆DISPLAY_SHORT_HELP
    ⍎")OFF 1"
  lhelp:    ARGS∆DISPLAY_HELP    ◊ ⍎")OFF" ◊ →lswitch_end
  lversion: ARGS∆DISPLAY_VERSION ◊ ⍎")OFF" ◊ →lswitch_end
  llicense: ARGS∆DISPLAY_LICENSE ◊ ⍎")OFF" ◊ →lswitch_end
  lset_width:
    →(0≡≢options) ⍴ lwidth_is_next_argument
      ARGS∆PARSE_WIDTH arguments,⍨⊂options ◊ →lwidth_is_remaining_options
    lwidth_is_next_argument:
      ARGS∆PARSE_WIDTH arguments
    lwidth_is_remaining_options:
    →lswitch_end
  lno_word_wrap:
    ARGS∆no_word_wrap←1
    arguments ARGS∆PARSE_OPTIONS options ◊ →lswitch_end
  lset_eyes:
    →(0≡≢options) ⍴ leyes_is_next_argument
      ARGS∆PARSE_EYES arguments,⍨⊂options ◊ →leyes_is_remaining_options
    leyes_is_next_argument:
      ARGS∆PARSE_EYES arguments
    leyes_is_remaining_options:
    →lswitch_end
  lset_tounge:
    →(0≡≢options) ⍴ ltounge_is_next_argument
      ARGS∆PARSE_TOUNGE arguments,⍨⊂options ◊ →ltounge_is_remaining_options
    ltounge_is_next_argument:
      ARGS∆PARSE_TOUNGE arguments
    ltounge_is_remaining_options:
    →lswitch_end
  lborg_mode:
    ARGS∆eyes←"=="
    arguments ARGS∆PARSE_OPTIONS options ◊ →lswitch_end
  ldead:
    ARGS∆eyes←"XX" ◊ ARGS∆tounge←"U "
    arguments ARGS∆PARSE_OPTIONS options ◊ →lswitch_end
  lgreedy:
    ARGS∆eyes←"$$"
    arguments ARGS∆PARSE_OPTIONS options ◊ →lswitch_end
  lparanoid:
    ARGS∆eyes←"@@"
    arguments ARGS∆PARSE_OPTIONS options ◊ →lswitch_end
  lstoned:
    ARGS∆eyes←"**" ◊ ARGS∆tounge←"U "
    arguments ARGS∆PARSE_OPTIONS options ◊ →lswitch_end
  ltired:
    ARGS∆eyes←"--"
    arguments ARGS∆PARSE_OPTIONS options ◊ →lswitch_end
  lwired:
    ARGS∆eyes←"OO"
    arguments ARGS∆PARSE_OPTIONS options ◊ →lswitch_end
  lyouthful:
    ARGS∆eyes←".."
    arguments ARGS∆PARSE_OPTIONS options ◊ →lswitch_end
  lswitch_end:

lend:
∇

⍝ Argument parser argument state.
⍝ →arguments: vector<string> - remaining command line arguments.
∇ARGS∆PARSE_ARGUMENT arguments; argument
  →(0≡≢arguments) ⍴ lend
  argument←↑arguments
  arguments←1↓arguments

  →(0≡≢argument)   ⍴ lempty_argument
  →("++"≡argument) ⍴ ldouble_plus
  →('+'≡↑argument) ⍴ loption
    ⍝ Text.
    ARGS∆text←ARGS∆text,⊂argument
    ARGS∆PARSE_ARGUMENT arguments
    →lswitch_end
  lempty_argument:
    ARGS∆PARSE_ARGUMENT arguments
    →lswitch_end
  ldouble_plus:
    ARGS∆text←ARGS∆text,arguments
    →lswitch_end
  loption:
    →(1≤≢argument) ⍴ lnon_empty_option
      ⊣ FIO∆stderr FIO∆PRINT_FD "ERROR: + specified without option. Did you forget to put '++'?\n"
      ARGS∆DISPLAY_SHORT_HELP
      ⊣ ⍎")OFF 1"
    lnon_empty_option:
    arguments ARGS∆PARSE_OPTIONS 1↓argument
    →lswitch_end
  lswitch_end:

lend:
∇

⍝ Recursively parses command line arguments with a finite state machine and
⍝ updates ARGS∆* accordingly.
⍝ →arguments: vector<string>.
∇ARGS∆PARSE_ARGUMENTS arguments; invalid_option
  ⍝ arguments looks like "apl --script <script> -- [user arguments...]"
  ARGS∆apl_path←↑arguments
  ARGS∆program_name←↑arguments[3]
  →(4≤≢arguments) ⍴ lsufficient_arguments
    ⊣ FIO∆stderr FIO∆PRINT_FD "ERROR: insufficient arguments\n"
    ARGS∆DISPLAY_SHORT_HELP
    ⍎")OFF 1"
  lsufficient_arguments:
  →("--"≡↑arguments[4]) ⍴ lfound_dash_dash
    ⊣ FIO∆stderr FIO∆PRINTF_FD "ERROR: expected '--', but got '%s'\n" (↑arguments[4])
    ARGS∆DISPLAY_SHORT_HELP
    ⍎")OFF 1"
  lfound_dash_dash:

  →(4≥≢arguments) ⍴ lno_arguments
    ARGS∆PARSE_ARGUMENT 4↓arguments
  lno_arguments:
∇

⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝
⍝ Cowsay                                                                       ⍝
⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝

⍝ Takes a block of text, splitting it into strings that of a desired length, and
⍝ pads the final line with spaces to match the desired length, combining them
⍝ into a matrix.
⍝ →⍺: scalar whole number.
⍝ →⍵: vector<string> - text block.
⍝ ←: matrix<character>.
SLICE_TEXT←{↑⍪/ ⍺{⍺{⍵⍴⍨⍺,⍨⍺÷⍨≢⍵}⍵,' '/⍨⍺{⍵-⍨⍺×1⌈⌈⍺÷⍨⍵}≢⍵}¨⍵}

⍝ Takes a character matrix and adds characters to make it look like the text is
⍝ enveloped in a text bubble.
⍝ →⍵: matrix<character>.
⍝ ←: matrix<character>.
BUBBLIFY←{(2⌷⍴⍵){⍺{('/¯',(⍺/'¯'),'¯\')⍪⍵⍪'\_',(⍺/'_'),'_/'}⍵{(⍵⍴'| '),⍺,⍵⍴' |'}2,⍨↑⍴⍵}⍵}

∇MAIN; text;width
  ARGS∆PARSE_ARGUMENTS ⎕ARG

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
  ⍞←"\n"
  ⍝ cow.
  ⍞←"        \\\n"
  ⍞←"         \\\n"
  ⍞←"           ^__^\n"
  ⍞←"           (",ARGS∆eyes,")\\_______\n"
  ⍞←"           (__)\\       )\\/\\\n"
  ⍞←"            ",ARGS∆tounge," ||----w |\n"
  ⍞←"               ||     ||\n"
∇
MAIN

)OFF
