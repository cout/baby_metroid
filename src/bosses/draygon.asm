!SAMUS_HOLD_X = #$01C9
!SAMUS_HOLD_Y = #$016D

org $A586DD : LDA.w #draygon_state_initial

org !FREESPACE_A5

draygon_state_initial:
{
  ; TODO - spawn gunk at Samus's position

  LDA !SAMUS_HOLD_X
  STA $0AF6

  LDA $0AFA
  CLC
  ADC #$0001
  STA $0AFA
  CMP #$016D
  BMI .return

  LDA.w #draygon_state_samus_struggles
  STA $0FA8,x

  LDA #$0080
  STA $0FAA,x

.return:
  RTS
}

draygon_state_samus_struggles:
{
	JSR draygon_hold_samus

  LDA $0FAA,x
  DEC
  STA $0FAA,x
  BPL .return

	; Disable Samus movement
	LDA #$0000
  JSL $90F084

  LDA.w #draygon_state_scroll_screen_left
  STA $0FA8,x

.return:
  RTS
}

draygon_state_scroll_screen_left:
{
	JSR draygon_hold_samus

	DEC $0911
	BNE .return

  LDA.w #draygon_state_draygon_arrives
  STA $0FA8,x

  LDA #$FF60
  STA $0F7A,x

  ; LDA #$FFB0
  LDA #$0060
  STA $0F7E,x

  LDA #$97D1
  STA $0F92,x

  LDA #$0001
  STA $0F94,x

  LDA #$0001
  STA $7E8000

.return:
  RTS
}

draygon_state_draygon_arrives:
{
  LDA $0F7A,x
  CLC
  ADC #$0001
  STA $0F7A,x

  LDA $0F7E,x
  CLC
  ADC #$0001
  STA $0F7E,x

  CMP #$0170
  BMI .return

  LDA.w #draygon_state_player_control
  STA $0FA8,x

.return:
	RTS
}

draygon_state_player_control:
{
  ; Copy controller 1 input to controller 2 input
  ; TODO - Filter out the angle buttons
  ; TODO - Follow Draygon with the camera
  LDA $008B : STA $008D
  LDA $008F : STA $0091

  JSL $A59367

  ; TODO - Check to see if Draygon "rescued" Samus

  RTS
}

draygon_hold_samus:
{
  LDA !SAMUS_HOLD_X : STA $0AF6 ; samus x
  LDA !SAMUS_HOLD_Y : STA $0AFA ; samus y
	RTS
}

end_draygon_freespace_a5:
!FREESPACE_A5 = end_draygon_freespace_a5
