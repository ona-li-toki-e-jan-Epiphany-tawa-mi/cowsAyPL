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

⍝ cowsAyPL integration testing script.

⊣ ⍎")COPY_ONCE fio.apl"

⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝
⍝ Configuration                                                                ⍝
⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝

⍝ Type: string
source_folder←"tests/sources"
⍝ Type: string
output_folder←"tests/outputs"

⍝ List of tests. Each test is a list of arguments to supply with each file to
⍝ run cowsAyPL with.
⍝ Type: vector<vector<string>>
test_cases←⊂⍬
test_cases←test_cases,⊂"+W" "10"
test_cases←test_cases,⊂"+W" "30"
test_cases←test_cases,⊂⊂"+n"
test_cases←test_cases,⊂"+e" "pp"
test_cases←test_cases,⊂"+e" "pp" "+W" "10"
test_cases←test_cases,⊂"+e" "pp" "+W" "20"
test_cases←test_cases,⊂"+e" "pp" "+n"
test_cases←test_cases,⊂"+e" "!q"
test_cases←test_cases,⊂"+e" "!q" "+W" "10"
test_cases←test_cases,⊂"+e" "!q" "+W" "20"
test_cases←test_cases,⊂"+e" "!q" "+n"
test_cases←test_cases,⊂"+e" "o"
test_cases←test_cases,⊂"+e" "ooo"
test_cases←test_cases,⊂"+T" "__"
test_cases←test_cases,⊂"+T" "__" "+W" "10"
test_cases←test_cases,⊂"+T" "__" "+W" "20"
test_cases←test_cases,⊂"+T" "__" "+n"
test_cases←test_cases,⊂"+T" " 0"
test_cases←test_cases,⊂"+T" " 0" "+W" "10"
test_cases←test_cases,⊂"+T" " 0" "+W" "20"
test_cases←test_cases,⊂"+T" " 0" "+n"
test_cases←test_cases,⊂"+T" "x"
test_cases←test_cases,⊂"+T" "xxx"
test_cases←test_cases,⊂⊂"+b"
test_cases←test_cases,⊂"+b" "+W" "10"
test_cases←test_cases,⊂"+b" "+W" "30"
test_cases←test_cases,⊂"+b" "+n"
test_cases←test_cases,⊂⊂"+d"
test_cases←test_cases,⊂"+d" "+W" "10"
test_cases←test_cases,⊂"+d" "+W" "30"
test_cases←test_cases,⊂"+d" "+n"
test_cases←test_cases,⊂⊂"+g"
test_cases←test_cases,⊂"+g" "+W" "10"
test_cases←test_cases,⊂"+g" "+W" "30"
test_cases←test_cases,⊂"+g" "+n"
test_cases←test_cases,⊂⊂"+p"
test_cases←test_cases,⊂"+p" "+W" "10"
test_cases←test_cases,⊂"+p" "+W" "30"
test_cases←test_cases,⊂"+p" "+n"
test_cases←test_cases,⊂⊂"+s"
test_cases←test_cases,⊂"+s" "+W" "10"
test_cases←test_cases,⊂"+s" "+W" "30"
test_cases←test_cases,⊂"+s" "+n"
test_cases←test_cases,⊂⊂"+t"
test_cases←test_cases,⊂"+t" "+W" "10"
test_cases←test_cases,⊂"+t" "+W" "30"
test_cases←test_cases,⊂"+t" "+n"
test_cases←test_cases,⊂⊂"+w"
test_cases←test_cases,⊂"+w" "+W" "10"
test_cases←test_cases,⊂"+w" "+W" "30"
test_cases←test_cases,⊂"+w" "+n"
test_cases←test_cases,⊂⊂"+y"
test_cases←test_cases,⊂"+y" "+W" "10"
test_cases←test_cases,⊂"+y" "+W" "30"
test_cases←test_cases,⊂"+y" "+n"

⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝
⍝ Argument Parsing                                                             ⍝
⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝

⍝ The path to the apl interpreter used to call this program.
⍝ Type: string
ARGS∆apl_path←⍬
⍝ The name of this file/program.
⍝ Type: string
ARGS∆program_name←⍬
⍝ Type: "test" | "record"
⍝ The action/subcommand to preform.
ARGS∆action←"test"

⍝ Displays help information.
∇ARGS∆DISPLAY_HELP
  ⍞←"Usages:\n"
  ⍞←"  ",ARGS∆program_name," -- [record]\n"
  ⍞←"  ",ARGS∆apl_path," --script ",ARGS∆program_name," -- [record]\n"
  ⍞←"\n"
  ⍞←"Runs integration testing for cowsAyPL.\n"
  ⍞←"\n"
  ⍞←"If 'record' is specified, this will instead regnerate test cases.\n"
