!hud_selected_item_palette_index = $C1
!hud_selected_item_palette_pointer = $C3

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
!main_gameplay_end_hud_colors_irq_command       = #main_gameplay_end_hud_colors_entry-$9616
!start_transition_begin_hud_colors_irq_command  = #start_transition_begin_hud_colors_entry-$9616
!start_transition_end_hud_colors_irq_command    = #start_transition_end_hud_colors_entry-$9616
!draygon_begin_hud_colors_irq_command           = #draygon_begin_hud_colors_entry-$9616
!draygon_end_hud_colors_irq_command             = #draygon_end_hud_colors_entry-$9616
!vert_transition_begin_hud_colors_irq_command   = #vert_transition_begin_hud_colors_entry-$9616
!vert_transition_end_hud_colors_irq_command     = #vert_transition_end_hud_colors_entry-$9616
!horiz_transition_begin_hud_colors_irq_command  = #horiz_transition_begin_hud_colors_entry-$9616
!horiz_transition_end_hud_colors_irq_command    = #horiz_transition_end_hud_colors_entry-$9616

!begin_hud_drawing_v_counter_target = #$0000
!begin_hud_drawing_h_counter_target = #$0098
!end_hud_colors_v_counter_target    = #$001E
!end_hud_colors_h_counter_target    = #$0050
!end_hud_drawing_v_counter_target   = #$001F
!end_hud_drawing_h_counter_target   = #$0098
!begin_hud_colors_v_counter_target  = #$00F5
!begin_hud_colors_h_counter_target  = #$0000

org $80969F : LDA.w !main_gameplay_end_hud_colors_irq_command
org $8096A2 : LDY !end_hud_colors_v_counter_target
org $8096A5 : LDX !end_hud_colors_h_counter_target

org $8096C9 : LDA.w !main_gameplay_begin_hud_colors_irq_command
org $8096CC : LDY !begin_hud_colors_v_counter_target
org $8096CF : LDX !begin_hud_colors_h_counter_target

org $8096E7 : LDA.w !start_transition_end_hud_colors_irq_command
org $8096EA : LDY !end_hud_colors_v_counter_target
org $8096ED : LDX !end_hud_colors_h_counter_target

org $809710 : LDA.w !start_transition_begin_hud_colors_irq_command
org $809713 : LDY !begin_hud_colors_v_counter_target
org $809716 : LDX !begin_hud_colors_h_counter_target

org $809729 : LDA.w !draygon_end_hud_colors_irq_command
org $80972C : LDY !end_hud_colors_v_counter_target
org $80972F : LDX !end_hud_colors_h_counter_target

org $80974E : LDA.w !draygon_begin_hud_colors_irq_command
org $809751 : LDY !begin_hud_colors_v_counter_target
org $809754 : LDX !begin_hud_colors_h_counter_target

org $809767 : LDA.w !vert_transition_end_hud_colors_irq_command
org $80976A : LDY !end_hud_colors_v_counter_target
org $80976D : LDX !end_hud_colors_h_counter_target

org $8097B1 : LDA.w !vert_transition_begin_hud_colors_irq_command
org $8097B4 : LDY !begin_hud_colors_v_counter_target
org $8097B7 : LDX !begin_hud_colors_h_counter_target

org $8097D0 : LDA.w !horiz_transition_end_hud_colors_irq_command
org $8097D3 : LDY !end_hud_colors_v_counter_target
org $8097D6 : LDX !end_hud_colors_h_counter_target

org $80981A : LDA.w !horiz_transition_begin_hud_colors_irq_command
org $80981D : LDY !begin_hud_colors_v_counter_target
org $809820 : LDX !begin_hud_colors_h_counter_target

org $809C6F
JSR store_hud_item_index
%assertpc($809C72)

%BEGIN_FREESPACE(80)

extra_irq_commands:
main_gameplay_begin_hud_colors_entry:    dw main_gameplay_begin_hud_colors_handler
main_gameplay_end_hud_colors_entry:      dw main_gameplay_end_hud_colors_handler
start_transition_begin_hud_colors_entry: dw start_transition_begin_hud_colors_handler
start_transition_end_hud_colors_entry:   dw start_transition_end_hud_colors_handler
draygon_begin_hud_colors_entry:          dw draygon_begin_hud_colors_handler
draygon_end_hud_colors_entry:            dw draygon_end_hud_colors_handler
vert_transition_begin_hud_colors_entry:  dw vert_transition_begin_hud_colors_handler
vert_transition_end_hud_colors_entry:    dw vert_transition_end_hud_colors_handler
horiz_transition_begin_hud_colors_entry: dw horiz_transition_begin_hud_colors_handler
horiz_transition_end_hud_colors_entry:   dw horiz_transition_end_hud_colors_handler

