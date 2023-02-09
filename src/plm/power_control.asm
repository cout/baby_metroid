!POWER_CONTROL_LEFT_BLOCK_BTS = $13
!POWER_CONTROL_RIGHT_BLOCK_BTS = $14

!POWER_CONTROL_INACTIVE_LEFT_BLOCK = $1AB
!POWER_CONTROL_INACTIVE_RIGHT_BLOCK = $1AA
!POWER_CONTROL_ACTIVE_LEFT_BLOCK = $18F
!POWER_CONTROL_ACTIVE_RIGHT_BLOCK = $18C

%BEGIN_FREESPACE(84)

; TODO - Move these instructions to another file so they can be used in other
; PLMs

I_sleep = $8486B4
I_goto = $848724
I_set_timer = $84874E
I_dec_timer = $84873F
I_link = $848A24
I_queue_sound_2 = $848C10
I_delete = $8486BC

function I_animate(x) = x

D_inactive_left:
{
  dw $0001, $B000|!POWER_CONTROL_INACTIVE_LEFT_BLOCK
  dw $0000
}

D_inactive_right:
{
  dw $0001, $B000|!POWER_CONTROL_INACTIVE_RIGHT_BLOCK
  dw $0000
}

D_active_left:
{
  dw $0001, $8000|!POWER_CONTROL_ACTIVE_LEFT_BLOCK
  dw $0000
}

D_active_right:
{
  dw $0001, $8000|!POWER_CONTROL_ACTIVE_RIGHT_BLOCK
  dw $0000
}

D_inactive:
{
  dw $0001, $815B
  dw $0000
}

D_active_0:
{
  dw $0001, $815B
  db $00, $FF
  dw $0001, $81CA
  db $01, $FF
  dw $0001, $81CB
  db $00, $01
  dw $0001, $817C
  db $01, $01
  dw $0001, $817D
  db $00, $02
  dw $0001, $815C
  db $01, $02
  dw $0001, $815D
  dw $0000
}

D_active_1:
{
  dw $0001, $815B
  db $00, $FF
  dw $0001, $85CB
  db $01, $FF
  dw $0001, $85CA
  db $00, $01
  dw $0001, $815C
  db $01, $01
  dw $0001, $815D
  db $00, $02
  dw $0001, $817C
  db $01, $02
  dw $0001, $817D
  dw $0000
}

power_control_plm_instruction_list:
{
.top:
  dw I_link, .linked ; Link instruction

  dw I_sleep

.linked:
  dw I_set_timer : db $06

  ; While the station is activated, make it blink
.loop:
  dw I_animate(2), D_active_1
  dw I_animate(2), D_active_0
  dw I_dec_timer, .loop

.end:
  dw I_goto, .top
}

I_branch_if_power_on:
{
  ; Check the boss flag
  PHX
  LDX $079F
  LDA $7ED828,x
  PLX
  AND #$0001
  BNE .power_is_on

.power_is_off:
  INY
  INY
  RTS

.power_is_on:
  LDA $0000,y
  TAY
  RTS

}

power_control_plm_setup:
{
  ; Make PLM block solid
  LDX $1C87,y
  LDA $7F0002,x
  AND #$0FFF
  ORA #$8000
  STA $7F0002,x

  ; Make the block two blocks to the right a power control left access
  LDX $1C87,y
  INX
  INX
  INX
  INX
  LDA.w #$B000|!POWER_CONTROL_RIGHT_BLOCK_BTS
  JSR $82B4 ; write level data block type and BTS

  ; Make the block to the left a power control right access
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
  dw I_queue_sound_2 : db $37      ; Play station engaged sound
  dw I_animate(6), D_inactive_left ; Change block to special/inactivate
  dw I_animate(60), D_active_left  ; Change block to solid/active
  dw I_activate_power_control
  dw I_animate(6), D_active_left   ; Change block to solid/active
  dw I_queue_sound_2 : db $38      ; Play station disengaged sound
  dw I_animate(6), D_active_left   ; Change block to solid/active
  dw I_animate(6), D_inactive_left ; Change block to special/inactive
  dw I_delete                      ; Delete
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
  dw I_queue_sound_2 : db $37       ; Play station engaged sound
  dw I_animate(6), D_inactive_right ; Change block to special/inactive
  dw I_animate(60), D_active_right  ; Change block to solid/active
  dw I_activate_power_control
  dw I_animate(6), D_active_right   ; Change block to solid/active
  dw I_queue_sound_2 : db $38       ; Play station disengaged sound
  dw I_animate(6), D_active_right   ; Change block to solid/active
  dw I_animate(6), D_inactive_right ; Change block to special/inactive
  dw I_delete                       ; Delete
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

  ; Activate station two blocks to the left
  LDA $1C87,y
  DEC A
  DEC A
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

%END_FREESPACE(84)

org $949139+(2*!POWER_CONTROL_LEFT_BLOCK_BTS)  : dw power_control_left_plm  ; special air/block collision
org $949139+(2*!POWER_CONTROL_RIGHT_BLOCK_BTS) : dw power_control_right_plm ; special air/block collision
