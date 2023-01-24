org $C5CE34
incbin "spore_spawn.bin"
warnpc $C5D734

; Room $9DC7: Header
org $8F9DC7
db $0B       ; Index
db $01       ; Area
db $16       ; X position on map
db $01       ; Y position on map
db $01       ; Width (in screens)
db $03       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $9E0D     ; Door out
dw $E629     ; State $9DF3 function (boss)
db $02       ; Boss
dw $9DF3     ; State header address
dw $E5E6     ; State $9DD9 function (default)

; Room $9DC7 state $9DD9: Header
org $8F9DD9
dl $C5CE34   ; Level data address
db $06       ; Tileset
db $2A       ; Music data index
db $03       ; Music track index
dw $826E     ; FX address (bank $83)
dw $A0FD     ; Enemy population offset (bank $A1)
dw $8663     ; Enemy graphics set offset (bank $B4)
dw $0000     ; Layer 2 scroll
dw $0001     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $8642     ; Room PLM list address (bank $8F)
dw $0000     ; Library background (bank $8F)
dw $91D5     ; Room setup routine (bank $8F)

; Room $9DC7 state $9DF3: Header
org $8F9DF3
dl $C5CE34   ; Level data address
db $06       ; Tileset
db $00       ; Music data index
db $03       ; Music track index
dw $826E     ; FX address (bank $83)
dw $A0FD     ; Enemy population offset (bank $A1)
dw $8663     ; Enemy graphics set offset (bank $B4)
dw $0000     ; Layer 2 scroll
dw $0001     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $8642     ; Room PLM list address (bank $8F)
dw $0000     ; Library background (bank $8F)
dw $91D5     ; Room setup routine (bank $8F)

; Room $9DC7 state $9DD9: Enemy population
; Room $9DC7 state $9DF3: Enemy population
org $A1A0FD
;  enemy  x      y      init   props  extra  param1 param2
dw $DF3F, $0080, $0270, $0000, $2800, $0004, $0000, $0000 ; spore spawn
dw $FFFF     ; end of list
db $00       ; death quota

; Room $9DC7 state $9DD9: Enemy graphics set
; Room $9DC7 state $9DF3: Enemy graphics set
org $B48663
;  enemy  palette
dw $DF3F, $0001 ; spore spawn
dw $FFFF     ; end of list

; Room $9DC7 state $9DD9: FX
; Room $9DC7 state $9DF3: FX
org $83826E
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $FFFF, $FFFF, $0000 : db $00, $00, $02, $02, $00, $08, $00, $00
