org !FREEMEM_7F

credits_color:
print "Variable credits_color: ", pc
skip 2

global end_credits_freemem_7f:
!FREEMEM_7F := end_credits_freemem_7f

macro small_font()
{
  'A' = $0000 : 'B' = $0001 : 'C' = $0002 : 'D' = $0003
  'E' = $0004 : 'F' = $0005 : 'G' = $0006 : 'H' = $0007
  'I' = $0008 : 'J' = $0009 : 'K' = $000A : 'L' = $000B
  'M' = $000C : 'N' = $000D : 'O' = $000E : 'P' = $000F
  'Q' = $0010 : 'R' = $0011 : 'S' = $0012 : 'T' = $0013
  'U' = $0014 : 'V' = $0015 : 'W' = $0016 : 'X' = $0017
  'Y' = $0018 : 'Z' = $0019 : '.' = $001A : ',' = $001B
  '*' = $001C : ''' = $001D : ':' = $001E : '!' = $001F
  '"' = $004A : ' ' = $007F
}
endmacro

macro large_font()
{
  'A' = $0020 : 'B' = $0021 : 'C' = $0022 : 'D' = $0023
  'E' = $0024 : 'F' = $0025 : 'G' = $0026 : 'H' = $0027
  'I' = $0028 : 'J' = $0029 : 'K' = $002A : 'L' = $002B
  'M' = $002C : 'N' = $002D : 'O' = $002E : 'P' = $002F
  'Q' = $0040 : 'R' = $0041 : 'S' = $0042 : 'T' = $0043
  'U' = $0044 : 'V' = $0045 : 'W' = $0046 : 'X' = $0047
  'Y' = $0048 : 'Z' = $0049 : ''' = $004A : '"' = $004B
  'a' = $0030 : 'b' = $0031 : 'c' = $0032 : 'd' = $0033
  'e' = $0034 : 'f' = $0035 : 'g' = $0036 : 'h' = $0037
  'i' = $0038 : 'j' = $0039 : 'k' = $003A : 'l' = $003B
  'm' = $003C : 'n' = $003D : 'o' = $003E : 'p' = $003F
  'q' = $0050 : 'r' = $0051 : 's' = $0052 : 't' = $0053
  'u' = $0054 : 'v' = $0055 : 'w' = $0056 : 'x' = $0057
  'y' = $0058 : 'z' = $0059 : '.' = $005A : ',' = $001B
  '0' = $0060 : '1' = $0061 : '2' = $0062 : '3' = $0063
  '4' = $0064 : '5' = $0065 : '6' = $0066 : '7' = $0067
  '8' = $0068 : '9' = $0069
  ')' = $0070 : '!' = $0071 : '@' = $0072 : '#' = $0073
  '$' = $0074 : '%' = $0075 : '^' = $0076 : '&' = $0077
  '*' = $0078 : '(' = $0079
  ' ' = $007F
}
endmacro

org !FREESPACE_8B

write_credits:
{
  LDA $1A01
  ASL : ASL : ASL : ASL : ASL : ASL
  TAX

  TYA
  STA $7FFC00

.loop:
  LDA $0000,y
  BMI .done
  CMP #$007F
  BEQ +
  CLC
  ADC credits_color
+ STA $7E3000,x
  INX : INX
  INY : INY
  BRA .loop

.done:
  PLA
  DEY : DEY : DEY : DEY

  TYA
  STA $7FFC02

  JMP $99AD
}

set_credits_color:
{
  LDA $0000,y
  STA credits_color
  INY
  INY
  RTS
}

global end_credits_freespace_8b:
!FREESPACE_8B := end_credits_freespace_8b
