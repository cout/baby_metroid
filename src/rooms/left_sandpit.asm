; Room $D4EF: Header
org $8FD4EF
db $1D       ; Index
db $04       ; Area
db $14       ; X position on map
db $0E       ; Y position on map
db $02       ; Width (in screens)
db $02       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $D516     ; Door out
dw $E5E6     ; State $D4FC function (default)

; Room $D4EF state $D4FC: Header
; (default)
org $8FD4FC
dl $CBEC32   ; Level data address
db $0C       ; Tileset
db $00       ; Music data index
db $00       ; Music track index
dw $9E74     ; FX address (bank $83)
dw $DF96     ; Enemy population offset (bank $A1)
dw $906C     ; Enemy graphics set offset (bank $B4)
dw $0000     ; Layer 2 scroll
dw $D51A     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $C5DD     ; Room PLM list address (bank $8F)
dw $0000     ; Library background (bank $8F)
dw $C8D2     ; Room setup routine (bank $8F)

; Room $D4EF state $D4FC: Enemy population
org $A1DF96
;  enemy  x      y      init   props  extra  param1 param2
; dw $DFBF, $01D0, $0090, $0050, $2800, $0000, $0200, $6204 ; boulder
; dw $DFBF, $00B0, $0140, $0080, $2800, $0000, $0200, $A004 ; boulder
; dw $DFBF, $00F0, $0160, $00F0, $2800, $0000, $0200, $F004 ; boulder
; dw $DFBF, $0030, $0090, $0040, $2800, $0000, $0200, $5204 ; boulder
dw water_zoomer, $0111, $00AB, $0000, $2801, $0000, $0002, $0000
dw $FFFF     ; end of list
db $00       ; death quota

; Room $D4EF state $D4FC: Enemy graphics set
org $B4906C
;  enemy  palette
; dw $DFBF, $0001 ; boulder
dw water_zoomer, $0001
dw $FFFF     ; end of list

; Room $D4EF state $D4FC: FX
org $839E74
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $00D6, $FFFF, $0000 : db $00, $06, $02, $14, $03, $01, $0C, $EE
