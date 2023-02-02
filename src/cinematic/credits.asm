namespace credits
pushtable

I_goto = $9A06
I_set_timer = $9A17
I_loop = $9A0D
I_end_credits = $F6FE
I_delete = $99FE
I_draw = $0000

org write_credits
I_write:

org set_credits_color
I_color:

!credits_separation_lines = $000D
!credits_end_lines = $0023

blank_line = $1FC0

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

  %small_font()
  dw I_color, $0000 : dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ.,':! "  ; 0
  dw I_color, $0400 : dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ.,':! "  ; 1
  dw I_color, $0800 : dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ.,':! "  ; 2
  dw I_color, $0C00 : dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ.,':! "  ; 3
  dw I_color, $1000 : dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ.,':! "  ; 4
  dw I_color, $1400 : dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ.,':! "  ; 5
  dw I_color, $1800 : dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ.,':! "  ; 6
  dw I_color, $1C00 : dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ.,':! "  ; 7

  %large_font()
  dw I_color, $0000 : dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ  '""  " ; 8
                      dw I_write, "abcdefghijklmnopqrstuvwxyz.,    "  ; 9
  dw I_color, $0400 : dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ  '""  " ; 10
                      dw I_write, "abcdefghijklmnopqrstuvwxyz.,    "  ; 11
  dw I_color, $0800 : dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ  '""  " ; 12
                      dw I_write, "abcdefghijklmnopqrstuvwxyz.,    "  ; 13
  dw I_color, $0C00 : dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ  '""  " ; 14
                      dw I_write, "abcdefghijklmnopqrstuvwxyz.,    "  ; 15
  dw I_color, $1000 : dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ  '""  " ; 16
                      dw I_write, "abcdefghijklmnopqrstuvwxyz.,    "  ; 17
  dw I_color, $1400 : dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ  '""  " ; 18
                      dw I_write, "abcdefghijklmnopqrstuvwxyz.,    "  ; 19
  dw I_color, $1800 : dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ  '""  " ; 20
                      dw I_write, "abcdefghijklmnopqrstuvwxyz.,    "  ; 21
  dw I_color, $1C00 : dw I_write, "ABCDEFGHIJKLMNOPQRSTUVWXYZ  '""  " ; 22
                      dw I_write, "abcdefghijklmnopqrstuvwxyz.,    "  ; 23
                      dw I_write, "0123456789                      "  ; 24
                      dw I_write, ")!@#$%^&*(                      "  ; 25

  dw I_set_timer, !credits_end_lines
- dw I_draw, blank_line
  dw I_loop, -

  dw I_end_credits
  dw I_delete
}

global end_credits_freespace_8c:
!FREESPACE_8C := end_credits_freespace_8c

pulltable
namespace off