main_gameplay_begin_hud_colors_handler:
{
  JSR set_hud_colors

  LDA !main_gameplay_begin_hud_drawing_irq_command
  LDY !begin_hud_drawing_v_counter_target
  LDX !begin_hud_drawing_h_counter_target
  RTS
}

main_gameplay_end_hud_colors_handler:
{
  JSR restore_green_door_colors

  LDA !main_gameplay_end_hud_drawing_irq_command
  LDY !end_hud_drawing_v_counter_target
  LDX !end_hud_drawing_h_counter_target
  RTS
}

start_transition_begin_hud_colors_handler:
{
  JSR set_hud_colors

  LDA.w !start_transition_begin_hud_drawing_irq_command
  LDY !begin_hud_drawing_v_counter_target
  LDX !begin_hud_drawing_h_counter_target
  RTS
}

start_transition_end_hud_colors_handler:
{
  JSR restore_green_door_colors

  LDA !start_transition_end_hud_drawing_irq_command
  LDY !end_hud_drawing_v_counter_target
  LDX !end_hud_drawing_h_counter_target
  RTS
}

draygon_begin_hud_colors_handler:
{
  JSR set_hud_colors

  LDA.w !draygon_begin_hud_drawing_irq_command
  LDY !begin_hud_drawing_v_counter_target
  LDX !begin_hud_drawing_h_counter_target
  RTS
}

draygon_end_hud_colors_handler:
{
  JSR restore_green_door_colors

  LDA !draygon_end_hud_drawing_irq_command
  LDY !end_hud_drawing_v_counter_target
  LDX !end_hud_drawing_h_counter_target
  RTS
}

vert_transition_begin_hud_colors_handler:
{
  JSR set_hud_colors

  LDA.w !vert_transition_begin_hud_drawing_irq_command
  LDY !begin_hud_drawing_v_counter_target
  LDX !begin_hud_drawing_h_counter_target
  RTS
}

vert_transition_end_hud_colors_handler:
{
  JSR restore_green_door_colors

  LDA !vert_transition_end_hud_drawing_irq_command
  LDY !end_hud_drawing_v_counter_target
  LDX !end_hud_drawing_h_counter_target
  RTS
}

horiz_transition_begin_hud_colors_handler:
{
  JSR set_hud_colors

  LDA.w !horiz_transition_begin_hud_drawing_irq_command
  LDY !begin_hud_drawing_v_counter_target
  LDX !begin_hud_drawing_h_counter_target
  RTS
}

horiz_transition_end_hud_colors_handler:
{
  JSR restore_green_door_colors

  LDA !horiz_transition_end_hud_drawing_irq_command
  LDY !end_hud_drawing_v_counter_target
  LDX !end_hud_drawing_h_counter_target
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
  SEP #$20
  STZ $4300 ; mode 0 (register write once)
  LDY !hud_selected_item_palette_pointer
  STY $4302 ; source addr
  LDA #$80
  STA $4304 ; source bank
  LDY #$0006
  STY $4305 ; size
  LDA #$22
  STA $4301 ; dest (CGRAM)
  LDA #$11
  STA $2121 ; CGRAM address
  LDA #$01
  STA $420B ; execute DMA
  REP #$20
  RTS
}

restore_green_door_colors:
{
  SEP #$20
  STZ $4300 ; mode 0 (register write once)
  LDY.w #hud_selected_item_palette+$02
  STY $4302 ; source addr
  LDA #$80
  STA $4304 ; source bank
  LDY #$0006
  STY $4305 ; size
  LDA #$22
  STA $4301 ; dest (CGRAM)
  LDA #$11
  STA $2121 ; CGRAM address
  LDA #$01
  STA $420B ; execute DMA
  REP #$20
  RTS
}

store_hud_item_index:
{
  STA $0A0E
  ASL
  ASL
  ASL
  STA !hud_selected_item_palette_index

  CLC
  ADC.w #hud_selected_item_palette+$02
  STA !hud_selected_item_palette_pointer

  RTS
}

%END_FREESPACE(80)
