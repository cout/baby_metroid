; Room $B457: Header
org $8FB457
db $3F       ; Index
db $02       ; Area
db $1A       ; X position on map
db $0E       ; Y position on map
db $04       ; Width (in screens)
db $01       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $B47E     ; Special graphics bits
dw $E5E6     ; State $B464 function (default)

; Room $B457 state $B464: Header
org $8FB464
dl $C8FCC5   ; Level data address
db $09       ; Tileset
db $00       ; Music data index
db $00       ; Music track index
; dw $880C     ; FX address (bank $83)
dw $87AA     ; FX address (bank $83)
dw $AD6C     ; Enemy population offset (bank $A1)
dw $88B1     ; Enemy graphics set offset (bank $B4)
dw $C1C1     ; Layer 2 scroll
dw $0000     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $8F38     ; Room PLM list address (bank $8F)
dw $BF17     ; Library background (bank $8F)
dw $91F7     ; Room setup routine (bank $8F)

; Room $B457 state $B464: Enemy population
org $A1AD6C
;  enemy  x      y      init   props  extra  param1 param2
dw $E0BF, $0190, $00D0, $0000, $2000, $0000, $4010, $2001 ; puromi
dw $E0BF, $02D0, $00D0, $0000, $2000, $0000, $4010, $2001 ; puromi
dw $FFFF     ; end of list
db $00       ; death quota

; Room $B457 state $B464: Enemy graphics set
org $B488B1
;  enemy  palette
dw $E0BF, $0007 ; puromi
dw $FFFF     ; end of list
