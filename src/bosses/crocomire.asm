; TODO - if croc pushes samus during the fight, the screen does not scroll properly
; TODO - change initial palette to brown as if croc is dirty
; TODO - croc should move arms in the bath (he does, but not initially)
; TODO - put croc to sleep after the bath is over?
; TODO - croc hitbox should prevent samus from falling off the edge, but
; hitbox is getting deleted/shrunk/something

;;
; Keep Croc from retreating when shot
;

org $A487D5
LDY #$BBAE

org $A487E5
LDY #$BBAE

;;
; Keep Croc from pushing Samus into the wall
;

org $A49029
JSL move_croc_with_wall_check

org !FREESPACE_A4

move_croc_with_wall_check:
{
  LDA $0F7A
  CMP #$0280
  BPL +
  SEC
  RTL
+ JML $A0C6AB
}

end_move_croc_with_wall_check_freespace_a4:
!FREESPACE_A4 := end_move_croc_with_wall_check_freespace_a4

;;
; Disable croc fireball
;

org $A48797
JMP $87A5

;;
; Disable room shaking from croc stomping
;

org $A48FC7
RTL

;;
; Keep croc on screen after falling into water/acid
;

org $A491D4
{
  ; Keep sinking croc until he reaches the bottom of the bath
  LDA $0F7E,x
  CMP #$0AB
  BMI sink_crocomire

  ; Clear invisible wall and unlock camera
  JSR $90B7

  ; Next state is 3Eh
  LDA #$003E
  STA $0FA8,x

  RTS
}

warnpc $A491E9

sink_crocomire = $A491E9

;;
; Keep Croc's tongue alive
;

; Keep tongue visible
org $A48EBC
JMP $8ED1

; Prevent tongue from being deleted
org $A490CA
JMP $90D0

org $A48

; TODO - I don't know if this does anything (it prevents tongue
; properties from being changed and prevents the instruction list from
; changing)
org $A49365
JMP $937D

;;
; Change Crocomire death sequence
;

org $A497D3 ; state 3Eh

crocomire_state_wait_for_samus_to_visit_spike_wall:
{
  REP #$20

  JSR crocomire_bath

  LDA $0AF6
  CMP #$0280
  BPL .return
  BRA .next_state

.next_state:
  ; Set Crocomire to have non-solid hitbox and intangible
  LDA $0F86
  AND #$7FFF
  ORA #$0400
  STA $0F86

  ; Prevent croc from stomping backward out of the bath
  LDA #$0004
  STA $0FAE
  STZ $0FEE
  LDA #$000A
  STA $102E
  LDA #$0001
  STA $106E
  STZ $0FAA
  LDA #$0038

  ; Set Crocomire collision height to 56
  STA $0F84

  LDA #$0042
  STA $0FA8

.return:
  RTS
}

org $A4990A ; state 42h

crocomire_state_start_spike_wall_falling:
{
  ; Initialize counters for wall falling state
  STZ $0FB0
  STZ $0FB2

  ; Clear invisible wall
  JSL $8483D7
  dw $0320, $B753

  ; Play wall exploding sound
  LDA #$0029
  JSL $8090CB

  ; Set Crocomire palette to 0 - this is used by the falling wall effect
  LDA #$0000
  STA $0F96

  ; Copy falling wall palette to enemy palette 0
  LDX #$001E
.loop:
  LDA $B8FD,x
  STA $7EC120,x
  DEX
  DEX
  BPL .loop

  ; Clear enemy projectiles
  JSL $868016

  ; Spawn projectiles for spike wall pieces
  LDA #$0008
  STA $12
.loop2:
  LDX $0E54
  LDY #$90C1
  JSL $868027
  DEC $12
  BNE .loop2

  ; Play wall destroyed sound
  LDA #$0030
  JSL $8090CB

  ; Clear scroll lock
  LDA #$0101
  STA $7ECD20
  STA $7ECD22

  LDA #$0046
  STA $0FA8
  RTS
}
warnpc $A499CB

org $A49A38 ; state 46h
{
  JSR crocomire_bath

  ; TODO - this is supposed to function as a delay (I think), but since
  ; we are missing state 44h, the delay is too short.

  LDA $0FB0
  CLC
  ADC #$0800
  STA $0FB0

  LDA $0FB2
  ADC #$0000
  CMP #$0005
  BMI .label1
  LDA #$0005

.label1:
  STA $0FB2

  ; Play explosion sound
  LDA #$0025
  JSL $8090CB

  ; Restore croc palette
  LDA #$0E00
  STA $0F96

  ; Restore movement to Croc legs/arms
  LDA #$BADE
  STA $0F92
  LDA #$0001
  STA $0F94

  JMP $9B06

.return:
  RTS
}

org $A49B06 ; state 48h
{
  JSR crocomire_bath

  ; Spawn drops
  JSL $A0B9D8

  ; Restore camera distance index to normal
  STZ $0941

  ; Set Crocomire as dead
  LDX $079F
  LDA $7ED828,x
  ORA #$0002
  STA $7ED828,x

  ; Spawn dust cloud/explosion
  LDA #$FFF0
  JSL $A49ADA
  LDA #$0010
  JSL $A49ADA

  ; Advance to final state
  LDA #$0050
  STA $0FA8

  RTS
}
warnpc $A49B65

org $A49B86 ; state 50h
{
  JSR crocomire_bath

  RTS
}

advance_to_next_state_and_return = $A49BB3

;;
; Crocomire bath play routine
;

org $A49099 ; state 3Ch (now unused)

crocomire_bath:
{
  ; TODO - there is a slight delay in adjusting croc after Samus moves

  ; Create smoke from acid bath
  JSR $916C

  ; Keep the body positioned
  LDX $0E54
  JSL $A48B5B

  ; Keep croc's tongue aligned with croc?
  LDA $0F7A
  CLC
  ADC $0FA8+$40
  STA $0F7A+$40
  LDA $0F7E
  STA $0F7E+$40

  RTS
}

;;
; Add the ability to push croc
;

org $A48C95

crocomire_check_for_collision_with_samus:
{
  ; Skip collision checking during death sequence
  LDA $0FA8
  BNE .return

  ; Check for collsion with croc.  The CLC here is intentional.
  LDA $0F7A
  SEC
  SBC $0F82
  SBC $0AFE
  SBC $0AF6
  SBC #$0003
  BPL .return

  ; Execute normal enemy touch AI
  JSL $A0A477

  ; Move croc back 1 pixel if there is a collision
  ; TODO - this is not as smooth as I would like
  LDA $0F7A
  CLC
  ADC #$0001
  STA $0F7A

.return:
  RTS
}

warnpc $A48CCB

;;
; Don't draw skull when reentering the room after Croc is defeated
;

org $A4E1CC
dw $812F
