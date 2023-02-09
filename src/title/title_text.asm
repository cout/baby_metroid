macro title_large1(color)
{
  '1' = <color>+$0100 : '2' = <color>+$41A7 : '3' = <color>+$0101 : '4' = <color>+$0120
  '5' = <color>+$016B : '6' = <color>+$C176 : '7' = <color>+$F199 : '8' = <color>+$01F4
  '9' = <color>+$0166 : '0' = <color>+$018C : ' ' = <color>+$00F0 : '.' = <color>+$00F0
  'A' = <color>+$0167 : 'B' = <color>+$0168 : 'C' = <color>+$0169 : 'D' = <color>+$016A
  'E' = <color>+$016B : 'F' = <color>+$016C : 'G' = <color>+$016D : 'H' = <color>+$016E
  'I' = <color>+$016F : 'J' = <color>+$0187 : 'K' = <color>+$0188 : 'L' = <color>+$0189
  'M' = <color>+$018A : 'N' = <color>+$018B : 'O' = <color>+$018C : 'P' = <color>+$018D
  'Q' = <color>+$018E : 'R' = <color>+$018F : 'S' = <color>+$01A7 : 'T' = <color>+$01A8
  'U' = <color>+$01A9 : 'V' = <color>+$01AA : 'W' = <color>+$01AB : 'X' = <color>+$01AC
  'Y' = <color>+$01AD : 'Z' = <color>+$01AE
}
endmacro

macro title_large2(color)
{
  '1' = <color>+$0110 : '2' = <color>+$01BE : '3' = <color>+$0111 : '4' = <color>+$0130
  '5' = <color>+$0111 : '6' = <color>+$C166 : '7' = <color>+$01BD : '8' = <color>+$81F4
  '9' = <color>+$0176 : '0' = <color>+$019C : ' ' = <color>+$00F0 : '.' = <color>+$01F3
  'A' = <color>+$0177 : 'B' = <color>+$0178 : 'C' = <color>+$0179 : 'D' = <color>+$017A
  'E' = <color>+$017B : 'F' = <color>+$017C : 'G' = <color>+$017D : 'H' = <color>+$017E
  'I' = <color>+$017F : 'J' = <color>+$0197 : 'K' = <color>+$0198 : 'L' = <color>+$0199
  'M' = <color>+$019A : 'N' = <color>+$019B : 'O' = <color>+$019C : 'P' = <color>+$019D
  'Q' = <color>+$019E : 'R' = <color>+$019F : 'S' = <color>+$01B7 : 'T' = <color>+$01B8
  'U' = <color>+$01B9 : 'V' = <color>+$01BA : 'W' = <color>+$01BB : 'X' = <color>+$01BC
  'Y' = <color>+$01BD : 'Z' = <color>+$01BE
}
endmacro

macro title_small(color)
{
  '1' = <color>+$01F5 : '2' = <color>+$01F6 : '3' = <color>+$01F7 : '4' = <color>+$01F8
  '5' = <color>+$01F9 : '6' = <color>+$C1FA : '7' = <color>+$01FB : '8' = <color>+$81FC
  '9' = <color>+$01FD : '0' = <color>+$01F4 : ' ' = <color>+$00F0 : '.' = <color>+$01F3
  'A' = <color>+$01D0 : 'B' = <color>+$01D1 : 'C' = <color>+$01D2 : 'D' = <color>+$01D3
  'E' = <color>+$01D4 : 'F' = <color>+$01D5 : 'G' = <color>+$01D6 : 'H' = <color>+$01D7
  'I' = <color>+$01D8 : 'J' = <color>+$01D9 : 'K' = <color>+$01DA : 'L' = <color>+$01DB
  'M' = <color>+$01DC : 'N' = <color>+$01DD : 'O' = <color>+$01DE : 'P' = <color>+$01DF
  'Q' = <color>+$01E0 : 'R' = <color>+$01E1 : 'S' = <color>+$01E2 : 'T' = <color>+$01E3
  'U' = <color>+$01E4 : 'V' = <color>+$01E5 : 'W' = <color>+$01E6 : 'X' = <color>+$01E7
  'Y' = <color>+$01E8 : 'Z' = <color>+$01E9
}
endmacro

function title_registed_tm_symbol(color) = (color+$01C0)
function title_copyright_symbol(color) = (color+$01C1)
function title_year_1994_a(color) = (color+$01C2)
function title_year_1994_b(color) = (color+$01C3)
function title_nintendo_1(color) = (color+$01C4)
function title_nintendo_2(color) = (color+$01C5)
function title_nintendo_3(color) = (color+$01C6)
function title_nintendo_4(color) = (color+$01C7)
function title_nintendo_5(color) = (color+$01C8)
function title_nintendo_6(color) = (color+$01C9)
function title_nintendo_7(color) = (color+$01CA)

macro title_char(x, y, ch)
  if stringsequal("<ch>", "8")
    %title_large1($3200) : dw <x> : db <y>+$00 : dw "<ch>"
    %title_large2($3200) : dw <x> : db <y>+$07 : dw "<ch>"
  else
    %title_large1($3200) : dw <x> : db <y>+$00 : dw "<ch>"
    %title_large2($3200) : dw <x> : db <y>+$08 : dw "<ch>"
  endif
endmacro

macro title_char_special(x, y, ch)
  dw <x> : db <y>+$00 : dw <ch>
endmacro

macro title_char_small(x, y, ch)
  %title_small($3200) : dw <x> : db <y>+$00 : dw "<ch>"
endmacro

!title_list_counter = 0

macro begin_title_list()
  dw datasize(list_!{title_list_counter})/5
  list_!{title_list_counter}:
endmacro

macro end_title_list()
  end_list_!{title_list_counter}:
  !title_list_counter #= !title_list_counter+1
endmacro

; vim:ft=pic
