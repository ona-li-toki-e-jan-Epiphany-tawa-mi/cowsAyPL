#!/usr/local/bin/apl --script

⍝ This file is a modified copy of test.apl from AHD, which you can find at one
⍝ of the following links:
⍝ - I2P: http://oytjumugnwsf4g72vemtamo72vfvgmp4lfsf6wmggcvba3qmcsta.b32.i2p/cgit/AHD.git/about
⍝ - Tor: http://4blcq4arxhbkc77tfrtmy4pptf55gjbhlj32rbfyskl672v2plsmjcyd.onion/cgit/AHD.git/about
⍝ - Clearnet: https://github.com/ona-li-toki-e-jan-Epiphany-tawa-mi/AHD
⍝
⍝ ==============================================================================
⍝
⍝ This file is part of AHD.
⍝
⍝ Copyright (c) 2024 ona-li-toki-e-jan-Epiphany-tawa-mi
⍝
⍝ AHD is free software: you can redistribute it and/or modify it under the terms
⍝ of the GNU General Public License as published by the Free Software
⍝ Foundation, either version 3 of the License, or (at your option) any later
⍝ version.
⍝
⍝ AHD is distributed in the hope that it will be useful, but WITHOUT ANY
⍝ WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
⍝ A PARTICULAR PURPOSE. See the GNU General Public License for more details.
⍝
⍝ You should have received a copy of the GNU General Public License along with
⍝ AHD. If not, see <https://www.gnu.org/licenses/>.

⍝ cowsAyPL integration testing script.

⊣ ⍎")COPY_ONCE fio.apl"
⊣ ⍎")COPY_ONCE logging.apl"



⍝ The path to the apl interpreter used to call this program.
ARGS∆APL_PATH←⍬
⍝ The name of this file/program.
ARGS∆PROGRAM_NAME←⍬
⍝ The action/subcommand to preform.
ARGS∆ACTION←⍬
⍝ The path of the sources folder.
ARGS∆SOURCES_FOLDER←⍬
⍝ The paths of the files in the sources folder.
ARGS∆SOURCES_FILENAMES←⍬
⍝ The name of the outputs folder.
ARGS∆OUTPUTS_FOLDER←⍬

⍝ Displays help information.
∇ARGS∆DISPLAY_HELP
  ⍞←"Usages:\n"
  ⍞←"  ",ARGS∆PROGRAM_NAME," -- (record|test) SOURCES OUTPUTS\n"
  ⍞←"  ",ARGS∆APL_PATH," --script ",ARGS∆PROGRAM_NAME," -- (record|test) SOURCES OUTPUTS\n"
  ⍞←"\n"
  ⍞←"Subcommand record:\n"
  ⍞←"  Run cowsAyPL on the files in the SOURCES directory and record the output into\n"
  ⍞←"  files in the OUTPUTS directory, overwriting existing files.\n"
  ⍞←"\n"
  ⍞←"  Note that the OUTPUTS directory will not be created if it doesn't exist.\n"
  ⍞←"\n"
  ⍞←"Subcommand test:\n"
  ⍞←"  Run cowsAyPL on the files in the SOURCES directory compare their output to\n"
  ⍞←"  files created by record in the OUTPUTS directory. If the outputs differ,\n"
  ⍞←"  error message will be printed out on stderr. I couldn't get exit error codes\n"
  ⍞←"  working right (GnuAPL amirite?,) so some external logic will be required.\n"
  ⍞←"\n"
  ⍞←"Note: this tool will not recurse through directories, so all files must be at\n"
  ⍞←"the top-level of the supplied directories."
∇

