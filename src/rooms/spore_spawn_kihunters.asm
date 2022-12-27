; Room $9D9C: Header
org $8F9D9C
db $0A       ; Index
db $01       ; Area
db $13       ; X position on map
db $04       ; Y position on map
db $04       ; Width (in screens)
db $01       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $9DC3     ; Door out
dw $E5E6     ; State $9DA9 function (default)

; Room $9D9C state $9DA9: Header
org $8F9DA9
dl $C5CBA7   ; Level data address
db $06       ; Tileset
db $0F       ; Music data index
db $05       ; Music track index
dw $825E     ; FX address (bank $83)
dw $8FC5     ; Enemy population offset (bank $A1)
dw $82FB     ; Enemy graphics set offset (bank $B4)
dw $C1C1     ; Layer 2 scroll
dw $0000     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $8634     ; Room PLM list address (bank $8F)
dw $BA52     ; Library background (bank $8F)
dw $91D5     ; Room setup routine (bank $8F)

; Room $9D9C state $9DA9: Enemy population
org $A18FC5
;  enemy  x      y      init   props  extra  param1 param2
; dw $EABF, $00D9, $0068, $0000, $2800, $0000, $003C, $0000 ; hachi1 (green ki-hunter)
; dw $EAFF, $00D9, $0068, $0000, $2C00, $0000, $0020, $0000 ; hachi1 (green ki-hunter)
; dw $EABF, $02D5, $0062, $0000, $2800, $0000, $003C, $0000 ; hachi1 (green ki-hunter)
; dw $EAFF, $02D5, $0062, $0000, $2C00, $0000, $0020, $0000 ; hachi1 (green ki-hunter)
; dw $EABF, $03D7, $0068, $0000, $2800, $0000, $003C, $0000 ; hachi1 (green ki-hunter)
; dw $EAFF, $03D7, $0068, $0000, $2C00, $0000, $0020, $0000 ; hachi1 (green ki-hunter)
dw $FFFF     ; end of list
db $03       ; death quota

; Room $9D9C state $9DA9: Enemy graphics set
org $B482FB
;  enemy  palette
; dw $EABF, $0007 ; hachi1 (green ki-hunter)
dw $FFFF     ; end of list

; Room $9D9C state $9DA9: FX
org $83825E
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $FFFF, $FFFF, $0000 : db $00, $00, $02, $02, $00, $01, $00, $00
