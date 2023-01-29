!hud_selected_item_palette_index = $C1

!main_gameplay_begin_hud_drawing_irq_command    = #$0004
!main_gameplay_end_hud_drawing_irq_command      = #$0006
!start_transition_begin_hud_drawing_irq_command = #$0008
!start_transition_end_hud_drawing_irq_command   = #$000A
!draygon_begin_hud_drawing_irq_command          = #$000C
!draygon_end_hud_drawing_irq_command            = #$000E
!vert_transition_begin_hud_drawing_irq_command  = #$0010
!vert_transition_end_hud_drawing_irq_command    = #$0012
!vert_transition_end_drawing                    = #$0014
!horiz_transition_begin_hud_drawing_irq_command = #$0016
!horiz_transition_end_hud_drawing_irq_command   = #$0018
!horiz_transition_end_drawing                   = #$001A

!main_gameplay_begin_hud_colors_irq_command     = #main_gameplay_begin_hud_colors_entry-$9616
!main_gameplay_end_hud_colors_0_irq_command     = #main_gameplay_end_hud_colors_0_entry-$9616
!main_gameplay_end_hud_colors_1_irq_command     = #main_gameplay_end_hud_colors_1_entry-$9616
!start_transition_begin_hud_colors_irq_command  = #start_transition_begin_hud_colors_entry-$9616
!start_transition_end_hud_colors_0_irq_command  = #start_transition_end_hud_colors_0_entry-$9616
!start_transition_end_hud_colors_1_irq_command  = #start_transition_end_hud_colors_1_entry-$9616
!draygon_begin_hud_colors_irq_command           = #draygon_begin_hud_colors_entry-$9616
!draygon_end_hud_colors_0_irq_command           = #draygon_end_hud_colors_0_entry-$9616
!draygon_end_hud_colors_1_irq_command           = #draygon_end_hud_colors_1_entry-$9616
!vert_transition_begin_hud_colors_irq_command   = #vert_transition_begin_hud_colors_entry-$9616
!vert_transition_end_hud_colors_0_irq_command   = #vert_transition_end_hud_colors_0_entry-$9616
!vert_transition_end_hud_colors_1_irq_command   = #vert_transition_end_hud_colors_1_entry-$9616
!horiz_transition_begin_hud_colors_irq_command  = #horiz_transition_begin_hud_colors_entry-$9616
!horiz_transition_end_hud_colors_0_irq_command  = #horiz_transition_end_hud_colors_0_entry-$9616
!horiz_transition_end_hud_colors_1_irq_command  = #horiz_transition_end_hud_colors_1_entry-$9616

org $80969F : LDA.w !main_gameplay_end_hud_colors_0_irq_command
org $8096A2 : LDY #$001D
org $8096A5 : LDX #$0090

org $8096C9 : LDA.w !main_gameplay_begin_hud_colors_irq_command
org $8096CC : LDY #$00F5
org $8096CF : LDX #$0000

org $8096E7 : LDA.w !start_transition_end_hud_colors_0_irq_command
org $8096EA : LDY #$001D
org $8096ED : LDX #$0090

org $809710 : LDA.w !start_transition_begin_hud_colors_irq_command
org $809713 : LDY #$00F5
org $809716 : LDX #$0000

org $809729 : LDA.w !draygon_end_hud_colors_0_irq_command
org $80972C : LDY #$001D
org $80972F : LDX #$0090

org $80974E : LDA.w !draygon_begin_hud_colors_irq_command
org $809751 : LDY #$00F5
org $809754 : LDX #$0000

org $809767 : LDA.w !vert_transition_end_hud_colors_0_irq_command
org $80976A : LDY #$001D
org $80976D : LDX #$0090

org $8097B1 : LDA.w !vert_transition_begin_hud_colors_irq_command
org $8097B4 : LDY #$00F5
org $8097B7 : LDX #$0000

org $8097D0 : LDA.w !horiz_transition_end_hud_colors_0_irq_command
org $8097D3 : LDY #$001D
org $8097D6 : LDX #$0090

org $80981A : LDA.w !horiz_transition_begin_hud_colors_irq_command
org $80981D : LDY #$00F5
org $809820 : LDX #$0000

org $809C6F
JSR store_hud_item_index
%assertpc($809C72)

org !FREESPACE_80

