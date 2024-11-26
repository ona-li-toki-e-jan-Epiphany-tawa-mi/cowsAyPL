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
| roduces text art of a cow saying that text within a text bub |
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
| ./cowsay.apl -- +h                                           |
| apl --script cowsay.apl -- +h                                |
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

## How to test

```
/¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\
| Get the dependencies as specified in the `How to run` sectio |
| n.                                                           |
|                                                              |
| Then, run one of the following commands:                     |
|                                                              |
| ./test.apl -- test tests/sources tests/outputs               |
| apl --script test.apl -- test tests/sources tests/outputs    |
|                                                              |
| If breaking changes are desired, regenerate the test cases w |
| ith one of the following commands:                           |
|                                                              |
| ./test.apl -- record tests/sources tests/outputs             |
| apl --script test.apl -- record tests/sources tests/outputs  |
\______________________________________________________________/
                                                            \
                                                             \
                                                               ^__^
                                                               (OO)\_______
                                                               (__)\       )\/\
                                                                   ||----w |
                                                                   ||     ||
```

## Installation

```
/¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\
| You can install it with Nix from the NUR (https://github.com |
| /nix-community/NUR) with the following attribute:            |
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
$ ./cowsay.apl -- +b The only thing separating the gonks from the chooms is how chromed\'ya are
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
$ cat tests/sources/toki-pona-haiku.txt | apl --script cowsay.apl -- +np
/¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\
| kon li lon.        |
| li namako li suwi. |
| li kama seli.      |
|                    |
\____________________/
                  \
                   \
                     ^__^
                     (@@)\_______
                     (__)\       )\/\
                         ||----w |
                         ||     ||
```
