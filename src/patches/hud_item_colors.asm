org $809616+$04 : dw begin_hud_drawing_hook
org $809616+$06 : dw end_hud_drawing_hook

org $8096A2 : LDY #$001E
org $8096A5 : LDX #$0098

org $8096CC : LDX #$0000
org $8096CF : LDX #$0000

begin_hud_drawing = $80968B
end_hud_drawing = $8096A9

!hud_selected_item_palette_index = $09EC

org $809C6F
JSR store_hud_item_index
%assertpc($809C72)

org !FREESPACE_80

begin_hud_drawing_hook:
{
  SEP #$30
  LDX !hud_selected_item_palette_index
  LDA #$8F : STA $2100
  LDA #$11 : STA $2121
  LDA hud_selected_item_palette+$02,x : STA $2122
  LDA hud_selected_item_palette+$03,x : STA $2122
  LDA hud_selected_item_palette+$04,x : STA $2122
  LDA hud_selected_item_palette+$05,x : STA $2122
  LDA hud_selected_item_palette+$06,x : STA $2122
  LDA hud_selected_item_palette+$07,x : STA $2122
  LDA $51 : STA $2100
  REP #$30

  JMP begin_hud_drawing
}

end_hud_drawing_hook:
{
  SEP #$30
  LDX #$00
  LDA #$8F : STA $2100
  LDA #$11 : STA $2121
  LDA hud_selected_item_palette+$02,x : STA $2122
  LDA hud_selected_item_palette+$03,x : STA $2122
  LDA hud_selected_item_palette+$04,x : STA $2122
  LDA hud_selected_item_palette+$05,x : STA $2122
  LDA hud_selected_item_palette+$06,x : STA $2122
  LDA hud_selected_item_palette+$07,x : STA $2122
  LDA $51 : STA $2100
  REP #$30

  NOP : NOP : NOP : NOP : NOP : NOP : NOP : NOP
  NOP : NOP : NOP : NOP : NOP : NOP : NOP : NOP
  NOP : NOP : NOP : NOP : NOP : NOP : NOP : NOP
  NOP : NOP : NOP : NOP : NOP : NOP : NOP : NOP
  NOP : NOP : NOP : NOP : NOP : NOP : NOP : NOP
  NOP : NOP : NOP : NOP : NOP : NOP : NOP : NOP
  NOP : NOP : NOP : NOP : NOP : NOP : NOP : NOP
  NOP : NOP : NOP : NOP : NOP : NOP : NOP : NOP

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
