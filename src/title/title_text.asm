macro title_large1(color)
{
  '1' = <color>+$0100 : '2' = <color>+$41A7 : '3' = <color>+$0101 : '4' = <color>+$0120
  '5' = <color>+$016B : '6' = <color>+$C176 : '7' = <color>+$F199 : '8' = <color>+$01DE
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
  '5' = <color>+$0111 : '6' = <color>+$C166 : '7' = <color>+$01BD : '8' = <color>+$81DE
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

macro title_char(x, y, ch)
  %title_large1($3200) : dw <x> : db <y>+$00 : dw "<ch>"
  %title_large2($3200) : dw <x> : db <y>+$08 : dw "<ch>"
endmacro

; vim:ft=pic
