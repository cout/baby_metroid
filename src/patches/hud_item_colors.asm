org $809616+$04 : dw begin_hud_drawing_hook
org $809616+$06 : dw end_hud_drawing_hook

begin_hud_drawing = $80968B
end_hud_drawing = $8096A9

org !FREESPACE_80

begin_hud_drawing_hook:
{
  LDA $09D2
  ASL
  ASL
  ASL
  CLC
  ADC #hud_selected_item_palette
  STA $7FFC00
  TAX
  JSR hud_set_palette

  JMP begin_hud_drawing
}

end_hud_drawing_hook:
{
  LDA #$0000
  TAX
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
  SEP #$20
  LDA #$10 : STA $2121
  LDA $0000,x : STA $2122
  LDA $0001,x : STA $2122
  LDA $0002,x : STA $2122
  LDA $0003,x : STA $2122
  LDA $0004,x : STA $2122
  LDA $0005,x : STA $2122
  LDA $0006,x : STA $2122
  LDA $0007,x : STA $2122
  REP #$20
  RTS
}

end_hud_item_colors_freespace_80:
!FREESPACE_80 := end_hud_item_colors_freespace_80
