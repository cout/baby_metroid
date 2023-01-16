; Room $AE32: Header
org $8FAE32
db $21       ; Index
db $02       ; Area
db $1B       ; X position on map
db $06       ; Y position on map
db $03       ; Width (in screens)
db $03       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $AE59     ; Door out
dw $E5E6     ; State $AE3F function (default)

; Room $AE32 state $AE3F: Header
; (default)
org $8FAE3F
dl $C88953   ; Level data address
db $09       ; Tileset
db $00       ; Music data index
db $00       ; Music track index
dw $8650     ; FX address (bank $83)
dw $BB34     ; Enemy population offset (bank $A1)
dw $8B29     ; Enemy graphics set offset (bank $B4)
dw $0000     ; Layer 2 scroll
dw $AE5D     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $8CD4     ; Room PLM list address (bank $8F)
dw $0000     ; Library background (bank $8F)
dw $91F6     ; Room setup routine (bank $8F)

; Room $AE32 state $AE3F: Enemy population
org $A1BB34
;  enemy  x      y      init   props  extra  param1 param2
dw $E6FF, $01D0, $0280, $0000, $A000, $0000, $8000, $8005 ; fune
dw $E6FF, $02E0, $0210, $0000, $A000, $0000, $8000, $0007 ; fune
dw $E6FF, $0220, $01C8, $0000, $A000, $0000, $8010, $0007 ; fune
dw $E6FF, $02E0, $0178, $0000, $A000, $0000, $8000, $0007 ; fune
dw $E6FF, $0220, $0128, $0000, $A000, $0000, $8010, $0007 ; fune
dw $E6FF, $02E0, $00D8, $0000, $A000, $0000, $8000, $0007 ; fune
dw $D1FF, $00F8, $02C8, $0000, $2500, $0000, $0000, $0000 ; polyp
dw $D1FF, $0080, $02C8, $0000, $2500, $0000, $0000, $0000 ; polyp
dw $D1FF, $0088, $02C8, $0000, $2500, $0000, $0000, $0000 ; polyp
dw $D1FF, $0108, $02C8, $0000, $2500, $0000, $0000, $0000 ; polyp
dw $FFFF     ; end of list
db $0A       ; death quota

; Room $AE32 state $AE3F: Enemy graphics set
org $B48B29
;  enemy  palette
dw $E6FF, $0001 ; fune
dw $D1FF, $0002 ; polyp
dw $FFFF     ; end of list

; Room $AE32 state $AE3F: FX
org $838650
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
; dw $9672, $02E0, $0260, $FFF6 : db $40, $02, $02, $1E, $0B, $1F, $00, $02
dw $9672, $02E0, $02B0, $FFF2 : db $40, $02, $02, $1E, $0B, $1F, $00, $02
dw $0000, $0268, $FFFF, $0000 : db $00, $02, $02, $1E, $01, $00, $00, $02
