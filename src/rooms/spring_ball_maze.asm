org $C994BA
incbin "spring_ball_maze.bin"
warnpc $C9A8BA

; Room $B510: Header
org $8FB510
db $43       ; Index
db $02       ; Area
db $21       ; X position on map
db $05       ; Y position on map
db $05       ; Width (in screens)
db $02       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $B537     ; Special graphics bits
dw $E5E6     ; State $B51D function (default)

; Room $B510 state $B51D: Header
org $8FB51D
dl $C994BA   ; Level data address
db $09       ; Tileset
db $00       ; Music data index
db $05       ; Music track index
dw $885C     ; FX address (bank $83)
dw $AE52     ; Enemy population offset (bank $A1)
dw $88D1     ; Enemy graphics set offset (bank $B4)
dw $C1C1     ; Layer 2 scroll
dw $B53D     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $8F7C     ; Room PLM list address (bank $8F)
dw $BF68     ; Library background (bank $8F)
dw $91F7     ; Room setup routine (bank $8F)

; Room $B510 state $B51D: Enemy population
org $A1AE52
;  enemy  x      y      init   props  extra  param1 param2
dw $E9BF, $0100, $0200, $0000, $2800, $0000, $0000, $0000 ; ndra
dw $E9BF, $0151, $0200, $0000, $2800, $0000, $0000, $0000 ; ndra
dw $E9BF, $0060, $0200, $0000, $2800, $0000, $0000, $0000 ; ndra
dw $E9BF, $0198, $00D8, $0000, $2800, $0000, $0000, $0000 ; ndra
dw $E9BF, $03FB, $04C9, $0000, $2800, $0000, $0000, $0000 ; ndra
dw $FFFF     ; end of list
db $05       ; death quota

; Room $B510 state $B51D: Enemy graphics set
org $B488D1
;  enemy  palette
dw $E9BF, $0001 ; ndra
dw $FFFF     ; end of list

; Room $B510 state $B51D: FX
org $B4885C
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $FFFF, $FFFF, $0000 : db $00, $04, $02, $1E, $02, $1F, $02, $00
