; Room $B32E: Header
org $8FB32E
db $3A       ; Index
db $02       ; Area
db $17       ; X position on map
db $10       ; Y position on map
db $01       ; Width (in screens)
db $02       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $B374     ; Door out
dw $E629     ; State $B35A function (boss)
db $01       ; Boss
dw $B35A     ; State header address
dw $E5E6     ; State $B340 function (default)

; Room $B32E state $B340: Header
; (default)
org $8FB340
dl $C8EBFD   ; Level data address
db $09       ; Tileset
db $24       ; Music data index
db $04       ; Music track index
dw $87BC     ; FX address (bank $83)
dw $A626     ; Enemy population offset (bank $A1)
dw $8781     ; Enemy graphics set offset (bank $B4)
dw $C101     ; Layer 2 scroll
dw $B378     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $E950     ; Room main routine (bank $8F)
; dw $8E98     ; Room PLM list address (bank $8F)
dw ridley_boss_fight_room_plm_list
dw $BF32     ; Library background (bank $8F)
dw $91F7     ; Room setup routine (bank $8F)

; Room $B32E state $B35A: Header
; (boss bit 01h)
org $8FB35A
dl $C8EBFD   ; Level data address
db $09       ; Tileset
db $00       ; Music data index
db $03       ; Music track index
dw $87BC     ; FX address (bank $83)
dw $A626     ; Enemy population offset (bank $A1)
dw $8781     ; Enemy graphics set offset (bank $B4)
dw $C101     ; Layer 2 scroll
dw $B378     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $E950     ; Room main routine (bank $8F)
dw $8E98     ; Room PLM list address (bank $8F)
dw $BF32     ; Library background (bank $8F)
dw $91F7     ; Room setup routine (bank $8F)

; Room $B32E state $B340: Enemy population
; Room $B32E state $B35A: Enemy population
org $A1A626
;  enemy  x      y      init   props  extra  param1 param2
dw $E17F, $0030, $FFF0, $0000, $2800, $0000, $0000, $0000 ; ridley
dw $FFFF     ; end of list
db $00       ; death quota

; Room $B32E state $B340: Enemy graphics set
; Room $B32E state $B35A: Enemy graphics set
org $B48781
;  enemy  palette
dw $E17F, $0001 ; ridley
dw $E1BF, $E001 ; ridley explosion
dw $FFFF     ; end of list

; Room $B32E state $B340: FX
; Room $B32E state $B35A: FX
org $8387BC
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $0210, $01D0, $0000 : db $00, $04, $02, $1E, $82, $1F, $00, $00

org !FREESPACE_8F

ridley_boss_fight_room_plm_list:
{
  ; dw $C842, $060E, $005A ; grey door facing left
  dw $C842, $060E, $065A ; grey door facing left
  dw $C848, $1601, $005B ; grey door facing right
  dw $0000
}

end_ridley_room_freesapce_8f:
!FREESPACE_8F := end_ridley_room_freesapce_8f
