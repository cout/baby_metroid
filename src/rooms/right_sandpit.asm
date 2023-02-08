; Room $D51E: Header
org $8FD51E
db $1E       ; Index
db $04       ; Area
db $17       ; X position on map
db $0E       ; Y position on map
db $02       ; Width (in screens)
db $02       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $D545     ; Door out
dw $E5E6     ; State $D52B function (default)

; Room $D51E state $D52B: Header
; (default)
org $8FD52B
dl $CBF580   ; Level data address
db $0C       ; Tileset
db $00       ; Music data index
db $00       ; Music track index
dw $9E84     ; FX address (bank $83)
dw $DF63     ; Enemy population offset (bank $A1)
dw $905E     ; Enemy graphics set offset (bank $B4)
dw $0000     ; Layer 2 scroll
dw $D549     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $C5EB     ; Room PLM list address (bank $8F)
dw $0000     ; Library background (bank $8F)
dw $C8D2     ; Room setup routine (bank $8F)

; Room $D51E state $D52B: Enemy population
org $A1DF63
;  enemy  x      y      init   props  extra  param1 param2
; dw $DFBF, $0190, $00A0, $0072, $2800, $0000, $0200, $7204 ; boulder
; dw $DFBF, $0150, $00C0, $0098, $2800, $0000, $0200, $A204 ; boulder
; dw $DFBF, $00D0, $00D0, $00C0, $2800, $0000, $0200, $A204 ; boulder
dw water_zoomer, $012E, $00AB, $0000, $2801, $0000, $0002, $0000
dw $FFFF     ; end of list
db $00       ; death quota

; Room $D51E state $D52B: Enemy graphics set
org $B4905E
;  enemy  palette
; dw $DFBF, $0001 ; boulder
dw water_zoomer, $0001
dw $FFFF     ; end of list

; Room $D51E state $D52B: FX
org $839E84
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $00D6, $FFFF, $0000 : db $00, $06, $02, $14, $03, $01, $0C, $EE
