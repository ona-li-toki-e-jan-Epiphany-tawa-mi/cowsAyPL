⍝!/usr/local/bin/apl --script

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

⍝ Logging module.

⊣ ⍎")COPY_ONCE fio.apl"



⍝ Displays an error message.
∇ERROR MESSAGE
  ⊣ FIO∆STDERR FIO∆FWRITE_CVECTOR⍨ "Error: ",MESSAGE,"\n"
∇

⍝ Displays an error message and exits.
∇PANIC MESSAGE
  ⊣ FIO∆STDERR FIO∆FWRITE_CVECTOR⍨ "Fatal: ",MESSAGE,"\n"
  ⍎")OFF"
∇
