org $C9C706
incbin "firefleas.bin"
warnpc $C9FD06

; Room $B6EE: Header
org $8FB6EE
db $4B       ; Index
db $02       ; Area
db $23       ; X position on map
db $06       ; Y position on map
db $03       ; Width (in screens)
db $06       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $B715     ; Special graphics bits
dw $E5E6     ; State $B6FB function (default)

; Room $B6EE state $B6FB: Header
org $8FB6FB
dl $C9C706   ; Level data address
db $0A       ; Tileset
db $18       ; Music data index
db $05       ; Music track index
dw $88DC     ; FX address (bank $83)
dw $AB80     ; Enemy population offset (bank $A1)
dw $8871     ; Enemy graphics set offset (bank $B4)
dw $0000     ; Layer 2 scroll
dw $B71B     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $9118     ; Room PLM list address (bank $8F)
dw $0000     ; Library background (bank $8F)
dw $0000     ; Room setup routine (bank $8F)

; Room $B6EE state $B6FB: Enemy population
org $A1AB80
;  enemy  x      y      init   props  extra  param1 param2
; dw $E6FF, $01F0, $02D0, $0000, $A000, $0000, $0100, $0F07 ; fune
; dw $E6FF, $0110, $01E8, $0000, $A000, $0000, $0110, $0F07 ; fune
; dw $E6FF, $01F0, $01B0, $0000, $A000, $0000, $0100, $0F07 ; fune
; dw $E6FF, $01D0, $00D8, $0000, $A000, $0000, $0100, $0F07 ; fune
; dw $E6FF, $01F0, $0380, $0000, $A000, $0000, $0100, $0F07 ; fune
;  enemy          x      y      init   props  extra  param1 param2
dw !samus_statue, $0130, $0094, $0000, $2400, $0000, $0003, $0000 ; statue
dw $DFBF,         $01F0, $0380, $0000, $2000, $0000, $0000, $0080 ; boulder
dw $DFBF,         $0150, $0130, $0050, $2000, $0000, $0000, $0080 ; boulder
dw $DFBF,         $01B8, $01D0, $0050, $2800, $0000, $0100, $0080 ; boulder
dw $DFBF,         $0128, $0260, $0050, $2800, $0000, $0000, $0080 ; boulder
dw $D6BF,         $0156, $0558, $0000, $2000, $0000, $0002, $0520 ; fireflea
dw $D6BF,         $01C8, $0538, $0000, $2000, $0000, $0003, $0518 ; fireflea
dw $D6BF,         $0238, $0558, $0000, $2000, $0000, $0002, $0520 ; fireflea
dw $D6BF,         $02A8, $0538, $0000, $2000, $0000, $0003, $0518 ; fireflea
dw $D6BF,         $0170, $0476, $0000, $2000, $0000, $0002, $0720 ; fireflea
dw $FFFF     ; end of list
db $00       ; death quota

; Room $B6EE state $B6FB: Enemy graphics set
org $B48871
;  enemy          palette
dw $D6BF,         $0001 ; fireflea
dw $DFBF,         $0002 ; boulder
; dw $E6FF,         $0003 ; fune
dw !samus_statue, $0007 ; statue
dw $FFFF     ; end of list
db $00
