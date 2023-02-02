namespace credits
pushtable

I_goto = $8B9A06
I_set_timer = $8B9A17
I_loop = $8B9A0D
I_end_credits = $8BF6FE
I_delete = $8B99FE
I_draw = $0000

org write_credits
I_write:

org set_credits_color
I_color:

!small = %credits_small_font()
!large1 = %credits_large1_font()
!large2 = %credits_large2_font()

!credits_separation_lines = $000D
!credits_end_lines = $0023

blank_line = $1FC0

white  = $0000
yellow = $0400
cyan   = $0800
green  = $0C00
pink   = $1000
blue   = $1400
orange = $1800
purple = $1C00

org $8CD92F-$02 : dw !credits_separation_lines
org $8CD94B-$02 : dw !credits_separation_lines
org $8CD967-$02 : dw !credits_separation_lines
org $8CD99B-$02 : dw !credits_separation_lines
org $8CD9C3-$02 : dw !credits_separation_lines
org $8CD9DF-$02 : dw !credits_separation_lines
org $8CD9FB-$02 : dw !credits_separation_lines
org $8CDA1B-$02 : dw !credits_separation_lines
org $8CDA43-$02 : dw !credits_separation_lines
org $8CDA5F-$02 : dw !credits_separation_lines
org $8CDA7B-$02 : dw !credits_separation_lines
org $8CDA97-$02 : dw !credits_separation_lines
org $8CDAB3-$02 : dw !credits_separation_lines
org $8CDACF-$02 : dw !credits_separation_lines
org $8CDAEB-$02 : dw !credits_separation_lines
org $8CDB07-$02 : dw !credits_separation_lines
org $8CDB23-$02 : dw !credits_separation_lines
org $8CDB4B-$02 : dw !credits_separation_lines
org $8CDBA3-$02 : dw !credits_separation_lines
org $8CDC73-$02 : dw !credits_separation_lines

org $8CDC8F-$04 : dw I_goto, baby_metroid_credits

org !FREESPACE_8C

baby_metroid_credits:
{
  dw I_set_timer, !credits_separation_lines
- dw I_draw, blank_line
  dw I_loop, -

  !small  : dw I_color, white  : dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ.,':! " ; 0
  !small  : dw I_color, yellow : dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ.,':! " ; 1
  !small  : dw I_color, cyan   : dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ.,':! " ; 2
  !small  : dw I_color, green  : dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ.,':! " ; 3
  !small  : dw I_color, pink   : dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ.,':! " ; 4
  !small  : dw I_color, blue   : dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ.,':! " ; 5
  !small  : dw I_color, orange : dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ.,':! " ; 6
  !small  : dw I_color, purple : dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ.,':! " ; 7
  !large1 : dw I_color, white  : dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ  '""  " ; 8
  !large2 :                      dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ.,    "  ; 9
  !large1 : dw I_color, yellow : dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ  '""  " ; 10
  !large2 :                      dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ.,    "  ; 11
  !large1 : dw I_color, cyan   : dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ  '""  " ; 12
  !large2 :                      dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ.,    "  ; 13
  !large1 : dw I_color, green  : dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ  '""  " ; 14
  !large2 :                      dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ.,    "  ; 15
  !large1 : dw I_color, pink   : dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ  '""  " ; 16
  !large2 :                      dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ.,    "  ; 17
  !large1 : dw I_color, blue   : dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ  '""  " ; 18
  !large2 :                      dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ.,    "  ; 19
  !large1 : dw I_color, orange : dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ  '""  " ; 20
  !large2 :                      dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ.,    "  ; 21
  !large1 : dw I_color, purple : dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ  '""  " ; 22
  !large2 :                      dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ.,    "  ; 23
  !large1 :                      dw I_write, "0123456789                      "  ; 24
  !large2 :                      dw I_write, "0123456789                      "  ; 25

  dw I_set_timer, !credits_end_lines
- dw I_draw, blank_line
  dw I_loop, -

  dw I_end_credits
  dw I_delete
}

global end_credits_freespace_8c:
!FREESPACE_8C := end_credits_freespace_8c

undef "small"
undef "large1"
undef "large2"

pulltable
namespace off
; vim:ft=masm
