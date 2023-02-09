pushtable

org $82EC66
{
  PHB
  LDX.w #option_menu_tilemap
  LDY #$C000
  LDA #$0800
  MVN $B87F
  PLB
  JMP $EC77
}
warnpc $82EC77

org $82EDDA
toggle_japanese_text:
{
  STZ $099E
  LDA !hard_mode_flag
  BEQ .enable_hard_mode

.disable_hard_mode:
  STZ !hard_mode_flag
  BRA .change_palette

.enable_hard_mode:
  LDA #$0001
  STA !hard_mode_flag

.change_palette:
  LDA !hard_mode_flag
}

%BEGIN_FREESPACE(B8)

option_menu_tilemap:
{
  %title_menu_large($0000) : dw "                                "
                             dw "          OPTION MODE           "
                             dw "          option mode           "
                             dw "                                "
                             dw "                                "
                             dw "                                "
                             dw "    START GAME                  "
                             dw "    start game                  "
                             dw "                                "
                             dw "                                "
                             dw "    EASY MODE                   "
                             dw "    easy mode                   "
                             dw "                                "
  %title_menu_large($0400) : dw "    HARD MODE                   "
                             dw "    hard mode                   "
  %title_menu_large($0000) : dw "                                "
                             dw "                                "
                             dw "    CONTROLLER SETTING MODE     "
                             dw "    controller setting mode     "
                             dw "                                "
                             dw "                                "
                             dw "    SPECIAL SETTING MODE        "
                             dw "    special setting mode        "
                             dw "                                "
                             dw "                                "
  %title_menu_small($0000) : dw "  ab        ef      ij          "
                             dw "  cdSELECT  gh OK!  klCANCEL    "
                             dw "                                "
                             dw "                                "
                             dw "                                "
                             dw "                                "
                             dw "                                "
}
option_menu_tilemap_end:

%END_FREESPACE(B8)

pulltable
; vim:ft=pic
