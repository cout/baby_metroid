!POWER_CONTROL_LEFT_BLOCK_BTS = $13
!POWER_CONTROL_RIGHT_BLOCK_BTS = $14

org !FREESPACE_84

; TODO - Move these instructions to another file so they can be used in other
; PLMs

I_goto = $848724
I_set_timer = $84874E
I_dec_timer = $84873F
I_link = $848A24
I_queue_sound_2 = $848C10
I_delete = $8486BC

function I_animate(x) = x

dark_block = $8F9F6D
med_block = $8F9F79
bright_block = $8F9F85

power_control_plm_instruction_list:
{
.top:
  dw I_link, .linked ; Link instruction

  ; TODO - ideally this should not be animated
.start:
  dw I_animate(6), $9F6D   ; Change block to 80C4 (dark)
  dw I_animate(6), $9F79   ; Change block to 80C5 (med)
  dw I_animate(6), $9F85   ; Change block to 80C6 (bright)
  dw I_goto, .start        ; Goto start

.linked:
  dw I_set_timer : db $10  ; Timer = 10h

.loop:
  dw I_animate(2), $9F6D   ; Change block to 80C4 (dark)
  dw I_animate(2), $9F79   ; Change block to 80C5 (med)
  dw I_animate(2), $9F85   ; Change block to 80C6 (bright)
  dw I_dec_timer, .loop    ; Decrement timer and go to $ADDD if non-zero

.end:
  dw I_goto, .top
}

power_control_plm_setup:
{
  ; Make PLM block solid
  LDX $1C87,y
  LDA $7F0002,x
  AND #$0FFF
  ORA #$8000
  STA $7F0002,x

  ; Make the block to the left a power control right access
  LDX $1C87,y
  INX
  INX
  LDA.w #$B000|!POWER_CONTROL_RIGHT_BLOCK_BTS
  JSR $82B4 ; write level data block type and BTS

  ; Make the block to the left a power control left access
  LDX $1C87,y
  DEX
  DEX
  LDA.w #$B000|!POWER_CONTROL_LEFT_BLOCK_BTS
  JSR $82B4 ; write level data block type and BTS

  RTS
}

power_control_plm:
{
  dw power_control_plm_setup
  dw power_control_plm_instruction_list
}

I_activate_power_control: ; $8CAF
{
  PHX
  PHY

  JSR toggle_power

  ; unlock samus
  LDA #$0001
  JSL $90F084

  PLY
  PLX
  RTS
}

toggle_power:
{
  ; Check the boss bit
  LDX $079F
  LDA $7ED828,x
  AND #$0001
  BNE .turn_power_off

.turn_power_on:
  ; Set the boss bit
  LDA $7ED828,x
  ORA #$0001
  STA $7ED828,x

  LDA #$C2C2
  STA $07C7
  LDA #$B0E7
  STA $07C6
  JSR reload_palette

  RTS

.turn_power_off:
  ; Clear the boss bit
  LDA $7ED828,x
  AND #$FFFE
  STA $7ED828,x

  LDA #$C2C2
  STA $07C7
  LDA #$B1A6
  STA $07C6
  JSR reload_palette

  RTS
}

reload_palette:
{
  ; Decompress new room palette and write to actual palette
  ; TODO - I suppose it would be better to write to the target palette at
  ; 7E:C200 then copy from there to C000, but this works just fine.
  LDA $07C7
  STA $48
  LDA $07C6
  STA $47
  JSL $80B0FF
  dl $7EC000

  RTS
}

power_control_left_instruction_list:
{
  dw I_queue_sound_2 : db $37  ; Play station engaged sound
  dw I_animate(6), $9FC1       ; Change block to B0C3 (special, inactive)
  dw I_animate(60), $9FC7      ; Change block to 80C1 (solid, active)
  dw I_activate_power_control
  dw I_animate(6), $9FC7       ; Change block to 80C1 (solid, active)
  dw I_queue_sound_2 : db $38  ; Play station disengaged sound
  dw I_animate(6), $9FC7       ; Change block to 80C1 (solid, active)
  dw I_animate(6), $9FC1       ; Change block to B0C3 (special, inactive)
  dw I_delete                  ; Delete
}

power_control_left_setup:
{
  ; Delete PLM unless collision direction is right
  LDA $0B02
  AND #$000F
  CMP #$0001
  BNE .delete

  ; Delete PLM unless Samus pose is facing right and ran into a wall
  LDA $0A1C
  CMP #$0089
  BNE .delete

  ; Delete PLM unless Samus is facing right
  LDA $0A1E
  AND #$0008
  BEQ .delete

  ; Activate station to the right
  LDA $1C87,y
  INC A
  INC A
  JMP activate_station

.delete:
  ; Delete PLM
  LDA #$0000
  STA $1C37,y
  SEC
  RTS
}

power_control_left_plm:
{
  dw power_control_left_setup
  dw power_control_left_instruction_list
}

power_control_right_instruction_list:
{
  dw I_queue_sound_2 : db $37  ; Play station engaged sound
  dw I_animate(6), $9FB5       ; Change block to B4C3 (special, inactive)
  dw I_animate(60), $9FBB      ; Change block to 84C1 (solid, active)
  dw I_activate_power_control
  dw I_animate(6), $9FBB       ; Change block to 84C1 (solid, active)
  dw I_queue_sound_2 : db $38  ; Play station disengaged sound
  dw I_animate(6), $9FBB       ; Change block to 84C1 (solid, active)
  dw I_animate(6), $9FB5       ; Change block to B4C3 (special, inactive)
  dw I_delete                  ; Delete
}

power_control_right_setup:
{
  ; Delete PLM unless collision direction is left
  LDA $0B02
  AND #$000F
  BNE .delete

  ; Delete PLM unless Samus pose is facing left and ran into a wall
  LDA $0A1C
  CMP #$008A
  BNE .delete

  ; Delete PLM unless Samus is facing left
  LDA $0A1E
  AND #$0004
  BEQ .delete

  ; Activate station to the left
  LDA $1C87,y
  DEC A
  DEC A
  JMP activate_station

.delete:
  ; Delete PLM
  LDA #$0000
  STA $1C37,y
  SEC
  RTS
}

power_control_right_plm:
{
  dw power_control_right_setup
  dw power_control_right_instruction_list
}

activate_station = $84B146

end_power_control_plm_freespace_84:
!FREESPACE_84 := end_power_control_plm_freespace_84

org $949139+(2*!POWER_CONTROL_LEFT_BLOCK_BTS)  : dw power_control_left_plm  ; special air/block collision
org $949139+(2*!POWER_CONTROL_RIGHT_BLOCK_BTS) : dw power_control_right_plm ; special air/block collision
