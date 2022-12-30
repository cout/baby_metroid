; Room $A98D: Header
org $8FA98D
db $0A       ; Index
db $02       ; Area
db $0C       ; X position on map
db $0A       ; Y position on map
db $08       ; Width (in screens)
db $01       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $01       ; Special graphics bits
dw $A9D3     ; Door out
dw $E629     ; State $A9B9 function (boss)
db $02       ; Boss
dw $A9B9     ; State header address
dw $E5E6     ; State $A99F function (default)

; Room $A98D state $A99F: Header
; (default)
org $8FA99F
dl $C79D71   ; Level data address
db $1B       ; Tileset
db $27       ; Music data index
db $03       ; Music track index
dw $84D0     ; FX address (bank $83)
dw $BB0E     ; Enemy population offset (bank $A1)
dw $8B11     ; Enemy graphics set offset (bank $B4)
dw $0101     ; Layer 2 scroll
dw $A9D7     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $E8CD     ; Room main routine (bank $8F)
dw $8B9E     ; Room PLM list address (bank $8F)
dw $B84D     ; Library background (bank $8F)
dw $91F6     ; Room setup routine (bank $8F)

; Room $A98D state $A9B9: Header
; (boss bit 02h)
org $8FA9B9
dl $C79D71   ; Level data address
db $1B       ; Tileset
db $00       ; Music data index
db $00       ; Music track index
dw $84D0     ; FX address (bank $83)
dw $BB0E     ; Enemy population offset (bank $A1)
dw $8B11     ; Enemy graphics set offset (bank $B4)
dw $0101     ; Layer 2 scroll
dw $A9D7     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $E8CD     ; Room main routine (bank $8F)
dw $8B9E     ; Room PLM list address (bank $8F)
dw $B858     ; Library background (bank $8F)
dw $91F6     ; Room setup routine (bank $8F)

; Room $A98D state $A99F: Enemy population
; Room $A98D state $A9B9: Enemy population
org $A1BB0E
;  enemy  x      y      init   props  extra  param1 param2
dw $DDBF, $0480, $0078, $BD2A, $A800, $0004, $0000, $0000 ; crocomire
dw $DDFF, $0480, $0078, $BD2A, $A800, $0004, $0000, $0000 ; crocomire
dw $FFFF     ; end of list
db $00       ; death quota

; Room $A98D state $A99F: Enemy graphics set
; Room $A98D state $A9B9: Enemy graphics set
org $B48B11
;  enemy  palette
dw $DDBF, $D007 ; crocomire
dw $FFFF     ; end of list

; Room $A98D state $A99F: FX
; Room $A98D state $A9B9: FX
org $8384D0
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $00C6, $FFFF, $0000 : db $00, $04, $02, $1E, $81, $00, $01, $02
