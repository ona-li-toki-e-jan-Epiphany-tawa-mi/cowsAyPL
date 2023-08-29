```text
/¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\               
| Cowsay in Dyalog APL. |               
\_______________________/               
                     \                  
                      \                 
                        ^__^            
                        (oo)\_______    
                        (__)\       )\/\
                            ||----w |   
                            ||     ||
```

# cowsAyPL

```plaintext
/¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\               
| The classic cowsay, written in the eldritch abomination that |               
|  is APL (<3 btw.)                                            |               
|                                                              |               
| Cowsay can either accept text supplied as arguments, or by p |               
| ulling from STDIN when text arguments are specified, and pro |               
| duces ASCII art of a cow saying that text within a text bubb |               
| le.                                                          |               
|                                                              |               
| The look of the cow and the width of the text bubble can be  |               
| controlled via options supplied to the program.              |               
|                                                              |               
| Use the '-h' option (or '--help') for more information.      |
|                                                              |
| Note: the ability to use cowfiles to customize what appears  |
| has not been implemented.                                    |               
\______________________________________________________________/               
                                                            \                  
                                                             \                 
                                                               ^__^            
                                                               (==)\_______    
                                                               (__)\       )\/\
                                                                   ||----w |
                                                                   ||     ||      
```
## How to Run

```plaintext
/¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\               
| You will need to have Dyalog APL version 18.2 or greater ins |               
| talled on your system, which you can download from Dyalog's  |               
| website (https://www.dyalog.com).                            |               
|                                                              |               
| Execute either of the following command(s) in the project di |               
| rectory to get started:                                      |               
|                                                              |               
| dyalogscript cowsay.apl -h                                   |               
| ./cowsay.apl -h                                              |               
\______________________________________________________________/               
                                                            \                  
                                                             \                 
                                                               ^__^            
                                                               (XX)\_______    
                                                               (__)\       )\/\
                                                                U  ||----w |   
                                                                   ||     ||
```

## Examples

```console
$ ./cowsay.apls -b The only thing separating the gonks from the chooms is how chromed\'ya are
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
$ dyalogscript cowsay.apls -e "()" -T \(\) -W 19 "We are become one. Flesh in the flesh."
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
$ cat LICENSE | ./cowsay.apls -n -p
/¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\               
| MIT License                                                                    |               
|                                                                                |               
| Copyright (c) 2022 ona-li-toki-e-jan-Epiphany-tawa-mi                          |               
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
\________________________________________________________________________________/               
                                                                              \                  
                                                                               \                 
                                                                                 ^__^            
                                                                                 (@@)\_______    
                                                                                 (__)\       )\/\
                                                                                     ||----w |   
                                                                                     ||     ||
```