; Room $B6C1: Header
org $8FB6C1
db $4A       ; Index
db $02       ; Area
db $14       ; X position on map
db $0E       ; Y position on map
db $01       ; Width (in screens)
db $03       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $B6E8     ; Door out
dw $E5E6     ; State $B6CE function (default)

; Room $B6C1 state $B6CE: Header
; (default)
org $8FB6CE
dl $C9C428   ; Level data address
db $09       ; Tileset
db $00       ; Music data index
db $03       ; Music track index
dw $88CC     ; FX address (bank $83)
; dw $AEAE     ; Enemy population offset (bank $A1)
; dw $88FD     ; Enemy graphics set offset (bank $B4)
dw screw_attack_enemy_population
dw screw_attack_enemy_graphics_set
dw $C101     ; Layer 2 scroll
dw $0000     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $9110     ; Room PLM list address (bank $8F)
dw $BF32     ; Library background (bank $8F)
dw $91F7     ; Room setup routine (bank $8F)

%BEGIN_FREESPACE(A1)

screw_attack_enemy_population:
; Room $B6C1 state $B6CE: Enemy population
;org $A1AEAE
;  enemy      x      y      init   props  extra  param1 param2
dw hatchling, $00CC, $026B, $0000, $A400, $0000, $0E06, $0000
dw $FFFF     ; end of list
db $00       ; death quota

%END_FREESPACE(A1)

%BEGIN_FREESPACE(B4)

screw_attack_enemy_graphics_set:
; Room $B6C1 state $B6CE: Enemy graphics set
;org $B488FD
;  enemy  palette
dw hatchling, $0001
dw $FFFF     ; end of list

%END_FREESPACE(B4)

; Room $B6C1 state $B6CE: FX
org $8388CC
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $02DD, $FFFF, $0000 : db $00, $04, $02, $1E, $82, $1F, $00, $00

; Room $B6C1 state $B6CE: PLM
org $839110
;  plm_id y/x    param
dw $EF73, $280B, $004F
dw $0000     ; end of list