⍝ Parses command line arguments and updates ARGS∆* accordingly.
∇ARGS∆PARSE_ARGS ARGUMENTS
  ⍝ ARGUMENTS looks like "<apl path> --script <script> -- [user arguments...]"

  ARGS∆APL_PATH←↑ARGUMENTS[1]
  ARGS∆PROGRAM_NAME←↑ARGUMENTS[3]

  ⍝ 4 for APL and it's arguments.
  ⍝ 3 for user arguments.
  →((3+4)≤≢ARGUMENTS) ⍴ LSUFFICIENT_ARGUMENTS
    ARGS∆DISPLAY_HELP
    ⍞←"\n" ◊ PANIC "insufficient arguments"
  LSUFFICIENT_ARGUMENTS:

  ARGS∆ACTION←↑ARGUMENTS[5]
  ARGS∆SOURCES_FOLDER←↑ARGUMENTS[6]
  ARGS∆OUTPUTS_FOLDER←↑ARGUMENTS[7]

  →((⊂ARGS∆ACTION)∊"record" "test") ⍴ LVALID_ACTION
    ARGS∆DISPLAY_HELP
    ⍞←"\n" ◊ PANIC "invalid action '",ARGS∆ACTION,"'"
  LVALID_ACTION:

  ⍝ Checks if sources folder exists and gets filenames.
  ARGS∆SOURCES_FILENAMES←FIO∆LIST_DIRECTORY ARGS∆SOURCES_FOLDER
  →(¯2≢ARGS∆SOURCES_FILENAMES) ⍴ LSOURCES_FOLDER_EXISTS
    PANIC "sources folder '",ARGS∆SOURCES_FOLDER,"' does not exist"
  LSOURCES_FOLDER_EXISTS:
∇



⍝ Spawns an instance of cowsAyPL.
⍝ →ARGUMENTS - a vector of character vectors of the arguments to pass to
⍝ cowsAyPL.
⍝ ←The resulting output.
∇OUTPUT←RUN_COWSAY ARGUMENTS; COWSAY_FD;COMMAND;CURRENT_TIME_MS
  COMMAND←ARGS∆APL_PATH," --script cowsay.apl -- ",↑{⍺," ",⍵}/ FIO∆ESCAPE_SHELL_ARGUMENT¨ ARGUMENTS
  ⍞←"Running '",COMMAND,"'...\n"

  CURRENT_TIME_MS←FIO∆GET_TIME_OF_DAY 1000

  COWSAY_FD←FIO∆POPEN_READ COMMAND
  →(0≢COWSAY_FD) ⍴ LSUCCESS
    PANIC "failed to launch cowsAyPL"
  LSUCCESS:
  OUTPUT←FIO∆READ_ENTIRE_FD COWSAY_FD
  ⊣ FIO∆PCLOSE COWSAY_FD

  ⍞←"cowsAyPL took " ◊ ⍞←1000÷⍨CURRENT_TIME_MS-⍨ FIO∆GET_TIME_OF_DAY 1000 ◊ ⍞← " seconds\n"
∇

⍝ We can only send the text to cowsAyPL via command-line arguments with popen().
⍝ This function does the preprocessing to the text of the source file so that it
⍝ can be passed as an argument.
⍝ →⍵ - the text as a byte vector.
PREPROCESS_INPUT←{,/ ("\n" " ") FIO∆CVECTOR_REPLACE FIO∆BYTES_TO_UTF8 ⍵}



⍝ Opens, truncates, and writes data to a file.
⍝ →FILE_PATH - the file.
⍝ →BYTE_VECTOR - the data.
∇BYTE_VECTOR WRITE_FILE FILE_PATH; FILE_DESCRIPTOR
  ⍞←"Writing to '",FILE_PATH,"'...\n"

  FILE_DESCRIPTOR←"w" FIO∆FOPEN FILE_PATH
  →(0<FILE_DESCRIPTOR) ⍴ LSUCCESS
    PANIC "failed to open file '",FILE_PATH,"' for writing"
  LSUCCESS:
  ⊣ BYTE_VECTOR FIO∆FWRITE FILE_DESCRIPTOR

  ⊣ FIO∆FCLOSE FILE_DESCRIPTOR
∇

⍝ Performs an individual recording of a file.
⍝ →FILE_PATHS - a 2-element nested vector of: 1 - the source file path, 2 - the
⍝ output destination file path.
⍝ →ARGUMENTS - a nested vector of additional arguments to pass to cowsAyPL.
∇ARGUMENTS RUN_RECORD FILE_PATHS; SOURCE_FILE;RECORDING_FILE;SOURCE_FILE_CONTENTS
  SOURCE_FILE←↑FILE_PATHS[1]
  OUTPUT_FILE←↑FILE_PATHS[2]
  ⍞←"Recording '",SOURCE_FILE,"' -> '",OUTPUT_FILE,"'...\n"

  SOURCE_FILE_CONTENTS←FIO∆READ_ENTIRE_FILE SOURCE_FILE
  →(¯2≢SOURCE_FILE_CONTENTS) ⍴ LREAD_SUCCESS
    PANIC "unable to read file '",SOURCE_FILE,"'"
  LREAD_SUCCESS:
  OUTPUT_FILE WRITE_FILE⍨ RUN_COWSAY ARGUMENTS , PREPROCESS_INPUT SOURCE_FILE_CONTENTS
