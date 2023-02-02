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

org credits_goto_long
I_goto_long:

!small = %credits_small_font
!large1 = %credits_large1_font
!large2 = %credits_large2_font

!w = " : !small(white) : dw "
!y = " : !large1(yellow) : dw "
!o = " : !small(orange) : dw "
!g = " : !small(green) : dw "
!P = " : !small(purple) : dw "
!p = " : !small(pink) : dw "
!b = " : !small(blue) : dw "
!w1 = " : !large1(white) : dw "
!y1 = " : !large1(yellow) : dw "
!o1 = " : !large1(orange) : dw "
!g1 = " : !large1(green) : dw "
!P1 = " : !large1(purple) : dw "
!p1 = " : !large1(pink) : dw "
!b1 = " : !large1(blue) : dw "
!w2 = " : !large2(white) : dw "
!y2 = " : !large2(yellow) : dw "
!o2 = " : !large2(orange) : dw "
!g2 = " : !large2(green) : dw "
!P2 = " : !large2(purple) : dw "
!p2 = " : !large2(pink) : dw "
!b2 = " : !large2(blue) : dw "

!credits_separation_lines = $000D
!credits_end_lines = $0023

blank_line = $1FC0

white  = credits_color_white
yellow = credits_color_yellow
cyan   = credits_color_cyan
green  = credits_color_green
pink   = credits_color_pink
blue   = credits_color_blue
orange = credits_color_orange
purple = credits_color_purple

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

!extra_credit_lines := ((16-!credits_separation_lines)*20)
print "Extra credit lines available: ", dec(!extra_credit_lines)

org $8CDC8F-$04 : dw I_goto_long : dl baby_metroid_credits

org !FREESPACE_B8

baby_metroid_credits:
{
  dw I_set_timer, $000F
- dw I_draw, blank_line
  dw I_loop, -

.extra_credits_start:
!small(green)   : dw I_write, " THANKS TO EVERYONE IN METCONST "
!small(green)   : dw I_write, "   WHO HELPED MAKE THIS DREAM   "
!small(green)   : dw I_write, "        INTO A REALITY          "
!small(green)   : dw I_write, "                                "
!large1(white)  : dw I_write, " TESTRUNNER PJBOY INSANEFIREBAT "
!large2(white)  : dw I_write, " TESTRUNNER PJBOY INSANEFIREBAT "
!large1(white)  : dw I_write, "  OI27 MOEHR CRAZY NEEN AMOEBA  "
!large2(white)  : dw I_write, "  OI27 MOEHR CRAZY NEEN AMOEBA  "
!large1(white)  : dw I_write, "  SMILEY OUICHEGEANTE NODEVER2  "
!large2(white)  : dw I_write, "  SMILEY OUICHEGEANTE NODEVER2  "
!large1(white)  : dw I_write, "    METROIDNERD9001 SOMERANDO   "
!large2(white)  : dw I_write, "    METROIDNERD9001 SOMERANDO   "
!large1(white)  : dw I_write, "  OB NOBODYNADA STROTLOG YURIK  "
!large2(white)  : dw I_write, "  OB NOBODYNADA STROTLOG YURIK  "
!large1(white)  : dw I_write, "     SCYZER EXISTER BENOX50     "
!large2(white)  : dw I_write, "     SCYZER EXISTER BENOX50     "
!large1(white)  : dw I_write, "        AND MANY OTHERS         "
!large2(white)  : dw I_write, "        AND MANY OTHERS         "
!small(white)   : dw I_write, "                                " ; 1
!small(white)   : dw I_write, "                                " ; 2
!small(white)   : dw I_write, "                                " ; 3
!small(white)   : dw I_write, "                                " ; 4
!small(white)   : dw I_write, "                                " ; 5
!small(white)   : dw I_write, "                                " ; 6
!small(white)   : dw I_write, "                                " ; 7
!small(white)   : dw I_write, "                                " ; 8
!small(white)   : dw I_write, "                                " ; 9
!small(white)   : dw I_write, "                                " ; 10
!small(white)   : dw I_write, "                                " ; 11
!small(white)   : dw I_write, "                                " ; 12
!small(white)   : dw I_write, "                                " ; 13
!small(white)   : dw I_write, "                                " ; 14
!small(white)   : dw I_write, "                                " ; 15
!small(pink)    : dw I_write, "        SPECIAL THANKS TO       "
!small(white)   : dw I_write, "                                "
!large1(white)  : dw I_write, "              OI27              "
!large2(white)  : dw I_write, "              OI27              "
!small(white)   : dw I_write, "                                "
!small(cyan)    : dw I_write, "        FOR THE HEX TWEAK       "
!small(cyan)    : dw I_write, "   THAT INSPIRED THIS ROMHACK   "
!small(white)   : dw I_write, "                                "
!large1(yellow) : dw I_write, "          100FD4 TO 6B          "
!large2(yellow) : dw I_write, "          100FD4 TO 6B          "
!small(white)   : dw I_write, "                                " ; 1
!small(white)   : dw I_write, "                                " ; 2
!small(white)   : dw I_write, "                                " ; 3
!small(white)   : dw I_write, "                                " ; 4
!small(white)   : dw I_write, "                                " ; 5
!small(white)   : dw I_write, "                                " ; 6
!small(white)   : dw I_write, "                                " ; 7
!small(white)   : dw I_write, "                                " ; 8
!small(white)   : dw I_write, "                                " ; 9
!small(white)   : dw I_write, "                                " ; 10
!small(white)   : dw I_write, "                                " ; 11
!small(white)   : dw I_write, "                                " ; 12
!small(white)   : dw I_write, "                                " ; 13
!small(white)   : dw I_write, "                                " ; 14
!small(white)   : dw I_write, "                                " ; 15
!small(blue)    : dw I_write, "  THIS HACK WAS MADE WITH " !p "LOVE  "
!small(blue)    : dw I_write, "   FOR MY SON AND MY DAUGHTER   "
!small(white)   : dw I_write, "                                "
!large1(white)  : dw I_write, "           " !o1 "E" !w1 "  AND  " !o1 "G           "
!large2(white)  : dw I_write, "           " !y2 "E" !w2 "  AND  " !y2 "G           "
.extra_credits_end:

  dw I_set_timer, !credits_end_lines
- dw I_draw, blank_line
  dw I_loop, -

  dw I_end_credits
  dw I_delete

  !extra_credit_lines_used := (.extra_credits_end-.extra_credits_start)/68-1
  print "Extra credit lines used: ", dec(!extra_credit_lines_used)

  assert !extra_credit_lines_used = !extra_credit_lines
}

global end_credits_freespace_b8:
!FREESPACE_B8 := end_credits_freespace_b8

undef "small"
undef "large1"
undef "large2"

pulltable
namespace off
; vim:ft=masm
