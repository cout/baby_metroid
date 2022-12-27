org $C5ECAE
incbin "noob_bridge.bin"
warnpc $C5EF71

; Room $9FBA: Header
org $8F9FBA
db $11       ; Index
db $01       ; Area
db $1B       ; X position on map
db $0D       ; Y position on map
db $06       ; Width (in screens)
db $01       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $9FE1     ; Door out
dw $E5E6     ; State $9FC7 function (default)

; Room $9FBA state $9FC7: Header
org $8F9FC7
dl $C5ECAE   ; Level data address
db $06       ; Tileset
db $0F       ; Music data index
db $05       ; Music track index
dw $82C0     ; FX address (bank $83)
dw $92A3     ; Enemy population offset (bank $A1)
dw $83A3     ; Enemy graphics set offset (bank $B4)
dw $C1C1     ; Layer 2 scroll
dw $0000     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $87A6     ; Room PLM list address (bank $8F)
dw $BA52     ; Library background (bank $8F)
dw $91D5     ; Room setup routine (bank $8F)

; Room $9FBA state $9FC7: Enemy population
org $A192A3
;  enemy  x      y      init   props  extra  param1 param2
; dw $CFFF, $00C0, $00B3, $0000, $2000, $0000, $0100, $0301 ; cacatac
; dw $CFFF, $01B0, $00B3, $0000, $2000, $0000, $0100, $0301 ; cacatac
; dw $CFFF, $0570, $00B3, $0000, $2000, $0000, $0101, $0301 ; cacatac
; dw $CFFF, $03D0, $00B3, $0000, $2000, $0000, $0100, $0301 ; cacatac
dw $DC7F, $0248, $0076, $0002, $2801, $0000, $0000, $0002 ; zeela
dw $DC7F, $02A8, $0076, $0002, $2801, $0000, $0000, $0002 ; zeela
dw $DC7F, $0300, $0076, $0002, $2801, $0000, $0000, $0002 ; zeela
dw $DC7F, $0368, $0076, $0002, $2801, $0000, $0000, $0002 ; zeela
dw $FFFF     ; end of list
db $08       ; death quota

; Room $9FBA state $9FC7: Enemy graphics set
org $B483A3
;  enemy  palette
; dw $CFFF, $0001 ; cacatac
dw $DC7F, $0002 ; zeela
dw $FFFF     ; end of list

; Room $9FBA state $9FC7: FX
org $8382C0
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $FFFF, $FFFF, $0000 : db $00, $00, $02, $02, $00, $01, $02, $00
