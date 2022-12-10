;;
; Disable Kraid spitting rocks
;

org $A7BC14 ; jsr for spawn rock projectile

BRA .earthquake_sound

org $A7BC1B

.earthquake_sound:

;;
; Disable lunging
;

org $A786F3 ; walk forward

dw $B633, $812F

org $A787BD ; lunge forward

dw $B633, $812F

org $A78887 ; walk backward

dw $B633, $812F

;;
; Play elevator music instead of boss music
;

org $A7C8AF

LDA #$0003

;;
; Clear the spikes and unfix the camera
;

org $A7A9E7

JSR $C171

;;
; Replace Kraid roar with a less intimidating sound
;

org $A7AF95

LDA #$0060
