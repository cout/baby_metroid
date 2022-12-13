; TODO:
;
; * Need to make it possible to spark through the rippers somehow
; * Is there a block type that we can spark through but that we can't
;   fall through?  Probably would need a PLM.

org $C684EE

incbin "red_tower.bin"

org $A19452 ; red tower population

; Replace the (annoying) geegas with a statue
skip 16
skip 16
skip 16
skip 16
skip 16
skip 16
skip 16
skip 16
dw !samus_statue, $0078, $099C, $0000, $2400, $0000, $0002, $0005
dw $FFFF
db $0A

org $B483F1 ; red tower enemy graphics set

skip 4
skip 4
dw !samus_statue, $0003
dw $FFFF
db $00
