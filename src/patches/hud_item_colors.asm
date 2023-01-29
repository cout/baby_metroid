!begin_hud_colors_irq_command = #begin_hud_colors_entry-$9616
!end_hud_colors_0_irq_command = #end_hud_colors_0_entry-$9616
!end_hud_colors_1_irq_command = #end_hud_colors_1_entry-$9616

org $80969F : LDA.w !end_hud_colors_0_irq_command
org $8096A2 : LDY #$001D
org $8096A5 : LDX #$0090

org $8096C9 : LDA.w !begin_hud_colors_irq_command
org $8096CC : LDY #$00F5
org $8096CF : LDX #$0000

begin_hud_drawing = $80968B
end_hud_drawing = $8096A9

!hud_selected_item_palette_index = $09EC

org $809C6F
JSR store_hud_item_index
%assertpc($809C72)

org !FREESPACE_80

extra_irq_commands:
begin_hud_colors_entry: dw begin_hud_colors_irq_command_handler
end_hud_colors_0_entry: dw end_hud_colors_0_irq_command_handler
end_hud_colors_1_entry: dw end_hud_colors_1_irq_command_handler

begin_hud_colors_irq_command_handler:
{
  JSR set_hud_colors

  LDA #$0004
  LDY #$0000
  LDX #$0098
  RTS
}

end_hud_colors_0_irq_command_handler:
{
  JSR restore_green_door_colors_0

  LDA !end_hud_colors_1_irq_command
  LDY #$001E
  LDX #$0090
  RTS
}


end_hud_colors_1_irq_command_handler:
{
  JSR restore_green_door_colors_1

  LDA #$0006
  LDY #$001F
  LDX #$0098
  RTS
}

hud_selected_item_palette:
{
  dw $0000, $0BB1, $1EA9, $0145 ; nothing (and green doors)
  dw $0000, $72BC, $48FB, $1816 ; missiles
  dw $0000, $0BB1, $1EA9, $0145 ; super missiles
  dw $0000, $02DF, $01D7, $00AC ; power bombs
  dw $0000, $72B2, $71C7, $4D03 ; grapple beam
  dw $0000, $72B2, $71C7, $4D03 ; xray
}

set_hud_colors:
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
  RTS
}

restore_green_door_colors_0:
{
  SEP #$30
  LDA #$11 : STA $2121
  LDA hud_selected_item_palette+$02 : STA $2122
  LDA hud_selected_item_palette+$03 : STA $2122
  REP #$30
  RTS
}

restore_green_door_colors_1:
{
  SEP #$30
  LDA hud_selected_item_palette+$04 : STA $2122
  LDA hud_selected_item_palette+$05 : STA $2122
  LDA hud_selected_item_palette+$06 : STA $2122
  LDA hud_selected_item_palette+$07 : STA $2122
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
