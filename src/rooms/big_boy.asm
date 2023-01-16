; Room $DCB1: Header
org $8FDCB1
db $07       ; Index
db $05       ; Area
db $0D       ; X position on map
db $0F       ; Y position on map
db $04       ; Width (in screens)
db $01       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $DCF7     ; Door out
dw $E612     ; State $DCDD function (event)
db $14       ; Event
dw $DCDD     ; State header address
dw $E5E6     ; State $DCC3 function (default)

; Room $DCB1 state $DCC3: Header
; (default)
org $8FDCC3
dl $CDD930   ; Level data address
db $0D       ; Tileset
db $00       ; Music data index
db $00       ; Music track index
dw $A074     ; FX address (bank $83)
dw $E26E     ; Enemy population offset (bank $A1)
dw $90EC     ; Enemy graphics set offset (bank $B4)
dw $C1C1     ; Layer 2 scroll
dw $DCFB     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $C831     ; Room PLM list address (bank $8F)
dw $E41E     ; Library background (bank $8F)
dw $C91E     ; Room setup routine (bank $8F)

; Room $DCB1 state $DCDD: Header
; (event bit 14h)
org $8FDCDD
dl $CDD930   ; Level data address
db $0D       ; Tileset
db $00       ; Music data index
db $00       ; Music track index
dw $A074     ; FX address (bank $83)
dw $E26E     ; Enemy population offset (bank $A1)
dw $90EC     ; Enemy graphics set offset (bank $B4)
dw $C1C1     ; Layer 2 scroll
dw $DCFB     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $C831     ; Room PLM list address (bank $8F)
dw $E41E     ; Library background (bank $8F)
dw $C91E     ; Room setup routine (bank $8F)

; Room $DCB1 state $DCC3: Enemy population
org $A1E26E
;  enemy  x      y      init   props  extra  param1 param2
dw $EEBF, $0180, $0040, $0000, $2800, $0000, $0000, $0000 ; big boy
dw $ED7F, $0228, $00A0, $0000, $A000, $0000, $0000, $0000 ; dead sidehopper
dw $ED7F, $00A0, $0040, $0000, $A000, $0000, $0002, $0000 ; dead sidehopper
dw $EDFF, $00F0, $0040, $0000, $A000, $0000, $0000, $0000 ; dead zoomer
dw $EDFF, $0298, $00C8, $0000, $A000, $0000, $0002, $0000 ; dead zoomer
dw $EDFF, $0108, $0036, $0000, $A000, $0000, $0004, $0000 ; dead zoomer
dw $EE3F, $0320, $00A8, $0000, $A000, $0000, $0000, $0000 ; dead ripper
dw $EE3F, $00C2, $00C8, $0000, $A000, $0000, $0002, $0000 ; dead ripper
dw $EE7F, $0380, $0047, $0000, $A000, $0000, $0000, $0000 ; dead skree
dw $EE7F, $0260, $0047, $0000, $A000, $0000, $0002, $0000 ; dead skree
dw $EE7F, $0180, $0047, $0000, $A000, $0000, $0004, $0000 ; dead skree
dw $FFFF     ; end of list
db $00       ; death quota

; Room $DCB1 state $DCDD: Enemy population
org $A1E26E
;  enemy  x      y      init   props  extra  param1 param2
dw $EEBF, $0180, $0040, $0000, $2800, $0000, $0000, $0000 ; big boy
dw $ED7F, $0228, $00A0, $0000, $A000, $0000, $0000, $0000 ; dead sidehopper
dw $ED7F, $00A0, $0040, $0000, $A000, $0000, $0002, $0000 ; dead sidehopper
dw $EDFF, $00F0, $0040, $0000, $A000, $0000, $0000, $0000 ; dead zoomer
dw $EDFF, $0298, $00C8, $0000, $A000, $0000, $0002, $0000 ; dead zoomer
dw $EDFF, $0108, $0036, $0000, $A000, $0000, $0004, $0000 ; dead zoomer
dw $EE3F, $0320, $00A8, $0000, $A000, $0000, $0000, $0000 ; dead ripper
dw $EE3F, $00C2, $00C8, $0000, $A000, $0000, $0002, $0000 ; dead ripper
dw $EE7F, $0380, $0047, $0000, $A000, $0000, $0000, $0000 ; dead skree
dw $EE7F, $0260, $0047, $0000, $A000, $0000, $0002, $0000 ; dead skree
dw $EE7F, $0180, $0047, $0000, $A000, $0000, $0004, $0000 ; dead skree
dw $FFFF     ; end of list
db $00       ; death quota

; Room $DCB1 state $DCC3: Enemy graphics set
org $B490EC
;  enemy  palette
dw $ED7F, $0001 ; dead sidehopper
dw $EDBF, $0001 ; dead sidehopper
dw $EEBF, $0001 ; big boy
dw $FFFF     ; end of list

; Room $DCB1 state $DCDD: Enemy graphics set
org $B490EC
;  enemy  palette
dw $ED7F, $0001 ; dead sidehopper
dw $EDBF, $0001 ; dead sidehopper
dw $EEBF, $0001 ; big boy
dw $FFFF     ; end of list

; Room $DCB1 state $DCC3: FX
org $83A074
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $FFFF, $FFFF, $0000 : db $00, $00, $02, $02, $00, $02, $00, $00

; Room $DCB1 state $DCDD: FX
org $83A074
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $FFFF, $FFFF, $0000 : db $00, $00, $02, $02, $00, $02, $00, $00

; Room $DCB1, state $DCC3: PLM
; Room $DCB1, state $DCDD: PLM
org $8FC831
; dw $C842, $063E, $90A6
dw 0000
