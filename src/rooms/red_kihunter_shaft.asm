; Room $B585: Header
org $8FB585
db $45       ; Index
db $02       ; Area
db $23       ; X position on map
db $09       ; Y position on map
db $03       ; Width (in screens)
db $05       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $B5AC     ; Special graphics bits
dw $E5E6     ; State $B592 function (default)

; Room $B585 state $B592: Header
org $8FB592
dl $C99E7B   ; Level data address
db $09       ; Tileset
db $00       ; Music data index
db $00       ; Music track index
dw $887C     ; FX address (bank $83)
dw $A428     ; Enemy population offset (bank $A1)
dw $86FD     ; Enemy graphics set offset (bank $B4)
dw $C1C1     ; Layer 2 scroll
dw $B5B4     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $8FDA     ; Room PLM list address (bank $8F)
dw $BE5A     ; Library background (bank $8F)
dw $91F7     ; Room setup routine (bank $8F)

; Room $B585 state $B592: Enemy population
org $A1A428
;  enemy  x      y      init   props  extra  param1 param2
; dw $EBBF, $00B9, $01D6, $0000, $2800, $0000, $0050, $0000 ; hachi3 (red ki-hunter)
; dw $EBFF, $00B9, $01D6, $0000, $2C00, $0000, $0020, $0000 ; hachi3 (red ki-hunter)
; dw $EBBF, $004D, $023A, $0000, $2800, $0000, $0050, $0000 ; hachi3 (red ki-hunter)
; dw $EBFF, $004D, $023A, $0000, $2C00, $0000, $0020, $0000 ; hachi3 (red ki-hunter)
; dw $EBBF, $0087, $02F2, $0000, $2800, $0000, $0050, $0000 ; hachi3 (red ki-hunter)
; dw $EBFF, $0087, $02F2, $0000, $2C00, $0000, $0020, $0000 ; hachi3 (red ki-hunter)
;  enemy          x      y      init   props  extra  param1 param2
dw !samus_statue, $006D, $0091, $0000, $2400, $0000, $0002, $0003 ; statue
dw $FFFF     ; end of list
db $03       ; death quota

; Room $B585 state $B592: Enemy graphics set
org $B486FD
;  enemy  palette
; dw $EBBF, $0001 ; hachi3 (red ki-hunter)
; dw $DBFF, $0002 ; reflec (mochtroid?)
dw !samus_statue, $0001 ; statue
dw $FFFF     ; end of list
