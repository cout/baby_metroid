org $C691E3
incbin "red_brinstar_fireflea.bin"
warnpc $C6C1E3

; Room $A293: Header
org $8FA293
db $21       ; Index
db $01       ; Area
db $19       ; X position on map
db $0F       ; Y position on map
db $08       ; Width (in screens)
db $02       ; Height (in screens)
db $90       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $A2BA     ; Door out
dw $E5E6     ; State $A2A0 function (default)

; Room $A293 state $A2A0: Header
; (default)
org $8FA2A0
dl $C691E3   ; Level data address
db $07       ; Tileset
db $00       ; Music data index
db $05       ; Music track index
dw $835E     ; FX address (bank $83)
dw $9B13     ; Enemy population offset (bank $A1)
dw $857F     ; Enemy graphics set offset (bank $B4)
dw $0000     ; Layer 2 scroll
dw $A2BE     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $886E     ; Room PLM list address (bank $8F)
dw $0000     ; Library background (bank $8F)
dw $91D6     ; Room setup routine (bank $8F)

; Room $A293 state $A2A0: Enemy population
org $A19B13
;  enemy  x      y      init   props  extra  param1 param2
dw $D6BF, $06D0, $0090, $0000, $2000, $0000, $0000, $0306 ; fireflea
dw $D6BF, $0710, $0070, $0000, $2000, $0000, $0002, $0518 ; fireflea
dw $D6BF, $0688, $0060, $0000, $2000, $0000, $0003, $0418 ; fireflea
dw $D6BF, $04E0, $00A8, $0000, $2000, $0000, $0002, $0210 ; fireflea
dw $D6BF, $0630, $0080, $0000, $2000, $0000, $0003, $0220 ; fireflea
dw $D63F, $0745, $0050, $0000, $2800, $0000, $0000, $0000 ; waver
dw $D63F, $0690, $0060, $0000, $2800, $0000, $0000, $0000 ; waver
dw $D63F, $0600, $0060, $0000, $2800, $0000, $0001, $0000 ; waver
dw $E7BF, $0198, $00C8, $0000, $2000, $0000, $0050, $0001 ; yapping maw
dw $E7BF, $0258, $00C0, $0000, $2000, $0000, $0050, $0001 ; yapping maw
dw $E7BF, $03A8, $00C0, $0000, $2000, $0000, $0050, $0001 ; yapping maw
dw $FFFF     ; end of list
db $08       ; death quota

; Room $A293 state $A2A0: Enemy graphics set
org $B4857F
;  enemy  palette
dw $D6BF, $0001 ; fireflea
dw $D63F, $0002 ; waver
dw $E7BF, $0003 ; yapping maw
dw $FFFF     ; end of list

; Room $A293 state $A2A0: FX
org $83835E
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $FFFF, $FFFF, $0000 : db $00, $24, $02, $02, $00, $00, $02, $00
