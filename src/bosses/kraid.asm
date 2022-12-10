;;
; Disable Kraid spitting rocks

org $A7BC14 ; jsr for spawn rock projectile

BRA .earthquake_sound

org $A7BC1B

.earthquake_sound:
