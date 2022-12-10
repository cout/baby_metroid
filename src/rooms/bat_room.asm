;;
; Replace bats with rippers (to ride across)
;

org $A1A110

; dw $DB7F, $0148, $003C, $0000, $2000, $0000, $0000, $0000
; dw $DB7F, $0170, $003C, $0000, $2000, $0000, $0000, $0000

; This kzan drives Samus into the ground.  Scary.
; dw $DFFF, $0020, $006C, $0000, $A000, $0000, $0040, $8070
; dw $E03F, $0020, $0074, $0000, $0100, $0000, $0000, $0000

dw $D47F, $0040, $0091, $0000, $2800, $0000, $0010, $0000
dw $D47F, $0060, $005A, $0000, $2800, $0000, $0020, $0000

dw $FFFF
db $02

org $B48671

dw $D47F, $0003
dw $CEBF, $0007
dw $FFFF
