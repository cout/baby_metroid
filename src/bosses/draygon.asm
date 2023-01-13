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

  ; TODO - prevent Draygon from straying off screen

  JSR draygon_set_samus_drawing_handler

  LDA draygon_holding_samus
  BEQ .return

  JSR draygon_move_samus
  JSR draygon_force_hug_pose

  ; TODO - set samus pose

.return:
  RTS
}

draygon_debug_handler = $A59367
draygon_move_samus = $A594A9

draygon_force_hug_pose:
{
  LDA $7E8000,x
  BNE .facing_right

.facing_left:
  LDA $1052
  CMP #$9845
  BMI .force_hug_left
  CMP #$9867
  BPL .force_hug_left
  BRA .return

.force_hug_left:
  LDA #$9861
  STA $1052

  LDA #$0001
  STA $1054

  BRA .return

.facing_right:
  LDA $1052
  CMP #$9C38
  BMI .force_hug_right
  CMP #$9C5A
  BPL .force_hug_right
  BRA .return

.force_hug_right:
  LDA #$9C54
  STA $1052

  LDA #$0001
  STA $1054

.return:
  RTS
}

draygon_state_wait_for_samus_to_fall:
{
  LDA $0AFA
  CMP #$01B0
  BMI .return

  LDA.w #draygon_state_chill
  STA $0FA8,x

  ; Set boss bit
  LDA #$0001
  JSL $8081A6

  ; Set Draygon as intangible
  LDA $0F86,x
  ORA #$0400
  STA $0F86,x

  ; Drop items
  JSL $A0BB3D

.return:
  RTS
}

draygon_state_chill:
{
  RTS
}

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
  LDA draygon_holding_samus
  BEQ .not_holding_samus
  ; TODO - if we attempt a hug while holding Samus, then draygon should
  ; put Samus down

.holding_samus:
  ; Zero-out Samus's fall speed
  STZ $0B2C
  STZ $0B2E

  ; Enable Samus movement
  LDA #$0001
  JSL $90F084

  LDA.w #draygon_state_wait_for_samus_to_fall
  STA $0FA8,x

.not_holding_samus:
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
  LDY #$9825    ; hug, facing left, automatically return to normal pose
  LDA $7E8000,x
  BEQ +
  LDY #$9C18    ; hug, facing right, automatically return to normal pose
+ STY $1052

  ; Set instruction timer for arms
  LDA #$0001
  STA $1054

  BRA .return

.collision:

  ; Choose instruction list for arms based on which direction Draygon is
  ; facing
  LDY #$9845    ; hug, facing left, stay in hug pose
  LDA $7E8000,x
  BEQ +
  LDY #$9C38    ; hug, facing right, stay in hug pose
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
