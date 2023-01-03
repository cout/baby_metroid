; Room $A408: Header
org $8FA408
db $28       ; Index
db $01       ; Area
db $24       ; X position on map
db $11       ; Y position on map
db $02       ; Width (in screens)
db $02       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $A42F     ; Door out
dw $E5E6     ; State $A415 function (default)

; Room $A408 state $A415: Header
; (default)
org $8FA415
dl $C6B91C   ; Level data address
db $07       ; Tileset
db $00       ; Music data index
db $05       ; Music track index
dw $83C0     ; FX address (bank $83)
dw $95E4     ; Enemy population offset (bank $A1)
dw $8449     ; Enemy graphics set offset (bank $B4)
dw $C1C1     ; Layer 2 scroll
dw $A435     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $891E     ; Room PLM list address (bank $8F)
dw $BC02     ; Library background (bank $8F)
dw $91D6     ; Room setup routine (bank $8F)

; Room $A408 state $A415: Enemy population
org $A195E4
;  enemy  x      y      init   props  extra  param1 param2
; dw $E7BF, $0190, $01C8, $0000, $2000, $0000, $0030, $0001 ; yapping maw
; dw $E7BF, $0080, $01C8, $0000, $2000, $0000, $0030, $0001 ; yapping maw
dw $CFFF, $0108, $0193, $0000, $2000, $0000, $0100, $0200 ; cacatac
dw $FFFF     ; end of list
db $01       ; death quota

; Room $A408 state $A415: Enemy graphics set
org $B48449
;  enemy  palette
; dw $E7BF, $0001 ; yapping maw
dw $CFFF, $0002 ; cacatac
dw $FFFF     ; end of list

; Room $A408 state $A415: FX
org $8383C0
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $01BE, $FFFF, $0000 : db $00, $06, $02, $18, $03, $00, $01, $48
