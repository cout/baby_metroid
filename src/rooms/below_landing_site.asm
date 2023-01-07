org !FREESPACE_B8

below_landing_site_level_data:
incbin "below_landing_site.bin"

end_below_landing_site_freespace_b8:
!FREESPACE_B8 := end_below_landing_site_freespace_b8


org !FREESPACE_8F

below_landing_site_header:
{

; Room $91F8: Header
db $00       ; Index
db $00       ; Area
db $17       ; X position on map - TODO
db $00       ; Y position on map - TODO
db $09       ; Width (in screens)
db $05       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $927B     ; Door out - TODO
dw $E5E6     ; State $9213 function (default)

below_landing_site_state_header:
dl below_landing_site_level_data ; Level data address
db $00       ; Tileset
db $06       ; Music data index
db $05       ; Music track index
; dw $80C0     ; FX address (bank $83)
; dw $883D     ; Enemy population offset (bank $A1)
; dw $8193     ; Enemy graphics set offset (bank $B4)
dw below_landing_site_fx ; FX address (bank $83)
dw below_landing_site_enemy_population ; Enemy population offset (bank $A1)
dw below_landing_site_enemy_graphics_set ; Enemy graphics set offset (bank $B4)
dw $0181     ; Layer 2 scroll
dw $9283     ; Room scroll data (bank $8F) - TODO
dw $0000     ; Room var
dw $C116     ; Room main routine (bank $8F) - TODO
dw $8000     ; Room PLM list address (bank $8F)
dw $B76A     ; Library background (bank $8F) - TODO
dw $91C9     ; Room setup routine (bank $8F) - TODO

}

end_below_landing_site_freespace_8f:
!FREESPACE_8F := end_below_landing_site_freespace_8f

org !FREESPACE_A1

below_landing_site_enemy_population:
{

; Room $91F8 state $9213: Enemy population
;  enemy  x      y      init   props  extra  param1 param2
; dw $D07F, $0480, $0478, $0000, $2400, $0000, $0000, $0000 ; gunship top
; dw $D0BF, $0480, $0478, $0000, $2400, $0000, $0000, $0000 ; gunship bottom
; dw $D0BF, $0480, $0478, $0000, $2400, $0000, $0000, $0001 ; gunship bottom
dw $FFFF     ; end of list
db $00       ; death quota

}

end_below_landing_site_freespace_a1:
!FREESPACE_A1 := end_below_landing_site_freespace_a1

org !FREESPACE_B4

below_landing_site_enemy_graphics_set:
{

; Room $91F8 state $9213: Enemy graphics set
;  enemy  palette
; dw $D07F, $0002 ; gunship top
; dw $D0BF, $0007 ; gunship bottom
dw $FFFF     ; end of list

}
end_below_landing_site_freespace_b4:
!FREESPACE_B4 := end_below_landing_site_freespace_b4

org !FREESPACE_83

below_landing_site_fx:
{

; Room $91F8 state $9213: FX
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $FFFF, $FFFF, $0000 : db $00, $0A, $02, $0E, $00, $01, $00, $22

}

end_below_landing_site_freespace_83:
!FREESPACE_83 := end_below_landing_site_freespace_83
