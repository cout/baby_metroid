org $C8BB21
incbin "bat_cave.bin"
warnpc $C8C121

;;
; Replace the skrees with a statue
;

org $A1B912 ; bat cave enemy pop

skip 16 ; gamet
skip 16 ; gamet
skip 16 ; gamet
skip 16 ; gamet
skip 16 ; gamet

;                    x      y   init  props   xtra     p1     p2
dw !samus_statue, $00A0, $0194, $0000, $2400, $0000, $0000, $0002
dw $FFFF
db $00

org $B48ACD ; bat cave graphics set

skip 4 ; gamet
dw !samus_statue, $0002, $FFFF
