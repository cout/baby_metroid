org !FREESPACE_B8

phantoon_level_data:
incbin "phantoon.bin"

end_phantoon_freespace_b8:
!FREESPACE_B8 := end_phantoon_freespace_b8

; Room $CD13: Header
org $8FCD13
db $0A       ; Index
db $03       ; Area
db $13       ; X position on map
db $13       ; Y position on map
db $02       ; Width (in screens)
db $01       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $CD59     ; Door out
dw $E629     ; State $CD3F function (boss)
db $01       ; Boss
dw $CD3F     ; State header address
dw $E5E6     ; State $CD25 function (default)

; Room $CD13 state $CD25: Header
; (default)
org $8FCD25
; dl $C4E58C   ; Level data address
dl phantoon_level_data
db $05       ; Tileset
db $27       ; Music data index
db $06       ; Music track index
dw $9C44     ; FX address (bank $83)
dw $CCD4     ; Enemy population offset (bank $A1)
dw $8D1D     ; Enemy graphics set offset (bank $B4)
dw $0101     ; Layer 2 scroll
; dw $CD5B     ; Room scroll data (bank $8F)
dw phantoon_room_scroll ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
; dw $C2B3     ; Room PLM list address (bank $8F)
dw phantoon_room_plm_list ; Room PLM list address (bank $8F)
dw $E0FD     ; Library background (bank $8F)
dw $C8D0     ; Room setup routine (bank $8F)

; Room $CD13 state $CD3F: Header
; (boss bit 01h)
org $8FCD3F
; dl $C4E58C   ; Level data address
dl phantoon_level_data
db $04       ; Tileset
db $00       ; Music data index
db $03       ; Music track index
dw $9B62     ; FX address (bank $83)
dw $C1E4     ; Enemy population offset (bank $A1)
dw $8C1D     ; Enemy graphics set offset (bank $B4)
dw $0101     ; Layer 2 scroll
; dw $CD5B     ; Room scroll data (bank $8F)
dw phantoon_room_scroll ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
; dw $C2B3     ; Room PLM list address (bank $8F)
dw phantoon_room_plm_list ; Room PLM list address (bank $8F)
dw $E113     ; Library background (bank $8F)
dw $C8D0     ; Room setup routine (bank $8F)

; Room $CD13 state $CD25: Enemy population
org $A1CCD4
;  enemy  x      y      init   props  extra  param1 param2
dw $E4BF, $0080, $0060, $0000, $2800, $0004, $0000, $0000 ; phantoon
dw $E4FF, $0080, $0060, $0000, $2C00, $0004, $0000, $0001 ; phantoon
dw $E53F, $0080, $0060, $0000, $2C00, $0004, $0000, $0002 ; phantoon
dw $E57F, $0080, $0060, $0000, $2C00, $0004, $0000, $0003 ; phantoon
dw $FFFF     ; end of list
db $00       ; death quota

; Room $CD13 state $CD3F: Enemy population
org $A1C1E4
;  enemy  x      y      init   props  extra  param1 param2
dw $FFFF     ; end of list
db $00       ; death quota

; Room $CD13 state $CD25: Enemy graphics set
org $B48D1D
;  enemy  palette
dw $E4BF, $0007 ; phantoon
dw $FFFF     ; end of list

; Room $CD13 state $CD3F: Enemy graphics set
org $B48C1D
;  enemy  palette
dw $FFFF     ; end of list

; Room $CD13 state $CD25: FX
org $839C44
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $FFFF, $FFFF, $0000 : db $00, $00, $02, $02, $00, $00, $00, $00

; Room $CD13 state $CD3F: FX
org $839B62
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $FFFF, $0000, $00A8, $FFFF : db $00, $00, $00, $06, $02, $18, $03, $00
dw $4800, $0000, $FFFF, $FFFF : db $00, $00, $00, $00, $02, $02, $00, $01
dw $0000, $0000, $FFFF, $FFFF : db $00, $00, $00, $00, $02, $02, $00, $01

; new scroll data

org !FREESPACE_8F

phantoon_room_plm_list:
{
  dw $C848, $0601, $0086 ; grey door PLM
  dw $B703, $0C10, phantoon_room_plm_scroll_1 ; scroll PLM
  dw $B703, $0C0D, phantoon_room_plm_scroll_2 ; scroll PLM
  dw power_control_plm, $0B17, $0045 ; power control
  dw $0000
}

phantoon_room_plm_scroll_1: db $01, $01, $80
phantoon_room_plm_scroll_2: db $01, $00, $80
phantoon_room_scroll: db $01, $00

end_phantoon_room_freespace_8f:
!FREESPACE_8F := end_phantoon_room_freespace_8f
