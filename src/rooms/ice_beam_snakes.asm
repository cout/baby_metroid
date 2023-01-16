; Room $A8B9: Header
org $8FA8B9
db $07       ; Index
db $02       ; Area
db $03       ; X position on map
db $01       ; Y position on map
db $02       ; Width (in screens)
db $03       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $A8E0     ; Door out
dw $E5E6     ; State $A8C6 function (default)

; Room $A8B9 state $A8C6: Header
; (default)
org $8FA8C6
dl $C785D6   ; Level data address
db $09       ; Tileset
db $00       ; Music data index
db $05       ; Music track index
dw $84A0     ; FX address (bank $83)
dw $B6AD     ; Enemy population offset (bank $A1)
dw $8A5B     ; Enemy graphics set offset (bank $B4)
dw $C1C1     ; Layer 2 scroll
dw $A8E6     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $8B2C     ; Room PLM list address (bank $8F)
dw $BE5A     ; Library background (bank $8F)
dw $91F5     ; Room setup routine (bank $8F)

; Room $A8B9 state $A8C6: Enemy population
org $A1B6AD
;  enemy  x      y      init   props  extra  param1 param2
dw $DCBF, $0158, $01B8, $0003, $2800, $0000, $0001, $0004 ; nova
dw $DCBF, $0198, $01B8, $0003, $2800, $0000, $0001, $0004 ; nova
dw $DCBF, $0178, $01B8, $0003, $2800, $0000, $0001, $0004 ; nova
dw $E6FF, $00B0, $01C4, $0000, $A000, $0000, $5000, $5007 ; fune
dw $E6FF, $0020, $0100, $0000, $A000, $0000, $5010, $5007 ; fune
dw $E6FF, $00B0, $0144, $0000, $A000, $0000, $5000, $5007 ; fune
dw $E6FF, $0020, $0290, $0000, $A000, $0000, $5010, $5007 ; fune
dw !samus_statue, $00D4, $00AD, $0000, $2400, $0000, $0002, $0009
dw $FFFF     ; end of list
db $07       ; death quota

; Room $A8B9 state $A8C6: Enemy graphics set
org $B48A5B
;  enemy  palette
dw $DCBF, $0001 ; nova
dw $E6FF, $0002 ; fune
dw !samus_statue, $0003 ; statue
dw $FFFF     ; end of list

; Room $A8B9 state $A8C6: FX
org $8384A0
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $02B8, $FFFF, $0000 : db $00, $02, $02, $1E, $03, $1F, $03, $02