∇

⍝ Performs the "record" action of this testing script, running cowsAyPL and
⍝ recording the results.
⍝ →FILENAME - the file in the sources directory to record.
∇RECORD FILENAME; SOURCE_FILE;OUTPUT_FILE_BASE
  SOURCE_FILE←ARGS∆SOURCES_FOLDER FIO∆JOIN_PATHS FILENAME
  OUTPUT_FILE_BASE←ARGS∆OUTPUTS_FOLDER FIO∆JOIN_PATHS FILENAME

  ⍬ RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected")
  "+W" "10" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_W_20")
  "+W" "30" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_W_40")
  "+n" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_n")

  "+e" "pp" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_e_pp")
  "+e" "pp" "+W" "10" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_e_pp_W_20")
  "+e" "pp" "+W" "20" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_e_pp_W_40")
  "+e" "pp" "+n" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_e_pp_n")
  "+e" "!q" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_e_!q")
  "+e" "!q" "+W" "10" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_e_!q_W_20")
  "+e" "!q" "+W" "20" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_e_!q_W_40")
  "+e" "!q" "+n" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_e_!q_n")
  "+e" "o" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_e_o")
  "+e" "ooo" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_e_ooo")

  "+T" "__" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_T___")
  "+T" "__" "+W" "10" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_T____W_20")
  "+T" "__" "+W" "20" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_T____W_40")
  "+T" "__" "+n" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_T____n")
  "+T" " 0" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_T_ 0")
  "+T" " 0" "+W" "10" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_T_ 0_W_20")
  "+T" " 0" "+W" "20" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_T_ 0_W_40")
  "+T" " 0" "+n" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_T_ 0_n")
  "+T" "x" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_T_x")
  "+T" "xxx" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_T_xxx")

  "+b" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_b")
  "+b" "+W" "10" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_b_W_20")
  "+b" "+W" "30" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_b_W_40")
  "+b" "+n" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_b_n")

  "+d" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_d")
  "+d" "+W" "10" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_d_W_20")
  "+d" "+W" "30" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_d_W_40")
  "+d" "+n" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_d_n")

  "+g" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_g")
  "+g" "+W" "10" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_g_W_20")
  "+g" "+W" "30" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_g_W_40")
  "+g" "+n" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_g_n")

  "+p" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_p")
  "+p" "+W" "10" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_p_W_20")
  "+p" "+W" "30" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_p_W_40")
  "+p" "+n" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_p_n")

  "+s" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_s")
  "+s" "+W" "10" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_s_W_20")
  "+s" "+W" "30" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_s_W_40")
  "+s" "+n" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_s_n")

  "+t" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_t")
  "+t" "+W" "10" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_t_W_20")
  "+t" "+W" "30" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_t_W_40")
  "+t" "+n" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_t_n")

  "+w" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_w")
  "+w" "+W" "10" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_w_W_20")
  "+w" "+W" "30" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_w_W_40")
  "+w" "+n" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_w_n")

  "+y" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_y")
  "+y" "+W" "10" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_y_W_20")
  "+y" "+W" "30" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_y_W_40")
  "+y" "+n" RUN_RECORD SOURCE_FILE (OUTPUT_FILE_BASE,".expected_y_n")

  ⍝ Output newline for a space between this and the next recording output.
  ⍞←"\n"
∇



⍝ Counters to show how many tests passed.
TEST_COUNT←0
PASSED_TEST_COUNT←0

⍝ The byte value of a newline.
NEWLINE_BYTE←⎕UCS "\n"

