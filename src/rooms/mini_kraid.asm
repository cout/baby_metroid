; Room $A521: Header
org $8FA521
db $2D       ; Index
db $01       ; Area
db $2F       ; X position on map
db $13       ; Y position on map
db $06       ; Width (in screens)
db $01       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $A567     ; Door out
dw $E629     ; State $A54D function (boss)
db $01       ; Boss
dw $A54D     ; State header address
dw $E5E6     ; State $A533 function (default)

; Room $A521 state $A533: Header
; (default)
org $8FA533
dl $C6CDB9   ; Level data address
db $07       ; Tileset
db $27       ; Music data index
db $03       ; Music track index
dw $83E2     ; FX address (bank $83)
dw $A0BA     ; Enemy population offset (bank $A1)
dw $8651     ; Enemy graphics set offset (bank $B4)
dw $C1C1     ; Layer 2 scroll
dw $0000     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $89F4     ; Room PLM list address (bank $8F)
dw $BC6E     ; Library background (bank $8F)
dw $91D6     ; Room setup routine (bank $8F)

; Room $A521 state $A54D: Header
; (boss bit 01h)
org $8FA54D
dl $C6CDB9   ; Level data address
db $07       ; Tileset
db $27       ; Music data index
db $03       ; Music track index
dw $83E2     ; FX address (bank $83)
dw $A0BA     ; Enemy population offset (bank $A1)
dw $8651     ; Enemy graphics set offset (bank $B4)
dw $C1C1     ; Layer 2 scroll
dw $0000     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $89F4     ; Room PLM list address (bank $8F)
dw $BC6E     ; Library background (bank $8F)
dw $91D6     ; Room setup routine (bank $8F)

; Room $A521 state $A533: Enemy population
; Room $A521 state $A54D: Enemy population
org $A1A0BA
;  enemy  x      y      init   props  extra  param1 param2
dw $F693, $00D9, $00A0, $0000, $2000, $0004, $8000, $0050 ; batta3Br (brinstar green walking pirate)
dw $F693, $0120, $00A0, $0000, $2000, $0004, $8000, $0050 ; batta3Br (brinstar green walking pirate)
dw $F693, $01F4, $00A0, $0000, $2000, $0004, $8000, $0050 ; batta3Br (brinstar green walking pirate)
; dw $E0FF, $0530, $00A0, $0000, $2800, $0000, $0000, $0000 ; mini kraid
dw $FFFF     ; end of list
db $04       ; death quota

; Room $A521 state $A533: Enemy graphics set
; Room $A521 state $A54D: Enemy graphics set
org $B48651
;  enemy  palette
dw $F693, $0001 ; batta3Br (brinstar green walking pirate)
; dw $E0FF, $0003 ; mini kraid
dw $FFFF     ; end of list

; Room $A521 state $A533: FX
; Room $A521 state $A54D: FX
org $8383E2
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $FFFF, $FFFF, $0000 : db $00, $00, $02, $02, $00, $00, $02, $00
