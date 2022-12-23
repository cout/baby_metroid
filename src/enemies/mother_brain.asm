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

org $A9B127
JMP $B1BE

;;
; Disable time bomb text
;

org $A9B21C
LDA #$B2F9 ; TODO - this skips "Load exploded escape door particles tiles"

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

; TODO - diagnose baby graphical glitch by pointing various state
; changes here to find out which one causes the glitch
mother_brain_null_state = $A9B345

org !FREESPACE_A9

mother_brain_state_disable_earthquake:
{
  ; Disable earthquake timer
  LDA #$0000
  STA $1840

  ; Queue elevator music track
  LDA #$0003
  JSL $808FC1

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