⍝ Performs an individual testing of a file.
⍝ →FILE_PATHS - a 2-element nested vector of: 1 - the source file path, 2 - the
⍝ output file path.
⍝ →ARGUMENTS - a nested vector of additional arguments to pass to cowsAyPL.
∇ARGUMENTS RUN_TEST FILE_PATHS; SOURCE_FILE;OUTPUT_FILE;EXPECTED_RESULT_LINES;ACTUAL_RESULT_LINES;EXPECTED_RESULT_LINE;ACTUAL_RESULT_LINE;LINE_NUMBER
  TEST_COUNT←1+TEST_COUNT

  SOURCE_FILE←↑FILE_PATHS[1]
  OUTPUT_FILE←↑FILE_PATHS[2]
  ⍞←"Testing '",SOURCE_FILE,"' -> '",OUTPUT_FILE,"'...\n"

  ⍝ Reads in what we expect as nested lines.
  EXPECTED_RESULT_LINES←FIO∆READ_ENTIRE_FILE OUTPUT_FILE
  →(¯2≢EXPECTED_RESULT_LINES) ⍴ LOUTPUT_READ_SUCCESS
    PANIC "unable to read file '",OUTPUT_FILE,"'"
  LOUTPUT_READ_SUCCESS:
  EXPECTED_RESULT_LINES←NEWLINE_BYTE FIO∆SPLIT EXPECTED_RESULT_LINES

  ⍝ Reads in what we got as nested lines.
  ACTUAL_RESULT_LINES←FIO∆READ_ENTIRE_FILE SOURCE_FILE
  →(¯2≢ACTUAL_RESULT_LINES) ⍴ LSOURCE_READ_SUCCESS
    PANIC "unable to read file '",SOURCE_FILE,"'"
  LSOURCE_READ_SUCCESS:
  ACTUAL_RESULT_LINES←NEWLINE_BYTE FIO∆SPLIT RUN_COWSAY ARGUMENTS , PREPROCESS_INPUT ACTUAL_RESULT_LINES

  ⍝ Check if line counts differ.
  →((≢EXPECTED_RESULT_LINES)≡≢ACTUAL_RESULT_LINES) ⍴ LSAME_LINE_COUNT
    ERROR "line count of output from cowsAyPL differs in line count of expected results"
    ERROR "Got:      ",(⍕≢ACTUAL_RESULT_LINES)," lines"
    ERROR "Expected: ",(⍕≢EXPECTED_RESULT_LINES)," lines"
    ERROR "Test failed"
    →LFAILED
  LSAME_LINE_COUNT:

  LINE_NUMBER←1
  ⍝ Compare line-by-line.
  LCHECK_LOOP:
    →(LINE_NUMBER>≢EXPECTED_RESULT_LINES) ⍴ LCHECK_LOOP_END

    EXPECTED_RESULT_LINE←↑EXPECTED_RESULT_LINES[LINE_NUMBER]
    ACTUAL_RESULT_LINE←↑ACTUAL_RESULT_LINES[LINE_NUMBER]

    →(EXPECTED_RESULT_LINE≡ACTUAL_RESULT_LINE) ⍴ LEQUAL
      ERROR "Contents of cowsAyPL output differs from expected results on line ",⍕LINE_NUMBER
      ERROR "Got:      '",(FIO∆BYTES_TO_UTF8 ACTUAL_RESULT_LINE),"'"
      ERROR "Expected: '",(FIO∆BYTES_TO_UTF8 EXPECTED_RESULT_LINE),"'"
      ERROR "Test failed"
      →LFAILED
    LEQUAL:

    LINE_NUMBER←1+LINE_NUMBER
    →LCHECK_LOOP
  LCHECK_LOOP_END:

  ⍞←"Test passed\n"
  PASSED_TEST_COUNT←1+PASSED_TEST_COUNT

LFAILED:
  ⍝ Output newline for a space between this and the next test output.
  ⍞←"\n"
∇

