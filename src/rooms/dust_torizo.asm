; Room $DC65: Header
org $8FDC65
db $06       ; Index
db $05       ; Area
db $11       ; X position on map
db $0F       ; Y position on map
db $02       ; Width (in screens)
db $01       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $DCAB     ; Door out
dw $E612     ; State $DC91 function (event)
db $14       ; Event
dw $DC91     ; State header address
dw $E5E6     ; State $DC77 function (default)

; Room $DC65 state $DC77: Header
; (default)
org $8FDC77
dl $CDD7C4   ; Level data address
db $0D       ; Tileset
db $45       ; Music data index
db $06       ; Music track index
dw $A064     ; FX address (bank $83)
dw $E25B     ; Enemy population offset (bank $A1)
dw $90DE     ; Enemy graphics set offset (bank $B4)
dw $C1C1     ; Layer 2 scroll
dw $DCAF     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $C823     ; Room PLM list address (bank $8F)
dw $E41E     ; Library background (bank $8F)
dw $C91E     ; Room setup routine (bank $8F)

; Room $DC65 state $DC91: Header
; (event bit 14h)
org $8FDC91
dl $CDD7C4   ; Level data address
db $0D       ; Tileset
db $1E       ; Music data index
db $05       ; Music track index
dw $A064     ; FX address (bank $83)
dw $E25B     ; Enemy population offset (bank $A1)
dw $90DE     ; Enemy graphics set offset (bank $B4)
dw $C1C1     ; Layer 2 scroll
dw $DCAF     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $C823     ; Room PLM list address (bank $8F)
dw $E41E     ; Library background (bank $8F)
dw $C91E     ; Room setup routine (bank $8F)

; Room $DC65 state $DC77: Enemy population
org $A1E25B
;  enemy  x      y      init   props  extra  param1 param2
dw $ED3F, $0120, $0094, $0000, $2800, $0000, $0000, $0000 ; dead torizo
dw $FFFF     ; end of list
db $00       ; death quota

; Room $DC65 state $DC91: Enemy population
org $A1E25B
;  enemy  x      y      init   props  extra  param1 param2
dw $ED3F, $0120, $0094, $0000, $2800, $0000, $0000, $0000 ; dead torizo
dw $FFFF     ; end of list
db $00       ; death quota

; Room $DC65 state $DC77: Enemy graphics set
org $B490DE
;  enemy  palette
dw $ED3F, $0001 ; dead torizo
dw $FFFF     ; end of list

; Room $DC65 state $DC91: Enemy graphics set
org $B490DE
;  enemy  palette
dw $ED3F, $0001 ; dead torizo
dw $FFFF     ; end of list

; Room $DC65 state $DC77: FX
org $83A064
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $FFFF, $FFFF, $0000 : db $00, $00, $02, $02, $00, $02, $00, $00

; Room $DC65 state $DC91: FX
org $83A064
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $FFFF, $FFFF, $0000 : db $00, $00, $02, $02, $00, $02, $00, $00

; Room $DC65, state $DC77: PLM
; Room $DC65, state $DC91: PLM
org $8FC823
; dw $C842, $061E, $90A4 ; grey door facing left
dw $C848, $0601, $0CA5 ; grey door facing right
dw $0000

