org $C6D620
incbin "kraid.bin"
warnpc $C6DE20

; Room $A59F: Header
org $8FA59F
db $2F       ; Index
db $01       ; Area
db $37       ; X position on map
db $12       ; Y position on map
db $02       ; Width (in screens)
db $02       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $05       ; Special graphics bits
dw $A5E5     ; Door out
dw $E629     ; State $A5CB function (boss)
db $01       ; Boss
dw $A5CB     ; State header address
dw $E5E6     ; State $A5B1 function (default)

; Room $A59F state $A5B1: Header
; (default)
org $8FA5B1
dl $C6D620   ; Level data address
db $1A       ; Tileset
db $27       ; Music data index
db $03       ; Music track index
dw $83F4     ; FX address (bank $83)
dw $9EB5     ; Enemy population offset (bank $A1)
dw $85EF     ; Enemy graphics set offset (bank $B4)
dw $0101     ; Layer 2 scroll
dw $A5E9     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $8A2E     ; Room PLM list address (bank $8F)
dw $B815     ; Library background (bank $8F)
dw $91D6     ; Room setup routine (bank $8F)

; Room $A59F state $A5CB: Header
; (boss bit 01h)
org $8FA5CB
dl $C6D620   ; Level data address
db $1A       ; Tileset
db $00       ; Music data index
db $00       ; Music track index
dw $83F4     ; FX address (bank $83)
dw $9EB5     ; Enemy population offset (bank $A1)
dw $85EF     ; Enemy graphics set offset (bank $B4)
dw $0101     ; Layer 2 scroll
dw $A5E9     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $8A2E     ; Room PLM list address (bank $8F)
dw $B840     ; Library background (bank $8F)
dw $91D6     ; Room setup routine (bank $8F)

; Room $A59F state $A5B1: Enemy population
; Room $A59F state $A5CB: Enemy population
org $A19EB5
;  enemy  x      y      init   props  extra  param1 param2
dw $E2BF, $0100, $0218, $0000, $0D00, $0004, $0000, $0000 ; kraid
dw $E2FF, $00E8, $01E8, $0000, $2800, $0004, $0000, $0001 ; kraid arm
dw $E33F, $00C8, $0210, $0000, $A800, $0000, $0000, $0000 ; kraid lint
dw $E37F, $00B0, $0250, $0000, $A800, $0000, $0000, $0001 ; kraid lint
dw $E3BF, $00B2, $0288, $0000, $A800, $0000, $0000, $0002 ; kraid lint
dw $E3FF, $0100, $0278, $0000, $2C00, $0004, $0000, $0003 ; kraid foot
dw $E43F, $00E8, $01E8, $0000, $6800, $0000, $0000, $0000 ; kraid fingernail
dw $E47F, $00E8, $01E8, $0000, $6800, $0000, $0000, $0000 ; kraid fingernail
dw $FFFF     ; end of list
db $00       ; death quota

; Room $A59F state $A5B1: Enemy graphics set
; Room $A59F state $A5CB: Enemy graphics set
org $B485EF
;  enemy  palette
dw $E2BF, $0007 ; kraid
dw $FFFF     ; end of list

; Room $A59F state $A5B1: FX
; Room $A59F state $A5CB: FX
org $8383F4
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $FFFF, $0000, $FFFF, $FFFF : db $00, $00, $00, $0C, $02, $30, $00, $80
dw $6200, $FFFF, $FFFF, $0000 : db $B0, $00, $FF, $01, $00, $00, $00, $26
dw $1802, $0001, $4800, $0000 : db $FF, $FF, $FF, $FF, $00, $00, $00, $00
dw $022A, $0000, $0000, $FFFF : db $FF, $FF, $FF, $FF, $00, $00, $B8, $00
dw $FFFF, $0000, $0200, $1E02 : db $0B, $1F, $02, $02, $00, $00, $B1, $01
dw $FFFF, $0000, $0200, $1E02 : db $0B, $1F, $00, $02, $00, $00, $D0, $01
dw $FFFF, $0000, $0200, $1E02 : db $0B, $1F, $03, $02, $00, $00, $FF, $FF
dw $FFFF, $0000, $0200, $1E02 : db $00, $00, $00, $02, $00, $00, $FF, $FF
dw $FFFF, $0000, $0000, $0202 : db $00, $00, $00, $00, $00, $00, $B2, $00
dw $FFFF, $0000, $0200, $1E02 : db $0B, $1F, $00, $02, $00, $00, $FF, $FF
dw $FFFF, $0000, $0200, $1E02 : db $00, $00, $00, $02, $00, $00, $B8, $02
dw $FFFF, $0000, $0200, $1E02 : db $03, $1F, $03, $02, $00, $00, $FF, $FF
dw $FFFF, $0000, $0200, $1E02 : db $03, $1F, $00, $02, $00, $00, $FF, $FF
dw $FFFF, $0000, $0200, $1E02 : db $0B, $1F, $02, $02, $00, $00, $C6, $00
dw $FFFF, $0000, $0400, $1E02 : db $81, $00, $01, $02, $00, $00, $FF, $FF
dw $FFFF, $0000, $0200, $1E02 : db $01, $00, $00, $02, $00, $00, $B8, $01
dw $FFFF, $0000, $0200, $1E02 : db $0B, $1F, $00, $02, $00, $00, $FF, $FF
dw $FFFF, $0000, $0200, $1E02 : db $01, $00, $00, $02, $00, $00, $FF, $FF
dw $FFFF, $0000, $0000, $0202 : db $03, $00, $00, $02, $00, $00, $FF, $FF
dw $FFFF, $0000, $0200, $1E02 : db $01, $00, $00, $02, $00, $00, $FF, $FF
dw $FFFF, $0000, $0200, $1E02 : db $03, $1F, $00, $02, $00, $00, $FF, $FF
dw $FFFF, $0000, $0000, $0202 : db $00, $00, $00, $00, $00, $00, $C8, $00
dw $FFFF, $0000, $0400, $1E02 : db $41, $00, $02, $00, $00, $00, $B8, $00
dw $FFFF, $0000, $0600, $1802 : db $83, $00, $00, $48, $00, $00, $B4, $02
dw $FFFF, $0000, $0400, $1E02 : db $80, $00, $00, $00, $00, $00, $FF, $FF
dw $FFFF, $0000, $0000, $0202 : db $00, $00, $00, $00, $00, $00, $C0, $00
dw $FFFF, $0000, $0600, $1802 : db $83, $00, $00, $48, $00, $00, $FF, $FF
dw $FFFF, $0000, $0000, $0202 : db $00, $00, $03, $00, $00, $00, $C7, $00
dw $FFFF, $0000, $0200, $1E02 : db $0B, $1F, $00, $02, $00, $00, $C6, $00
dw $FFFF, $0000, $0200, $1E02 : db $0B, $1F, $00, $02, $00, $00, $FF, $FF
dw $FFFF, $0000, $0200, $1E02 : db $03, $00, $02, $02, $BE, $95, $DA, $01
dw $00B0, $0000, $02F0, $1E02 : db $0B, $1F, $02, $02, $00, $00, $DA, $01
dw $FFFF, $0000, $0200, $1E02 : db $0B, $1F, $02, $02, $00, $00, $DA, $00
dw $0000, $0000, $0220, $1E02 : db $0B, $1F, $00, $02, $00, $00, $FF, $FF