extra_irq_commands:
main_gameplay_begin_hud_colors_entry:    dw main_gameplay_begin_hud_colors_handler
main_gameplay_end_hud_colors_0_entry:    dw main_gameplay_end_hud_colors_0_handler
main_gameplay_end_hud_colors_1_entry:    dw main_gameplay_end_hud_colors_1_handler
start_transition_begin_hud_colors_entry: dw start_transition_begin_hud_colors_handler
start_transition_end_hud_colors_0_entry: dw start_transition_end_hud_colors_0_handler
start_transition_end_hud_colors_1_entry: dw start_transition_end_hud_colors_1_handler
draygon_begin_hud_colors_entry:          dw draygon_begin_hud_colors_handler
draygon_end_hud_colors_0_entry:          dw draygon_end_hud_colors_0_handler
draygon_end_hud_colors_1_entry:          dw draygon_end_hud_colors_1_handler
vert_transition_begin_hud_colors_entry:  dw vert_transition_begin_hud_colors_handler
vert_transition_end_hud_colors_0_entry:  dw vert_transition_end_hud_colors_0_handler
vert_transition_end_hud_colors_1_entry:  dw vert_transition_end_hud_colors_1_handler
horiz_transition_begin_hud_colors_entry: dw horiz_transition_begin_hud_colors_handler
horiz_transition_end_hud_colors_0_entry: dw horiz_transition_end_hud_colors_0_handler
horiz_transition_end_hud_colors_1_entry: dw horiz_transition_end_hud_colors_1_handler

main_gameplay_begin_hud_colors_handler:
{
  JSR set_hud_colors

  LDA !main_gameplay_begin_hud_drawing_irq_command
  LDY #$0000
  LDX #$0098
  RTS
}

main_gameplay_end_hud_colors_0_handler:
{
  JSR restore_green_door_colors_0

  LDA.w !main_gameplay_end_hud_colors_1_irq_command
  LDY #$001E
  LDX #$0090
  RTS
}

main_gameplay_end_hud_colors_1_handler:
{
  JSR restore_green_door_colors_1

  LDA !main_gameplay_end_hud_drawing_irq_command
  LDY #$001F
  LDX #$0098
  RTS
}

start_transition_begin_hud_colors_handler:
{
  JSR set_hud_colors

  LDA.w !start_transition_begin_hud_drawing_irq_command
  LDY #$0000
  LDX #$0098
  RTS
}

start_transition_end_hud_colors_0_handler:
{
  JSR restore_green_door_colors_0

  LDA.w !start_transition_end_hud_colors_1_irq_command
  LDY #$001E
  LDX #$0090
  RTS
}

start_transition_end_hud_colors_1_handler:
{
  JSR restore_green_door_colors_1

  LDA !start_transition_end_hud_drawing_irq_command
  LDY #$001F
  LDX #$0098
  RTS
}

draygon_begin_hud_colors_handler:
{
  JSR set_hud_colors

  LDA.w !draygon_begin_hud_drawing_irq_command
  LDY #$0000
  LDX #$0098
  RTS
}

draygon_end_hud_colors_0_handler:
{
  JSR restore_green_door_colors_0

  LDA.w !draygon_end_hud_colors_1_irq_command
  LDY #$001E
  LDX #$0090
  RTS
}

draygon_end_hud_colors_1_handler:
{
  JSR restore_green_door_colors_1

  LDA !draygon_end_hud_drawing_irq_command
  LDY #$001F
  LDX #$0098
  RTS
}

vert_transition_begin_hud_colors_handler:
{
  JSR set_hud_colors

  LDA.w !vert_transition_begin_hud_drawing_irq_command
  LDY #$0000
  LDX #$0098
  RTS
}

vert_transition_end_hud_colors_0_handler:
{
  JSR restore_green_door_colors_0

  LDA.w !vert_transition_end_hud_colors_1_irq_command
  LDY #$001E
  LDX #$0090
  RTS
}

vert_transition_end_hud_colors_1_handler:
{
  JSR restore_green_door_colors_1

  LDA !vert_transition_end_hud_drawing_irq_command
  LDY #$001F
  LDX #$0098
  RTS
}

horiz_transition_begin_hud_colors_handler:
{
  JSR set_hud_colors

  LDA.w !horiz_transition_begin_hud_drawing_irq_command
  LDY #$0000
  LDX #$0098
  RTS
}

horiz_transition_end_hud_colors_0_handler:
{
  JSR restore_green_door_colors_0

  LDA.w !horiz_transition_end_hud_colors_1_irq_command
  LDY #$001E
  LDX #$0090
  RTS
}

horiz_transition_end_hud_colors_1_handler:
{
  JSR restore_green_door_colors_1

  LDA !horiz_transition_end_hud_drawing_irq_command
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
  STA !hud_selected_item_palette_index
  RTS
}

end_hud_item_colors_freespace_80:
!FREESPACE_80 := end_hud_item_colors_freespace_80
