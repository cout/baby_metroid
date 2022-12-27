; Room $A4DA: Header
org $8FA4DA
db $2C       ; Index
db $01       ; Area
db $2D       ; X position on map
db $12       ; Y position on map
db $04       ; Width (in screens)
db $02       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $A501     ; Door out
dw $E5E6     ; State $A4E7 function (default)

; Room $A4DA state $A4E7: Header
org $8FA4E7
dl $C6C630   ; Level data address
db $07       ; Tileset
db $12       ; Music data index
db $05       ; Music track index
dw $83D2     ; FX address (bank $83)
dw $98F7     ; Enemy population offset (bank $A1)
dw $8533     ; Enemy graphics set offset (bank $B4)
dw $00C0     ; Layer 2 scroll
dw $A507     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $89A4     ; Room PLM list address (bank $8F)
dw $0000     ; Library background (bank $8F)
dw $91D6     ; Room setup routine (bank $8F)

; Room $A4DA state $A4E7: Enemy population
org $A198F7
;  enemy  x      y      init   props  extra  param1 param2
; dw $EABF, $0169, $0070, $0000, $2800, $0000, $0000, $0000 ; hachi1 (green ki-hunter)
; dw $EAFF, $0169, $0070, $0000, $2C00, $0000, $0020, $0000 ; hachi1 (green ki-hunter)
; dw $EABF, $0289, $0059, $0000, $2800, $0000, $0000, $0000 ; hachi1 (green ki-hunter)
; dw $EAFF, $0289, $0059, $0000, $2C00, $0000, $0020, $0000 ; hachi1 (green ki-hunter)
; dw $EABF, $01FE, $0063, $0000, $2800, $0000, $0000, $0000 ; hachi1 (green ki-hunter)
; dw $EAFF, $01FE, $0063, $0000, $2C00, $0000, $0020, $0000 ; hachi1 (green ki-hunter)
; dw $EABF, $0242, $007A, $0000, $2800, $0000, $0000, $0000 ; hachi1 (green ki-hunter)
; dw $EAFF, $0242, $007A, $0000, $2C00, $0000, $0020, $0000 ; hachi1 (green ki-hunter)
dw $FFFF     ; end of list
db $04       ; death quota

; Room $A4DA state $A4E7: Enemy graphics set
org $B48533
;  enemy  palette
; dw $EABF, $0001 ; hachi1 (green ki-hunter)
dw $FFFF     ; end of list

; Room $A4DA state $A4E7: FX
org $8383D2
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $FFFF, $FFFF, $0000 : db $00, $00, $02, $02, $00, $04, $00, $00
