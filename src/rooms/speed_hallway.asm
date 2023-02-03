incbin "speed_hallway.bin" -> $C7E08C

org $A1B88F ; enemy population

skip 16 ; geruda
skip 16 ; geruda
skip 16 ; geruda
skip 16 ; geruda
skip 16 ; geruda

;                    x      y   init  props   xtra     p1     p2
dw !samus_statue, $0100, $00D4, $0000, $2400, $0000, $0000, $0103
dw $FFFF
db $00

org $B48ABB ; enemy graphics set

skip 4 ; geruda
dw !samus_statue, $0002, $FFFF

;;
; Limit how high the lava will rise
;

org $8385E0 ; Room $ACF0 state $ACFD FX

skip 4

dw $019A

;;
; Remove the red door to prevent softlock
;

org $8F8C6E+12
dw $0000
