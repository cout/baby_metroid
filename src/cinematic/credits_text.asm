credits_color_white  = $0000
credits_color_yellow = $0400
credits_color_cyan   = $0800
credits_color_green  = $0C00
credits_color_pink   = $1000
credits_color_blue   = $1400
credits_color_orange = $1800
credits_color_purple = $1C00

macro credits_small_font(color)
{
  'A' = <color>+$00 : 'B' = <color>+$01 : 'C' = <color>+$02 : 'D' = <color>+$03
  'E' = <color>+$04 : 'F' = <color>+$05 : 'G' = <color>+$06 : 'H' = <color>+$07
  'I' = <color>+$08 : 'J' = <color>+$09 : 'K' = <color>+$0A : 'L' = <color>+$0B
  'M' = <color>+$0C : 'N' = <color>+$0D : 'O' = <color>+$0E : 'P' = <color>+$0F
  'Q' = <color>+$10 : 'R' = <color>+$11 : 'S' = <color>+$12 : 'T' = <color>+$13
  'U' = <color>+$14 : 'V' = <color>+$15 : 'W' = <color>+$16 : 'X' = <color>+$17
  'Y' = <color>+$18 : 'Z' = <color>+$19 : '.' = <color>+$1A : ',' = <color>+$1B
  '*' = <color>+$1C : ''' = <color>+$1D : ':' = <color>+$1E : '!' = <color>+$1F
  '"' = <color>+$4A : ' ' = <color>+$7F
}
endmacro

macro credits_large1_font(color)
{
  'A' = <color>+$20 : 'B' = <color>+$21 : 'C' = <color>+$22 : 'D' = <color>+$23
  'E' = <color>+$24 : 'F' = <color>+$25 : 'G' = <color>+$26 : 'H' = <color>+$27
  'I' = <color>+$28 : 'J' = <color>+$29 : 'K' = <color>+$2A : 'L' = <color>+$2B
  'M' = <color>+$2C : 'N' = <color>+$2D : 'O' = <color>+$2E : 'P' = <color>+$2F
  'Q' = <color>+$40 : 'R' = <color>+$41 : 'S' = <color>+$42 : 'T' = <color>+$43
  'U' = <color>+$44 : 'V' = <color>+$45 : 'W' = <color>+$46 : 'X' = <color>+$47
  'Y' = <color>+$48 : 'Z' = <color>+$49 : ':' = <color>+$1A : ';' = <color>+$1A
  '.' = <color>+$7F : ',' = <color>+$7F : ''' = <color>+$4A : '"' = <color>+$4B
  '0' = <color>+$60 : '1' = <color>+$61 : '2' = <color>+$62 : '3' = <color>+$63
  '4' = <color>+$64 : '5' = <color>+$65 : '6' = <color>+$66 : '7' = <color>+$67
  '8' = <color>+$68 : '9' = <color>+$69
  '%' = <color>+$6A : '&' = <color>+$7B : '!' = <color>+$53 : : ' ' = <color>+$7F
}
endmacro

macro credits_large2_font(color)
  'A' = <color>+$30 : 'B' = <color>+$31 : 'C' = <color>+$32 : 'D' = <color>+$33
  'E' = <color>+$34 : 'F' = <color>+$35 : 'G' = <color>+$36 : 'H' = <color>+$37
  'I' = <color>+$38 : 'J' = <color>+$39 : 'K' = <color>+$3A : 'L' = <color>+$3B
  'M' = <color>+$3C : 'N' = <color>+$3D : 'O' = <color>+$3E : 'P' = <color>+$3F
  'Q' = <color>+$50 : 'R' = <color>+$51 : 'S' = <color>+$52 : 'T' = <color>+$53
  'U' = <color>+$54 : 'V' = <color>+$55 : 'W' = <color>+$56 : 'X' = <color>+$57
  'Y' = <color>+$58 : 'Z' = <color>+$59 : ':' = <color>+$1A : ';' = <color>+$1B
  '.' = <color>+$1A : ',' = <color>+$1B : ''' = <color>+$7F : '"' = <color>+$7F
  '0' = <color>+$70 : '1' = <color>+$71 : '2' = <color>+$72 : '3' = <color>+$73
  '4' = <color>+$74 : '5' = <color>+$75 : '6' = <color>+$76 : '7' = <color>+$77
  '8' = <color>+$78 : '9' = <color>+$79
  '%' = <color>+$7A : '&' = <color>+$7C : '!' = <color>+$5A : ' ' = <color>+$7F
}
endmacro

!credits_instruction_list_bank = $C7

org $8BE0EA
JSR init_credits_instruction_list

org $8B9971
LDA !credits_instruction_list_bank
PHA
%assertpc($8B9974)

%BEGIN_FREESPACE(8B)

init_credits_instruction_list:
{
  JSR $9932
  LDA #$8C00
  STA !credits_instruction_list_bank
  RTS
}

write_credits:
{
  LDA $1A01
  ASL : ASL : ASL : ASL : ASL : ASL
  TAX

.loop:
  LDA $0000,y
  BMI .done
  STA $7E3000,x
  INX : INX
  INY : INY
  BRA .loop

.done:
  PLA
  DEY : DEY : DEY : DEY

  JMP $99AD
}

credits_goto = $8B9A06

credits_goto_long:
{
  LDA $0000,y
  STA $19F7
  PHA

  LDA $0002,y
  AND #$00FF
  XBA
  STA !credits_instruction_list_bank

  PHA
  PLB : PLB

  PLY

  RTS
}

%END_FREESPACE(8B)
