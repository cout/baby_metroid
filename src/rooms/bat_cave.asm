org $C8BB21
incbin "bat_cave.bin"
warnpc $C8C121

; Room $B07A: Header
org $8FB07A
db $2D       ; Index
db $02       ; Area
db $18       ; X position on map
db $01       ; Y position on map
db $01       ; Width (in screens)
db $02       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $B0A1     ; Door out
dw $E5E6     ; State $B087 function (default)

; Room $B07A state $B087: Header
; (default)
org $8FB087
dl $C8BB21   ; Level data address
db $09       ; Tileset
db $00       ; Music data index
db $05       ; Music track index
dw $8730     ; FX address (bank $83)
dw $B912     ; Enemy population offset (bank $A1)
dw $8ACD     ; Enemy graphics set offset (bank $B4)
dw $0000     ; Layer 2 scroll
dw $B0A5     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
; dw $8DA6     ; Room PLM list address (bank $8F)
dw bat_cave_room_plm_list
dw $0000     ; Library background (bank $8F)
dw $91F6     ; Room setup routine (bank $8F)

; Room $B07A state $B087: Enemy population
org $A1B912
;  enemy  x      y      init   props  extra  param1 param2
; dw $F213, $0060, $00B0, $0000, $6800, $0000, $0000, $2020 ; gamet
; dw $F213, $0060, $00B0, $0000, $6800, $0000, $0000, $2000 ; gamet
; dw $F213, $0060, $00B0, $0000, $6800, $0000, $0000, $2000 ; gamet
; dw $F213, $0060, $00B0, $0000, $6800, $0000, $0000, $2000 ; gamet
; dw $F213, $0060, $00B0, $0000, $6800, $0000, $0000, $2000 ; gamet
; dw $DB7F, $00C8, $0148, $0000, $2000, $0000, $0000, $0000 ; skree
; dw $DB7F, $00A8, $0140, $0000, $2000, $0000, $0000, $0000 ; skree
; dw $DB7F, $0080, $0138, $0000, $2000, $0000, $0000, $0000 ; skree
dw !samus_statue, $00A0, $0194, $0000, $2400, $0000, $0000, $0002
dw $FFFF     ; end of list
db $04       ; death quota

; Room $B07A state $B087: Enemy graphics set
org $B48ACD
;  enemy  palette
; dw $F213, $0001 ; gamet
; dw $DB7F, $0002 ; skree
dw !samus_statue, $0002, $FFFF
dw $FFFF     ; end of list

; Room $B07A state $B087: FX
org $838730
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $01B4, $FFFF, $0000 : db $00, $02, $02, $1E, $03, $1F, $00, $02

%BEGIN_FREESPACE(8F)

bat_cave_room_plm_list:

; Room $B07A state $B087: PLM
; org $8F8DA6
;  plm_id y/x    param
dw $B703, $0C08, $B0A7 ; scroll plm
dw $B63B, $0C09, $8000 ; rightward extension
dw $B63B, $0C0A, $8000 ; rightward extension
dw $B703, $1008, $B0AC ; scroll plm
dw $B63B, $1009, $8000 ; rightward extension
dw $B63B, $100A, $8000 ; rightward extension
dw $B703, $1306, $B0B1 ; scroll plm
dw $B63B, $1307, $8000 ; rightward extension
dw $B63B, $1308, $8000 ; rightward extension
dw $B63B, $1309, $8000 ; rightward extension
dw $0000     ; end of list

%END_FREESPACE(8F)
