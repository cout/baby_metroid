incbin "speed_hallway.bin" -> $C7E08C

org $A1B88F ; enemy population

skip 16 ; geruda
skip 16 ; geruda
skip 16 ; geruda
skip 16 ; geruda
skip 16 ; geruda

;                    x      y   init  props   xtra     p1     p2
dw !samus_statue, $0100, $00D4, $0000, $2400, $0000, $0001, $0003
dw $FFFF
db $00

org $B48ABB ; enemy graphics set

skip 4 ; geruda
dw !samus_statue, $0002, $FFFF
