!POWER_CONTROL_LEFT_BLOCK_BTS = $13
!POWER_CONTROL_RIGHT_BLOCK_BTS = $14

org !FREESPACE_84

power_control_plm_instruction_list:
{
.top:
	dw $8A24, .linked ; Link instruction

	; TODO - ideally this should not be animated
.start:
	dw $0006, $9F6D   ; Change block to 80C4 (dark)
	dw $0006, $9F79   ; Change block to 80C5 (med)
	dw $0006, $9F85   ; Change block to 80C6 (bright)
	dw $8724, .start  ; Goto start

.linked:
	dw $874E : db $10     ; Timer = 10h

.loop:
	dw $0002, $9F6D   ; Change block to 80C4 (dark)
	dw $0002, $9F79   ; Change block to 80C5 (med)
	dw $0002, $9F85   ; Change block to 80C6 (bright)
	dw $873F, .loop   ; Decrement timer and go to $ADDD if non-zero

.end:
	dw $8724, .top    ; Go to $ADC2
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

power_control_activate_instruction: ; $8CAF
{
	PHX
	PHY

	; TODO - decrement Y for 10 frames at least

	JSR toggle_boss_bit

	; Display message box (TODO: remove)
	LDA #$0015
	JSL $858080

	; unlock samus
	LDA #$0001
	JSL $90F084

	PLY
	PLX
	RTS
}

toggle_boss_bit:
{
	LDX $079F
	LDA $7ED828,x
	AND #$0001
	BNE .clear_boss_bit

.set_boss_bit:
	; TODO - set a bit to hide phantoon
	; TODO - reload the room tiles?
	LDA $7ED828,x
	ORA #$0001
	STA $7ED828,x
	RTS

.clear_boss_bit:
	; TODO - set a bit to unhide phantoon
	; TODO - reload the room tiles?
	LDA $7ED828,x
	AND #$FFFE
	STA $7ED828,x
	RTS

}

power_control_left_instruction_list:
{
 dw $8C10 : db $37  ; Play station engaged sound
 dw $0006, $9FC1    ; Change block to B0C3 (special, inactive)
 dw $0060, $9FC7    ; Change block to 80C1 (solid, active)
 dw power_control_activate_instruction
 dw $0006, $9FC7    ; Change block to 80C1 (solid, active)
 dw $8C10 : db $38  ; Play station disengaged sound
 dw $0006, $9FC7    ; Change block to 80C1 (solid, active)
 dw $0006, $9FC1    ; Change block to B0C3 (special, inactive)
 dw $86BC           ; Delete
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
	dw $8C10 : db $37  ; Play station engaged sound
	dw $0006, $9FB5    ; Change block to B4C3 (special, inactive)
	dw $0060, $9FBB    ; Change block to 84C1 (solid, active)
	dw power_control_activate_instruction
	dw $0006, $9FBB    ; Change block to 84C1 (solid, active)
	dw $8C10 : db $38  ; Play station disengaged sound
	dw $0006, $9FBB    ; Change block to 84C1 (solid, active)
	dw $0006, $9FB5    ; Change block to B4C3 (special, inactive)
	dw $86BC           ; Delete
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
