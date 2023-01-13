!SAMUS_STUCK_X = #$01C9
!SAMUS_STUCK_Y = #$016D

org !FREEMEM_7F

; TODO - ideally these should use the current enemy index but this is
; fine since there will only ever be one draygon

draygon_previous_x_position:
print "Variable draygon_previous_x_position: $", pc
skip 2

draygon_previous_x_sub_position:
print "Variable draygon_previous_x_sub_position: $", pc
skip 2

draygon_previous_y_position:
print "Variable draygon_previous_y_position: $", pc
skip 2

draygon_previous_y_sub_position:
print "Variable draygon_previous_y_sub_position: $", pc
skip 2

draygon_holding_samus:
print "Variable draygon_holding_samus: $", pc
skip 2

end_draygon_freemem_7f:
!FREEMEM_7F := end_draygon_freemem_7f

org $A586DD : LDA.w #draygon_state_initial

org $A593BD : JMP draygon_big_hug

org !FREESPACE_A5

draygon_state_initial:
{
  ; TODO - spawn gunk at Samus's position

  LDA #$0000
  STA draygon_holding_samus

  LDA !SAMUS_STUCK_X
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
  JSR draygon_keep_samus_stuck

  LDA $0FAA,x
  DEC
  STA $0FAA,x
  BPL .return

  ; Force falling position, facing left
  LDA #$002A : STA $0A1C ; pose
  LDA #$0001 : STA $0A96 ; animation frame

  ; Set Samus radius by invoking the normal movement handler for the
  ; last time (it will not be called again due to disabling Samus
  ; movement)
  ; TODO - for a better effect, we should still see Samus struggling
  ; after taking control away from the player
  PHX
  JSL $90E695
  PLX

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
  JSR draygon_keep_samus_stuck

  DEC $0911
  BNE .return

  LDA.w #draygon_state_draygon_arrives
  STA $0FA8,x

  ; Initial X position
  LDA #$FF60
  STA $0F7A,x

  ; Initial Y position
  LDA #$0060
  STA $0F7E,x

  ; Draygon facing right (instruction list)
  LDA #$97D1
  STA $0F92,x

  LDA #$0001
  STA $0F94,x

  ; Flag for draygon facing right?
  ; (probably not necessary)
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

  LDA $0F7A,x : STA draygon_previous_x_position
  LDA $0F7C,x : STA draygon_previous_x_sub_position
  LDA $0F7E,x : STA draygon_previous_y_position
  LDA $0F8A,x : STA draygon_previous_y_sub_position

  LDA.w #draygon_state_player_control
  STA $0FA8,x

.return:
  RTS
}

draygon_state_player_control:
{
  ; Copy controller 1 input to controller 2 input
  ; We filter out L/R/Start, because these buttons trigger debug
  ; features that we don't want.
  LDA $008B : AND #$EFCF : STA $008D
  LDA $008F : AND #$EFCF : STA $0091

  JSL draygon_debug_handler

  JSR draygon_scroll_screen

  JSL draygon_pause_check

  ; TODO - if draygon moves and is holding samus, the arm instruction
  ; list pointer should not change

  ; TODO - there is a graphical glitch with Draygon's eye after blinking

  ; TODO - Draygon's eye ends up on its back if it crouches while firing
  ; (and facing right -- though it might be possible to trigger this
  ; while facing left too)

  JSR draygon_set_samus_drawing_handler

  LDA draygon_holding_samus
  BEQ .return
  JSR draygon_move_samus
  ; TODO - set samus pose

.return:
  RTS
}

draygon_debug_handler = $A59367
draygon_move_samus = $A594A9

draygon_scroll_screen:
{
  LDA $0AF6 : PHA
  LDA $0AF8 : PHA
  LDA $0AFA : PHA
  LDA $0AFC : PHA
  LDA $0B10 : PHA
  LDA $0B12 : PHA
  LDA $0B14 : PHA
  LDA $0B16 : PHA

  LDA $0F7A,x : CLC : ADC #$0020 : STA $0AF6
  LDA $0F7C,x : STA $0AF8
  LDA $0F7E,x : STA $0AFA
  LDA $0F8A,x : STA $0AFC
  LDA draygon_previous_x_position     : STA $0B10
  LDA draygon_previous_x_sub_position : STA $0B12
  LDA draygon_previous_y_position     : STA $0B14
  LDA draygon_previous_y_sub_position : STA $0B16

  JSL $9094EC

  LDA $0B10 : STA draygon_previous_x_position
  LDA $0B12 : STA draygon_previous_x_sub_position
  LDA $0B14 : STA draygon_previous_y_position
  LDA $0B16 : STA draygon_previous_y_sub_position

  PLA : STA $0B16
  PLA : STA $0B14
  PLA : STA $0B12
  PLA : STA $0B10
  PLA : STA $0AFC
  PLA : STA $0AFA
  PLA : STA $0AF8
  PLA : STA $0AF6

  RTS
}

draygon_keep_samus_stuck:
{
  PHX

  JSL cancel_blue_suit

  LDA !SAMUS_STUCK_X : STA $0AF6 ; samus x
  LDA !SAMUS_STUCK_Y : STA $0AFA ; samus y

  JSR draygon_set_samus_drawing_handler

  PLX
  RTS
}


draygon_set_samus_drawing_handler:
{
  LDA $0AFA

  SEC
  SBC $0915
  STA $7FFC02
  BMI .samus_off_screen

  CMP #$0100
  BPL .samus_off_screen

.samus_on_screen:
  ; use default drawing handler
  LDA #$EB52
  STA $7FFC00
  BRA .store_drawing_handler

.samus_off_screen:
  ; use null drawing handler
  LDA #$EBF2
  STA $7FFC00

.store_drawing_handler:
  STA $0A5C

.return:
  STA $0A5C
  RTS
}

draygon_big_hug:
{
  ; TODO - if we attempt a hug while holding Samus, then draygon should
  ; put Samus down

  LDA $0F7A
  SEC
  SBC $0AF6
  JSL $A0B067
  CMP #$0020
  BPL .no_collision
  LDA $0F7E
  SEC
  SBC $0AFA
  JSL $A0B067
  CMP #$0020
  BPL .no_collision
  BRA .collision

.no_collision:

  ; Choose instruction list for arms based on which direction Draygon is
  ; facing
  LDY #$9825
  LDA $7E8000,x
  BEQ +
  LDY #$9C18
+ STY $1052

  ; Set instruction timer for arms
  LDA #$0001
  STA $1054

  BRA .return

.collision:

  ; Choose instruction list for arms based on which direction Draygon is
  ; facing
  LDY #$9845
  LDA $7E8000,x
  BEQ +
  LDY #$9C38
+ STY $1052

  ; Set instruction timer for arms
  LDA #$0001
  STA $1054

  LDA #$0001
  STA draygon_holding_samus

.return:
  RTL
}

end_draygon_freespace_a5:
!FREESPACE_A5 = end_draygon_freespace_a5

org !FREESPACE_90

draygon_pause_check:
{
  JSR $EA45
  RTL
}

end_draygon_freespace_90:
!FREESPACE_90 := end_draygon_freespace_90
