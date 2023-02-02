org !FREEMEM_7F

credits_color:
print "Variable credits_color: ", pc
skip 2

global end_credits_freemem_7f:
!FREEMEM_7F := end_credits_freemem_7f

macro credits_small_font()
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

macro credits_large1_font()
{
  'A' = $0020 : 'B' = $0021 : 'C' = $0022 : 'D' = $0023
  'E' = $0024 : 'F' = $0025 : 'G' = $0026 : 'H' = $0027
  'I' = $0028 : 'J' = $0029 : 'K' = $002A : 'L' = $002B
  'M' = $002C : 'N' = $002D : 'O' = $002E : 'P' = $002F
  'Q' = $0040 : 'R' = $0041 : 'S' = $0042 : 'T' = $0043
  'U' = $0044 : 'V' = $0045 : 'W' = $0046 : 'X' = $0047
  'Y' = $0048 : 'Z' = $0049 : ''' = $004A : '"' = $004B
  '0' = $0060 : '1' = $0061 : '2' = $0062 : '3' = $0063
  '4' = $0064 : '5' = $0065 : '6' = $0066 : '7' = $0067
  '8' = $0068 : '9' = $0069 : ' ' = $007F
}
endmacro

macro credits_large2_font()
  'A' = $0030 : 'B' = $0031 : 'C' = $0032 : 'D' = $0033
  'E' = $0034 : 'F' = $0035 : 'G' = $0036 : 'H' = $0037
  'I' = $0038 : 'J' = $0039 : 'K' = $003A : 'L' = $003B
  'M' = $003C : 'N' = $003D : 'O' = $003E : 'P' = $003F
  'Q' = $0050 : 'R' = $0051 : 'S' = $0052 : 'T' = $0053
  'U' = $0054 : 'V' = $0055 : 'W' = $0056 : 'X' = $0057
  'Y' = $0058 : 'Z' = $0059 : '.' = $005A : ',' = $001B
  '0' = $0070 : '1' = $0071 : '2' = $0072 : '3' = $0073
  '4' = $0074 : '5' = $0075 : '6' = $0076 : '7' = $0077
  '8' = $0078 : '9' = $0079 : ' ' = $007F
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
