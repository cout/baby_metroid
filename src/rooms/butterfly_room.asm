org $CCA13B
incbin "butterfly_room.bin"
warnpc $CCA34A

; Room $D5EC: Header
org $8FD5EC
db $22       ; Index
db $04       ; Area
db $1A       ; X position on map
db $07       ; Y position on map
db $01       ; Width (in screens)
db $01       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $D613     ; Special graphics bits
dw $E5E6     ; State $D5F9 function (default)

; Room $D5EC state $D5F9: Header
org $8FD5F9
dl $CCA13B   ; Level data address
db $0C       ; Tileset
db $00       ; Music data index
db $00       ; Music track index
dw $9EB4     ; FX address (bank $83)
dw $DC3C     ; Enemy population offset (bank $A1)
dw $8F94     ; Enemy graphics set offset (bank $B4)
dw $00C0     ; Layer 2 scroll
dw $0000     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $C611     ; Room PLM list address (bank $8F)
dw $0000     ; Library background (bank $8F)
dw $C8D2     ; Room setup routine (bank $8F)

; Room $D5EC state $D5F9: Enemy population
org $A1DC3C
;  enemy  x      y      init   props  extra  param1 param2
;;; dw $DA7F, $0098, $00D8, $0000, $6100, $0000, $0000, $0000 ; zoa
;;; dw $DA7F, $0068, $00D8, $0000, $6100, $0000, $0000, $0000 ; zoa
;;; dw $DA7F, $0098, $00E0, $0000, $6100, $0000, $0000, $0000 ; zoa
dw $FFFF     ; end of list
db $03       ; death quota

; Room $D5EC state $D5F9: Enemy graphics set
org $B48F94
;  enemy  palette
;;; dw $DA7F, $0001 ; zoa
dw $FFFF     ; end of list
