; Room $9879: Header
org $8F9879
db $16       ; Index
db $00       ; Area
db $16       ; X position on map
db $06       ; Y position on map
db $03       ; Width (in screens)
db $01       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $98DE     ; Door out
dw $E612     ; State $98C4 function (event)
db $0E       ; Event
dw $98C4     ; State header address
dw $E629     ; State $98AA function (boss)
db $04       ; Boss
dw $98AA     ; State header address
dw $E5E6     ; State $9890 function (default)

; Room $9879 state $9890: Header
; (default)
org $8F9890
dl $C3E16E   ; Level data address
db $02       ; Tileset
db $09       ; Music data index
db $05       ; Music track index
dw $81C0     ; FX address (bank $83)
dw $8364     ; Enemy population offset (bank $A1)
dw $807D     ; Enemy graphics set offset (bank $B4)
dw $C1C1     ; Layer 2 scroll
dw $0000     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $8420     ; Room PLM list address (bank $8F)
dw $B8EA     ; Library background (bank $8F)
dw $91D4     ; Room setup routine (bank $8F)

; Room $9879 state $98AA: Header
; (boss bit 04h)
org $8F98AA
dl $C3E16E   ; Level data address
db $02       ; Tileset
db $09       ; Music data index
db $05       ; Music track index
dw $81C0     ; FX address (bank $83)
dw $8364     ; Enemy population offset (bank $A1)
dw $807D     ; Enemy graphics set offset (bank $B4)
dw $C1C1     ; Layer 2 scroll
dw $0000     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $8420     ; Room PLM list address (bank $8F)
dw $B8EA     ; Library background (bank $8F)
dw $91D4     ; Room setup routine (bank $8F)

; Room $9879 state $98C4: Header
; (event bit 0eh)
org $8F98C4
dl $C3E16E   ; Level data address
db $02       ; Tileset
db $00       ; Music data index
db $00       ; Music track index
; dw $8040     ; FX address (bank $83)
dw $81C0
dw $8F16     ; Enemy population offset (bank $A1)
dw $82B5     ; Enemy graphics set offset (bank $B4)
dw $C1C1     ; Layer 2 scroll
dw $0000     ; Room scroll data (bank $8F)
dw $0000     ; Room var
; dw $C124     ; Room main routine (bank $8F)
dw $0000
dw $8428     ; Room PLM list address (bank $8F)
dw $B8EA     ; Library background (bank $8F)
dw $91BB     ; Room setup routine (bank $8F)
dw $91D4

; Room $9879 state $9890: Enemy population
org $A18364
;  enemy  x      y      init   props  extra  param1 param2
dw $D0FF, $00ED, $0061, $0000, $2000, $0000, $0000, $0000 ; mero
dw $D0FF, $015E, $005C, $0000, $2000, $0000, $0000, $0000 ; mero
dw $D0FF, $011B, $0060, $0000, $2000, $0000, $0000, $0000 ; mero
dw $D0FF, $0132, $0049, $0000, $2000, $0000, $0000, $0000 ; mero
dw $D0FF, $013A, $0065, $0000, $2000, $0000, $0000, $0000 ; mero
dw $D0FF, $00EA, $0042, $0000, $2000, $0000, $0000, $0000 ; mero
dw $D0FF, $01CA, $006B, $0000, $2000, $0000, $0000, $0000 ; mero
dw $D0FF, $0100, $0076, $0000, $2000, $0000, $0000, $0000 ; mero
dw $D0FF, $019A, $0058, $0000, $2000, $0000, $0000, $0000 ; mero
dw $D0FF, $0190, $007E, $0000, $2000, $0000, $0000, $0000 ; mero
dw $D0FF, $017F, $003E, $0000, $2000, $0000, $0000, $0000 ; mero
dw $D0FF, $01C2, $0041, $0000, $2000, $0000, $0000, $0000 ; mero
dw $FFFF     ; end of list
db $00       ; death quota

; Room $9879 state $98AA: Enemy population
org $A18364
;  enemy  x      y      init   props  extra  param1 param2
dw $D0FF, $00ED, $0061, $0000, $2000, $0000, $0000, $0000 ; mero
dw $D0FF, $015E, $005C, $0000, $2000, $0000, $0000, $0000 ; mero
dw $D0FF, $011B, $0060, $0000, $2000, $0000, $0000, $0000 ; mero
dw $D0FF, $0132, $0049, $0000, $2000, $0000, $0000, $0000 ; mero
dw $D0FF, $013A, $0065, $0000, $2000, $0000, $0000, $0000 ; mero
dw $D0FF, $00EA, $0042, $0000, $2000, $0000, $0000, $0000 ; mero
dw $D0FF, $01CA, $006B, $0000, $2000, $0000, $0000, $0000 ; mero
dw $D0FF, $0100, $0076, $0000, $2000, $0000, $0000, $0000 ; mero
dw $D0FF, $019A, $0058, $0000, $2000, $0000, $0000, $0000 ; mero
dw $D0FF, $0190, $007E, $0000, $2000, $0000, $0000, $0000 ; mero
dw $D0FF, $017F, $003E, $0000, $2000, $0000, $0000, $0000 ; mero
dw $D0FF, $01C2, $0041, $0000, $2000, $0000, $0000, $0000 ; mero
dw $FFFF     ; end of list
db $00       ; death quota

; Room $9879 state $98C4: Enemy population
org $A18F16
;  enemy  x      y      init   props  extra  param1 param2
dw $FFFF     ; end of list
db $00       ; death quota

; Room $9879 state $9890: Enemy graphics set
org $B4807D
;  enemy  palette
dw $D63F, $0001 ; waver
dw $D0FF, $0002 ; mero
dw $FFFF     ; end of list

; Room $9879 state $98AA: Enemy graphics set
org $B4807D
;  enemy  palette
dw $D63F, $0001 ; waver
dw $D0FF, $0002 ; mero
dw $FFFF     ; end of list

; Room $9879 state $98C4: Enemy graphics set
org $B482B5
;  enemy  palette
dw $FFFF     ; end of list

; Room $9879 state $9890: FX
org $8381C0
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $FFFF, $FFFF, $0000, $07E0 : db $FF, $FF, $00, $00, $00, $04, $02, $1E
dw $0040, $4802, $0000, $FFFF : db $FF, $FF, $00, $00, $00, $00, $28, $02
dw $0000, $6200, $0000, $FFFF : db $FF, $FF, $00, $00, $00, $00, $28, $02

; Room $9879 state $98AA: FX
org $8381C0
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $FFFF, $FFFF, $0000, $07E0 : db $FF, $FF, $00, $00, $00, $04, $02, $1E
dw $0040, $4802, $0000, $FFFF : db $FF, $FF, $00, $00, $00, $00, $28, $02
dw $0000, $6200, $0000, $FFFF : db $FF, $FF, $00, $00, $00, $00, $28, $02

; Room $9879 state $98C4: FX
org $838040
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $FFFF, $FFFF, $0000 : db $00, $00, $02, $02, $00, $00, $00, $00
