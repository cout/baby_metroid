; selected item palette (loading game)
org $809B2E
JSR pick_item_selected_palette

; selected item palette (playing game)
org $809C5D
JSR pick_item_selected_palette

; auto-cancel hud palette
org $809CA1
JSR pick_item_selected_palette

org $809CEA
JSR update_palette

; Change the minimap flashing color
org $90AB56
JSR set_minimap_flashing_color

org !FREESPACE_80

pick_item_selected_palette:
{
  PHA
  LDA $09D2
  ASL
  TAX
  LDA selected_item_palette,x
  TAX
  PLA
  RTS
}

selected_item_palette:
{
  dw #$1000 ; nothing
  dw #$1C00 ; missiles
  dw #$1000 ; super missiles
  dw #$0000 ; power bombs
  dw #$1000 ; grapple beam
  dw #$1000 ; xray
}

update_palette:
{
  PHA
  ; We can't use all 4 color slots, because the final slot (black) is
  ; used by scene elements.  In addition, the default pink door color is
  ; too similar to the minimap color, which makes it look bland.  The
  ; colors chosen here are slightly darker, to compensate.
  LDA #$5DDC : STA $7EC03A : STA $7EC23A
  LDA #$3079 : STA $7EC03C : STA $7EC23C
  PLA
  STX $077C
  RTS
}

end_hud_item_colors_freespace_80:
!FREESPACE_80 := end_hud_item_colors_freespace_80

org !FREESPACE_90

set_minimap_flashing_color:
{
  AND #$E3FF
  ORA #$0000
  RTS
}

end_hud_item_colors_freespace_90:
!FREESPACE_90 := end_hud_item_colors_freespace_90
