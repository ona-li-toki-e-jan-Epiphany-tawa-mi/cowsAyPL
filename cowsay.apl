cow←'\' ' \' '   ^__^' '   (oo)\_______' '   (__)\       )\/\' '       ||----w |' '       ||     ||'
splitText←{⍵{⍺{↓⍵⍴⍺,' '\⍨(×/⍵)-⍴⍺}(⌈⍵÷⍨⍴⍺),⍵}⍺⌊⍴⍵}
textBubbleize←{⍵{⍵{(⊂'/¯','¯\',⍨⍵/'¯'),(⊂'\_','_/',⍨⍵/'_'),⍨⍺}⍴⊃⍺}{'| ',⍵,' |'}¨⍵}
cowsay←{↑cow,⍨textBubbleize⍺splitText⍵}