∇

⍝ Parses command line arguments and updates ARGS∆* accordingly.
⍝ →ARGUMENTS: vector<string>
∇ARGS∆PARSE_ARGS arguments
  ⍝ ARGUMENTS looks like "<apl path> --script <script> -- [user arguments...]"

  ARGS∆apl_path←↑arguments
  ARGS∆program_name←↑arguments[3]

  ⍝ 4 for APL and it's arguments.
  →(4≤≢arguments) ⍴ lsufficient_arguments
    ⊣ FIO∆STDERR FIO∆PRINT_FD "ERROR: insufficient arguments\n"
    ARGS∆DISPLAY_HELP
    ⍎")OFF 1"
  lsufficient_arguments:

  →(~arguments∊⍨⊂"record") ⍴ ltest
    ARGS∆action←"record"
  ltest:
∇

⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝
⍝ Utilities                                                                    ⍝
⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝

⍝ Takes a file name and arguments used in the cowsAyPL command and generates a
⍝ path to a corresponding and unique file in the output directory.
⍝ →file_name: string
⍝ →arguments: vector<string>
⍝ ←path: string
∇path←arguments OUTPUT_FILE file_name
  path←output_folder FIO∆JOIN_PATH file_name
  →(0≡≢arguments) ⍴ lhas_no_arguments
    path←path,".",↑{⍺,"_",⍵}/arguments
  lhas_no_arguments:
  path←path,".out"
∇

⍝ Runs cowsAyPL with the given arguments.
⍝ →arguments: vector<string>.
⍝ ←output: string - stdout.
∇output←RUN_COWSAY arguments; cowsay_fd;command
  command←arguments,⍨ARGS∆apl_path "--script" "cowsay.apl" "--"
  ⊣ FIO∆PRINTF "Running '%s'...\n" (↑FIO∆JOIN_SHELL_ARGUMENTS/ command)

  cowsay_fd←FIO∆POPEN_READ command
  →(↑cowsay_fd) ⍴ lsuccess
    ⊣ FIO∆STDERR FIO∆PRINTF_FD "ERROR: failed to launch cowsAyPL: %s\n" (↑1↓cowsay_fd)
    ⍎")OFF 1"
  lsuccess:
  cowsay_fd←↑1↓cowsay_fd
  output←↑1↓FIO∆READ_ENTIRE_FD cowsay_fd
  ⊣ FIO∆PCLOSE cowsay_fd
∇

⍝ We can only send the text to cowsAyPL via command-line arguments with
⍝ FIO∆POPEN_READ. This function does the preprocessing to the text of the source
⍝ file so that it can be passed as an argument.
⍝ →input: vector<byte> - text.
∇output←PREPROCESS_INPUT input
  output←FIO∆BYTES_TO_UTF8 input
  ⍝ Replace newlines with spaces.
  output←(output,⍨" ")[1+(⍳⍨output)×~output∊"\n"]
∇

⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝
⍝ Recording                                                                    ⍝
⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝

⍝ Records the output of passing a file to cowsAyPL with all configured test
⍝ cases.
⍝ →source_file - the file in the sources directory to record.
∇RECORD_FILE source_file
  test_cases RECORD_FILE_WITH_CASE¨ (≢test_cases)⍴⊂source_file
  ⍝ Output newline for a space between this and the next output.
  ⍞←"\n"
∇

⍝ Records the output of passing a file to cowsAyPL with an individual test case
⍝ →source_file: string - the name of the file in the source folder to pass.
⍝ →test_case: vector<string> - a vector of additional arguments to pass.
∇test_case RECORD_FILE_WITH_CASE source_file; output_file;source_file_contents
  output_file←test_case OUTPUT_FILE source_file
  source_file←source_folder FIO∆JOIN_PATH source_file
  ⊣ FIO∆PRINTF "Recording '%s' -> '%s'...\n" source_file output_file

  source_file_contents←FIO∆READ_ENTIRE_FILE source_file
  →(↑source_file_contents) ⍴ lread_success
    ⊣ FIO∆STDERR FIO∆PRINTF_FD "ERROR: unable to read file '%s': %s" source_file (↑1↓source_file_contents)
    ⍎")OFF 1"
  lread_success:
  output_file WRITE_FILE⍨ RUN_COWSAY test_case ,⊂ PREPROCESS_INPUT ↑1↓source_file_contents
∇

