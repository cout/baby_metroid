;;
; Disable MB turrets
;

org $A986F2
RTL

;;
; Skip phase 2
;

org $A98F3F
LDA #$BDD2

;;
; Don't put Samus into drained pose when baby latches
;

org $A9C849
RTS

;;
; Skip phase 3
;

org $A9C059
LDA #$AF54

;;
; Don't put Samus into drained pose when baby tries to heal
;

org $A9C977
JMP $C97E

;;
; Disable palette change (messes up baby graphics)
;

org $A9AF77
JMP $AF91

;;
; Skip head falling
;

org $A9B115

mother_brain_state_final_death_sequence:
{
  ; Stop drawing neck
  LDA #$87D0
  STA $0FE8

  ; Set Mother Brain as intangible/invisible and disable processing
  ; instructions
  LDA $0FC6
  ORA #$0500
  AND #$DFFF
  STA $0FC6

  ; Disable all Mother Brain hitboxes
  LDA #$0000
  STA $7E7808

  ; Clear Mother Brain extra properties
  STZ $0FC8

  ; Next state is $B211 (wait for timer)
  LDA #$B211
  STA $0FA8
  LDA #$0014
  STA $0FB2

  RTS
}

;;
; Disable time bomb text; queue elevator music
;

org $A9B21C
LDA #$B26D

org $A9B26D

mother_brain_state_start_escape_sequence:
{
  ; Load exploding door tiles
  LDX #$902F
  JSR $C5BE

  ; Return if not finished loading
  BCS .next_state
  RTS

.next_state:
  ; Set palette for exploding door
  LDY #$9534
  LDX #$0122
  LDA #$000E
  JSL $A9D2E4

  ; Queue elevator music track
  LDA #$0003
  JSL $808FC1

  ; Set earthquake type/timer
  LDA #$0005
  STA $183E
  LDA #$FFFF
  STA $1840

  ; Set room palette to flashing
  LDY #$FFC9 ; shutter
  JSL $8DC4E9
  LDY #$FFCD ; background
  JSL $8DC4E9
  LDY #$FFD1 ; level
  JSL $8DC4E9
  LDY #$FFD5 ; orbs
  JSL $8DC4E9

  ; Disable unpause hook
  LDA #$0000
  STA $7E7844

  LDA #$B2F9
  STA $0FA8

  RTS
}

;;
; Disable escape timer
;

org $A9B302
JMP $B30F

;;
; Disable escape explosions
;

org $A9B313
JMP $B31A

;;
; Disable earthquake
;

org $A9B33C

LDA.w #mother_brain_state_disable_earthquake
STA $0FA8
RTS

org !FREESPACE_A9

mother_brain_state_disable_earthquake:
{
  ; Disable earthquake timer
  LDA #$0000
  STA $1840

  LDA.w #mother_brain_state_final
  STA $0FA8

  RTS
}

mother_brain_state_final:
{
  RTS
}

end_mother_brain_freespace_a9:
!FREESPACE_A9 = end_mother_brain_freespace_a9
