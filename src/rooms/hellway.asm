incbin "hellway.bin" -> $C69D70

org $838370 ; Room $A2F7 FX

dw $0000 ; door pointer
dw $00C0 ; base Y position
dw $FFFF ; target Y position
dw $0000 ; Y velocity
db $00   ; timer
db $0C   ; type fog (I like it as water, but it is hard to jump out of)
db $02   ; fx A
db $18   ; fx B
db $01   ; fx C
db $02   ; palette fx bitset
db $06   ; animated tiles bitset
db $48   ; palette blend
