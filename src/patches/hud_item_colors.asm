org $809616+$04 : dw begin_hud_drawing_hook
org $809616+$06 : dw end_hud_drawing_hook

begin_hud_drawing = $80968B
end_hud_drawing = $8096A9

!hud_selected_item_palette_index = $09EC

org $809C6F
JSR store_hud_item_index
%assertpc($809C72)

org !FREESPACE_80

begin_hud_drawing_hook:
{
  LDX !hud_selected_item_palette_index
  JSR hud_set_palette

  JMP begin_hud_drawing
}

end_hud_drawing_hook:
{
  LDX #$0000
  JSR hud_set_palette

  JMP end_hud_drawing
}

hud_selected_item_palette:
print "hud_selected_item_palette: ", pc
{
  dw $0000, $0BB1, $1EA9, $0145 ; nothing (and green doors)
  dw $0000, $72BC, $48FB, $1816 ; missiles
  dw $0000, $0BB1, $1EA9, $0145 ; super missiles
  dw $0000, $02DF, $01D7, $00AC ; power bombs
  dw $0000, $72B2, $71C7, $4D03 ; grapple beam
  dw $0000, $72B2, $71C7, $4D03 ; xray
}

hud_set_palette:
{
  SEP #$30

  ; TM=0 (turn off display for main screen)
  ; This fixes an issue on higan where CGRAM is read at the same time we
  ; are writing, resulting in visual artifacts
  ; TODO - there are still some visual artifacts as a result of changing
  ; the timing on HUD drawing
  LDA #$00 : STA $212C

  LDA #$11 : STA $2121
  LDA hud_selected_item_palette+$02,x : STA $2122
  LDA hud_selected_item_palette+$03,x : STA $2122
  LDA hud_selected_item_palette+$04,x : STA $2122
  LDA hud_selected_item_palette+$05,x : STA $2122
  LDA hud_selected_item_palette+$06,x : STA $2122
  LDA hud_selected_item_palette+$07,x : STA $2122
  REP #$30
  RTS
}

store_hud_item_index:
{
  STA $0A0E
  ASL
  ASL
  ASL
  STA $09EC
  RTS
}

end_hud_item_colors_freespace_80:
!FREESPACE_80 := end_hud_item_colors_freespace_80
