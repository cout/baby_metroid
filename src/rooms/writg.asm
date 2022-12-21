; Room $B4AD: Header
org $8FB4AD
db $41       ; Index
db $02       ; Area
db $1E       ; X position on map
db $09       ; Y position on map
db $01       ; Width (in screens)
db $06       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $B4D4     ; Special graphics bits
dw $E5E6     ; State $B4BA function (default)

; Room $B4AD state $B4BA: Header
org $8FB4BA
dl $C984D3   ; Level data address
db $09       ; Tileset
db $00       ; Music data index
db $00       ; Music track index
dw $882C     ; FX address (bank $83)
dw $A82E     ; Enemy population offset (bank $A1)
dw $87F5     ; Enemy graphics set offset (bank $B4)
dw $C1C1     ; Layer 2 scroll
dw $B4DA     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $8F3C     ; Room PLM list address (bank $8F)
dw $BEFC     ; Library background (bank $8F)
dw $91F7     ; Room setup routine (bank $8F)

; Room $B4AD state $B4BA: Enemy population
org $A1A82E
;  enemy  x      y      init   props  extra  param1 param2
; dw $E73F, $00DA, $0577, $0000, $A000, $0000, $1001, $4007 ; namihe
; dw $F413, $00D0, $04F8, $0000, $2000, $0004, $0001, $00A0 ; batta1Na (lower norfair gold wall pirate)
; dw $F413, $0030, $0490, $0000, $2000, $0004, $0000, $00A0 ; batta1Na (lower norfair gold wall pirate)
; dw $F413, $00D0, $0440, $0000, $2000, $0004, $0001, $00A0 ; batta1Na (lower norfair gold wall pirate)
; dw $E73F, $0027, $0320, $0000, $A000, $0000, $1011, $4007 ; namihe
; dw $F713, $0030, $02B0, $0000, $2000, $0004, $0000, $0001 ; batta3Na (lower norfair gold walking pirate)
; dw $E73F, $00DA, $0388, $0000, $A000, $0000, $1001, $4007 ; namihe
; dw $F713, $00D0, $02E0, $0000, $2000, $0004, $0000, $0000 ; batta3Na (lower norfair gold walking pirate)
; dw $E73F, $00DA, $0240, $0000, $A000, $0000, $1001, $4007 ; namihe
; dw $E73F, $0027, $01E0, $0000, $A000, $0000, $1011, $4007 ; namihe
; dw $F713, $0080, $0170, $0000, $2000, $0004, $0000, $0010 ; batta3Na (lower norfair gold walking pirate)
dw $E9BF, $00DA, $0577, $0000, $2800, $0000, $0000, $0000 ; seahorse
dw $E9BF, $0027, $0320, $0000, $2800, $0000, $0000, $0000 ; seahorse
dw $E9BF, $00DA, $0388, $0000, $2800, $0000, $0000, $0000 ; seahorse
dw $E9BF, $00DA, $0240, $0000, $2800, $0000, $0000, $0000 ; seahorse
dw $E9BF, $0027, $01E0, $0000, $2800, $0000, $0000, $0000 ; seahorse
dw $D8FF, $0080, $0170, $0000, $2000, $0000, $0000, $0000 ; mochtroid
dw $D8FF, $00D0, $04F8, $0000, $2000, $0000, $0000, $0000 ; mochtroid
dw $D8FF, $0030, $0490, $0000, $2000, $0000, $0000, $0000 ; mochtroid
dw $D8FF, $00D0, $0440, $0000, $2000, $0000, $0000, $0000 ; mochtroid
dw $D8FF, $0030, $02B0, $0000, $2000, $0000, $0000, $0000 ; mochtroid
dw $D8FF, $00D0, $02E0, $0000, $2000, $0000, $0000, $0000 ; mochtroid
dw $D8FF, $0080, $0170, $0000, $2000, $0000, $0000, $0000 ; mochtroid
dw $FFFF     ; end of list
db $0B       ; death quota

; Room $B4AD state $B4BA: Enemy graphics set
org $B487F5
;  enemy  palette
; dw $E73F, $0001 ; namihe
; dw $F413, $0002 ; batta1Na (lower norfair gold wall pirate)
; dw $F713, $0003 ; batta3Na (lower norfair gold walking pirate)
dw $E9BF, $0001 ; seahorse
dw $D8FF, $0002 ; mochtroid
dw $FFFF     ; end of list
