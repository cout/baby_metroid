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
