pushtable

; 0020,FC,31CA,
; 0018,FC,31C9,
; 0010,FC,31C8,
; 0008,FC,31C7,
; 0000,FC,31C6,
; 01F8,FC,31C5,
; 01F0,FC,31C4,
; 01E8,FC,31C3,
; 01E0,FC,31C2,
; 01D8,FC,31C1

org $8C8103
%begin_title_list()
!x = $01C4
!y = $FC
%title_char_small(!x, !y, "R") : !x #= !x+8
%title_char_small(!x, !y, "O") : !x #= !x+8
%title_char_small(!x, !y, "M") : !x #= !x+8
%title_char_small(!x, !y, "H") : !x #= !x+8
%title_char_small(!x, !y, "A") : !x #= !x+8
%title_char_small(!x, !y, "C") : !x #= !x+8
%title_char_small(!x, !y, "K") : !x #= !x+8
%title_char_small(!x, !y, " ") : !x #= !x+8
%title_char_small(!x, !y, "B") : !x #= !x+8
%title_char_small(!x, !y, "Y") : !x #= !x+8
%title_char_small(!x, !y, " ") : !x #= !x+8
%title_char_small(!x, !y, "C") : !x #= !x+8
%title_char_small(!x, !y, "O") : !x #= !x+8
%title_char_small(!x, !y, "U") : !x #= !x+8
%title_char_small(!x, !y, "T") : !x #= !x+8

!x = $01A9
!y = $FC+20
%title_char_small(!x, !y, "S") : !x #= !x+8
%title_char_small(!x, !y, "U") : !x #= !x+8
%title_char_small(!x, !y, "P") : !x #= !x+8
%title_char_small(!x, !y, "E") : !x #= !x+8
%title_char_small(!x, !y, "R") : !x #= !x+8
%title_char_small(!x, !y, " ") : !x #= !x+4
%title_char_small(!x, !y, "M") : !x #= !x+8
%title_char_small(!x, !y, "E") : !x #= !x+8
%title_char_small(!x, !y, "T") : !x #= !x+7
%title_char_small(!x, !y, "R") : !x #= !x+8
%title_char_small(!x, !y, "O") : !x #= !x+5
%title_char_small(!x, !y, "I") : !x #= !x+6
%title_char_small(!x, !y, "D") : !x #= !x+8
%title_char_small(!x, !y, " ") : !x #= !x+8

!c = $3800
%title_char_special(!x, !y, title_copyright_symbol(!c)) : !x #= !x+8
%title_char_special(!x, !y, title_year_1994_a(!c))      : !x #= !x+8
%title_char_special(!x, !y, title_year_1994_b(!c))      : !x #= !x+8
%title_char_special(!x, !y, title_nintendo_1(!c))       : !x #= !x+8
%title_char_special(!x, !y, title_nintendo_2(!c))       : !x #= !x+8
%title_char_special(!x, !y, title_nintendo_3(!c))       : !x #= !x+8
%title_char_special(!x, !y, title_nintendo_4(!c))       : !x #= !x+8
%title_char_special(!x, !y, title_nintendo_5(!c))       : !x #= !x+8
%title_char_special(!x, !y, title_nintendo_6(!c))       : !x #= !x+8
%title_char_special(!x, !y, title_nintendo_7(!c))       : !x #= !x+8
%end_title_list()
warnpc $8C82AD

pulltable
; vim:ft=pic
