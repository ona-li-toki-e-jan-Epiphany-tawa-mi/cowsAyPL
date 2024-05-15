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
|  pulling from STDIN when text arguments are specified, and p |
| roduces ASCII art of a cow saying that text within a text bu |
| bble.                                                        |
|                                                              |
| The look of the cow and the width of the text bubble can be  |
| controlled via options supplied to the program.              |
|                                                              |
| Use the '+h' option for more information.                    |
|                                                              |
| Note: the ability to list and use cowfiles is not implemente |
| d.                                                           |
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
| You will need GnuAPL (https://www.gnu.org/software/apl) inst |
| alled on your system.                                        |
|                                                              |
| Execute either of the following command(s) in the project di |
| rectory to get started:                                      |
|                                                              |
| ./cowsay.apl [options..] [TEXT...]                           |
| apl --script cowsay.apl -- [options...] [TEXT...]            |
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

```
/¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\
| If you would like to install it, you can do so with the fowl |
| lowing make command:                                         |
|                                                              |
| make install                                                 |
|                                                              |
| Note that the script expects GnuAPL to be in /usr/bin/apl. M |
| odify the shebang before-hand if your setup differs.         |
|                                                              |
| You can also install it with Nix from the NUR (https://githu |
| b.com/nix-community/NUR) with the following attribute:       |
|                                                              |
| nur.repos.ona-li-toki-e-jan-Epiphany-tawa-mi.cowsaypl        |
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
| Copyright (c) 2022-2024 ona-li-toki-e-jan-Epiphany-tawa-mi                     |
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
