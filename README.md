```
/¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\
| Cowsay in GnuAPL |
\__________________/
                \
                 \
                   ^__^
                   (oo)\_______
                   (__)\       )\/\
                       ||----w |
                       ||     ||
```

# cowsAyPL

```
/¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\
| The classic cowsay, written in the eldritch abomination that |
|  is APL (<3 btw.)                                            |
|                                                              |
| CowsAyPL can either accept text supplied as arguments, or by |
|  pulling from STDIN when text arguments are specified, andpr |
| oduces ASCII art of a cow saying that text within a text bub |
| ble.                                                         |
|                                                              |
| The look of the cow and the width of the text bubble can be  |
| controlled via options supplied to the program.              |
|                                                              |
| Use the '+h' option for more information.                    |
|                                                              |
| Note: the ability to list and use cowfiles is not implemente |
| d.                                                           |
|                                                              |
| Note: this currently does not support outputting Unicode cha |
| racters, might fix later.                                    |
|                                                              |
\______________________________________________________________/
                                                            \
                                                             \
                                                               ^__^
                                                               (oo)\_______
                                                               (__)\       )\/\
                                                                   ||----w |
                                                                   ||     ||
```
## How to Run

```
/¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\
| You will need GnuAPL installed on your system. You can find  |
| information about GnuAPL at: <https://www.gnu.org/software/a |
| pl>                                                          |
|                                                              |
| If compiling GnuAPL from source, make sure to compile in reg |
| ular expression support with libpcre2.                       |
|                                                              |
| Execute either of the following command(s) in the project di |
| rectory to get started:                                      |
|                                                              |
| ./cowsay.apl [ARGS..]                                        |
| apl --script cowsay.apl -- [ARGS..]                          |
|                                                              |
\______________________________________________________________/
                                                            \
                                                             \
                                                               ^__^
                                                               (XX)\_______
                                                               (__)\       )\/\
                                                                U  ||----w |
                                                                   ||     ||
```

## Installation

```text
/¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\
| You can run cowsay.apl as a standalone script. But, if you w |
| ould like to run it on the command line from anywhere by typ |
| ing "cowsaypl", run the following commands on the script fil |
| e:                                                           |
|                                                              |
| sudo cp cowsay.apl /usr/local/bin/cowsaypl                   |
| sudo chown root:root /usr/local/bin/cowsaypl                 |
| sudo chmod u=w,a+rx /usr/local/bin/cowsaypl                  |
|                                                              |
\______________________________________________________________/
                                                            \
                                                             \
                                                               ^__^
                                                               (..)\_______
                                                               (__)\       )\/\
                                                                   ||----w |
                                                                   ||     ||
```

## Examples

```console
$ ./cowsay.apl +b The only thing separating the gonks from the chooms is how chromed\'ya are
/¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\
| The only thing separating the gonks from |
|  the chooms is how chromed'ya are        |
\__________________________________________/
                                        \
                                         \
                                           ^__^
                                           (==)\_______
                                           (__)\       )\/\
                                               ||----w |
                                               ||     ||
```

```console
$ apl --script cowsay.apl -- +e "()" +T \(\) +W 19 "We are become one. Flesh in the flesh."
/¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\
| We are become one.  |
| Flesh in the flesh. |
\_____________________/
                   \
                    \
                      ^__^
                      (())\_______
                      (__)\       )\/\
                       () ||----w |
                          ||     ||
```

```console
$ cat LICENSE | ./cowsay.apl +n +p
/¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\
| MIT License                                                                    |
|                                                                                |
| Copyright (c) 2022-2023 ona-li-toki-e-jan-Epiphany-tawa-mi                     |
|                                                                                |
| Permission is hereby granted, free of charge, to any person obtaining a copy   |
| of this software and associated documentation files (the "Software"), to deal  |
| in the Software without restriction, including without limitation the rights   |
| to use, copy, modify, merge, publish, distribute, sublicense, and/or sell      |
| copies of the Software, and to permit persons to whom the Software is          |
| furnished to do so, subject to the following conditions:                       |
|                                                                                |
| The above copyright notice and this permission notice shall be included in all |
| copies or substantial portions of the Software.                                |
|                                                                                |
| THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR     |
| IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,       |
| FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE    |
| AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER         |
| LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,  |
| OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE  |
| SOFTWARE.                                                                      |
|                                                                                |
\________________________________________________________________________________/
                                                                              \
                                                                               \
                                                                                 ^__^
                                                                                 (@@)\_______
                                                                                 (__)\       )\/\
                                                                                     ||----w |
                                                                                     ||     ||
```