⍝ Performs the "test" action of this testing script, running cowsAyPL and
⍝ comparing the results to what was previously recorded.
⍝ →FILENAME - the file in the sources directory to test.
∇TEST FILENAME; SOURCE_FILE;OUTPUT_FILE_BASE
  SOURCE_FILE←ARGS∆SOURCES_FOLDER FIO∆JOIN_PATHS FILENAME
  OUTPUT_FILE_BASE←ARGS∆OUTPUTS_FOLDER FIO∆JOIN_PATHS FILENAME

  ⍬ RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected")
  "+W" "10" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_W_20")
  "+W" "30" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_W_40")
  "+n" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_n")

  "+e" "pp" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_e_pp")
  "+e" "pp" "+W" "10" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_e_pp_W_20")
  "+e" "pp" "+W" "20" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_e_pp_W_40")
  "+e" "pp" "+n" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_e_pp_n")
  "+e" "!q" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_e_!q")
  "+e" "!q" "+W" "10" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_e_!q_W_20")
  "+e" "!q" "+W" "20" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_e_!q_W_40")
  "+e" "!q" "+n" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_e_!q_n")
  "+e" "o" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_e_o")
  "+e" "ooo" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_e_ooo")

  "+T" "__" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_T___")
  "+T" "__" "+W" "10" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_T____W_20")
  "+T" "__" "+W" "20" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_T____W_40")
  "+T" "__" "+n" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_T____n")
  "+T" " 0" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_T_ 0")
  "+T" " 0" "+W" "10" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_T_ 0_W_20")
  "+T" " 0" "+W" "20" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_T_ 0_W_40")
  "+T" " 0" "+n" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_T_ 0_n")
  "+T" "x" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_T_x")
  "+T" "xxx" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_T_xxx")

  "+b" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_b")
  "+b" "+W" "10" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_b_W_20")
  "+b" "+W" "30" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_b_W_40")
  "+b" "+n" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_b_n")

  "+d" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_d")
  "+d" "+W" "10" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_d_W_20")
  "+d" "+W" "30" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_d_W_40")
  "+d" "+n" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_d_n")

  "+g" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_g")
  "+g" "+W" "10" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_g_W_20")
  "+g" "+W" "30" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_g_W_40")
  "+g" "+n" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_g_n")

  "+p" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_p")
  "+p" "+W" "10" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_p_W_20")
  "+p" "+W" "30" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_p_W_40")
  "+p" "+n" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_p_n")

  "+s" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_s")
  "+s" "+W" "10" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_s_W_20")
  "+s" "+W" "30" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_s_W_40")
  "+s" "+n" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_s_n")

  "+t" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_t")
  "+t" "+W" "10" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_t_W_20")
  "+t" "+W" "30" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_t_W_40")
  "+t" "+n" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_t_n")

  "+w" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_w")
  "+w" "+W" "10" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_w_W_20")
  "+w" "+W" "30" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_w_W_40")
  "+w" "+n" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_w_n")

  "+y" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_y")
  "+y" "+W" "10" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_y_W_20")
  "+y" "+W" "30" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_y_W_40")
  "+y" "+n" RUN_TEST SOURCE_FILE (OUTPUT_FILE_BASE,".expected_y_n")

  ⍝ Output newline for a space between this and the next recording output.
  ⍞←"\n"
∇



∇MAIN
  ARGS∆PARSE_ARGS ⎕ARG

  →({ARGS∆ACTION≡⍵}¨"record" "test") / LRECORD LTEST
    PANIC "MAIN: unreachable"
  LRECORD:
    ⊣ FIO∆MKDIRS ARGS∆OUTPUTS_FOLDER

    RECORD¨ARGS∆SOURCES_FILENAMES
    ⍞←"Recording complete\n"
    →LSWITCH_END
  LTEST:
    →(FIO∆IS_DIRECTORY ARGS∆OUTPUTS_FOLDER) ⍴ LOUTPUTS_DIRECTORY_EXISTS
      PANIC "outputs folder '",ARGS∆OUTPUTS_FOLDER,"' does not exist"
    LOUTPUTS_DIRECTORY_EXISTS:

    TEST¨ARGS∆SOURCES_FILENAMES
    ⍞←PASSED_TEST_COUNT ◊ ⍞←"/" ◊ ⍞←TEST_COUNT ◊ ⍞←" tests passed - "
    →(PASSED_TEST_COUNT≡TEST_COUNT) ⍴ LALL_TESTS_PASSED
      ⍞←"FAIL\n" ◊ →LTESTS_FAILED
    LALL_TESTS_PASSED: ⍞←"OK\n"
    LTESTS_FAILED:
    →LSWITCH_END
  LSWITCH_END:
∇
MAIN



)OFF