; Room $D433: Header
org $8FD433
db $19       ; Index
db $04       ; Area
db $1A       ; X position on map
db $05       ; Y position on map
db $01       ; Width (in screens)
db $01       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $D45A     ; Special graphics bits
dw $E5E6     ; State $D440 function (default)

; Room $D433 state $D440: Header
org $8FD440
dl $CBDCF3   ; Level data address
db $0C       ; Tileset
db $00       ; Music data index
db $00       ; Music track index
dw $9E34     ; FX address (bank $83)
dw $DF30     ; Enemy population offset (bank $A1)
dw $904C     ; Enemy graphics set offset (bank $B4)
dw $0000     ; Layer 2 scroll
dw $D460     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $C593     ; Room PLM list address (bank $8F)
dw $0000     ; Library background (bank $8F)
dw $C8D2     ; Room setup routine (bank $8F)

; Room $D433 state $D440: Enemy population
org $A1DF30
;  enemy  x      y      init   props  extra  param1 param2
dw $D7FF, $00B0, $00C0, $00A8, $A000, $0000, $0000, $1010 ; tripper
;; dw $E7BF, $00B0, $00F0, $0000, $2000, $0000, $0040, $0001 ; yapping maw
;; dw $DA7F, $0080, $00DC, $0000, $6100, $0000, $0000, $0000 ; zoa
;; dw $E7BF, $004D, $00F0, $0000, $2000, $0000, $0040, $0001 ; yapping maw
; D7FF,0100,00A8,0000,A000,0000,0000,1010
dw $FFFF     ; end of list
db $01       ; death quota

; Room $D433 state $D440: Enemy graphics set
org $B4904C
;  enemy  palette
;; dw $E7BF, $0001 ; yapping maw
;; dw $DA7F, $0007 ; zoa
dw $D7FF, $0001 ; tripper
dw $FFFF     ; end of list