⍝ Opens, truncates, and writes data to a file.
⍝ →path: string.
⍝ →data: vector<byte>.
∇data WRITE_FILE path; fd
  ⊣ FIO∆PRINTF "Writing to '%s'...\n" path

  fd←"w" FIO∆OPEN_FILE path
  →(↑fd) ⍴ lsuccess
    ⊣ FIO∆STDERR FIO∆PRINTF_FD "ERROR: failed to open file '%s' for writing: %s" path (↑1↓fd)
    ⍎")OFF 1"
  lsuccess:
  fd←↑1↓fd

  ⊣ fd FIO∆WRITE_FD data

  ⊣ FIO∆CLOSE_FD fd
∇

⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝
⍝ Testing                                                                      ⍝
⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝

⍝ Counters to show how many tests passed.
⍝ Type: scalar whole integer.
test_count←0
⍝ Type: scalar whole integer.
passed_test_count←0

⍝ Tests a file against all configured test cases.
⍝ →source_file: string - the name of the file in the source folder to test.
∇TEST_FILE source_file
  test_cases TEST_FILE_WITH_CASE¨ (≢test_cases)⍴⊂source_file
  ⍝ Output newline for a space between this and the next output.
  ⍞←"\n"
∇

⍝ Tests a file against an individual test case.
⍝ →source_file: string - the name of the file in the source folder to test.
⍝ →test_case: vector<string> - a vector of additional arguments to pass to
⍝ cowsAyPL.
∇test_case TEST_FILE_WITH_CASE source_file; output_file;expected_result;actual_result
  test_count←1+test_count

  output_file←test_case OUTPUT_FILE source_file
  source_file←source_folder FIO∆JOIN_PATH source_file
  ⊣ FIO∆PRINTF "Testing '%s' -> '%s'...\n" source_file output_file

  ⍝ Reads in what we expect as output.
  expected_result←FIO∆READ_ENTIRE_FILE output_file
  →(↑expected_result) ⍴ loutput_read_success
    ⊣ FIO∆STDERR FIO∆PRINTF_FD "ERROR: unable to read file '%s': %s\n" output_file (↑1↓expected_result)
    ⍎")OFF 1"
  loutput_read_success:
  expected_result←↑1↓expected_result

  ⍝ Reads in what we actually got.
  actual_result←FIO∆READ_ENTIRE_FILE source_file
  →(↑actual_result) ⍴ lsource_read_success
    ⊣ FIO∆STDERR FIO∆PRINTF_FD "ERROR: unable to read file '%s'\n" source_file
    ⍎")OFF 1"
  lsource_read_success:

  ⍝ Check if outputs differ.
  →(expected_result≡actual_result) ⍴ lsame
    ⊣ FIO∆STDERR FIO∆PRINT_FD "ERROR: output of cowsAyPL differs from expected output\n"
    ⊣ FIO∆STDERR FIO∆PRINT_FD "Expected:\n"
    ⊣ FIO∆STDERR FIO∆WRITE_FD expected_result
    ⊣ FIO∆STDERR FIO∆PRINT_FD "Got:\n"
    ⊣ FIO∆STDERR FIO∆WRITE_FD actual_result
    ⊣ FIO∆STDERR FIO∆PRINT_FD "Test failed\n"
    →lfailed
  lsame:

  ⍞←"Test passed\n"
  passed_test_count←1+passed_test_count
lfailed:
  ⍝ Output newline for a space between this and the next output.
  ⍞←"\n"
∇

⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝
⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝
⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝

∇MAIN; source_files
  ARGS∆PARSE_ARGS ⎕ARG

  ⍝ Reads list of source files.
  source_files←FIO∆LIST_DIRECTORY source_folder
  →(↑source_files) ⍴ lsources_folder_exists
    ⊣ FIO∆STDERR FIO∆PRINTF_FD "ERROR: sources folder '%s' does not exist\n" source_folder
    ⍎")OFF 1"
  lsources_folder_exists:
  source_files←↑1↓source_files

  →((⊂ARGS∆action)⍷"record" "test") / lrecord ltest
    ⊣ FIO∆STDERR FIO∆PRINT_FD "ERROR: MAIN: unreachable\n"
    ⍎")OFF 1"
  lrecord:
    RECORD_FILE¨source_files
    ⍞←"Recording complete\n"
    →lswitch_end
  ltest:
    TEST_FILE¨source_files
    ⍞←passed_test_count ◊ ⍞←"/" ◊ ⍞←test_count ◊ ⍞←" tests passed - "
    →(passed_test_count≡test_count) ⍴ lall_tests_passed
      ⍞←"FAIL\n" ◊ →ltests_failed
    lall_tests_passed: ⍞←"OK\n"
    ltests_failed:
    →lswitch_end
  lswitch_end:
∇
MAIN

)OFF
