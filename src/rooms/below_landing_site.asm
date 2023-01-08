org !FREESPACE_B8

below_landing_site_level_data:
incbin "below_landing_site.bin"

end_below_landing_site_freespace_b8:
!FREESPACE_B8 := end_below_landing_site_freespace_b8


org !FREESPACE_8F

below_landing_site_header:
{

; Room $91F8: Header
db $00                                   ; Index
db $00                                   ; Area
db $1A                                   ; X position on map
db $02                                   ; Y position on map
db $05                                   ; Width (in screens)
db $06                                   ; Height (in screens)
db $70                                   ; Up scroller
db $A0                                   ; Down scroller
db $00                                   ; Special graphics bits
dw below_landing_site_doors              ; Door out
dw $E5E6                                 ; State $9213 function (default)

below_landing_site_state_header:
dl below_landing_site_level_data         ; Level data address
db $00                                   ; Tileset
db $06                                   ; Music data index - TODO
db $05                                   ; Music track index - TODO
dw below_landing_site_fx                 ; FX address (bank $83)
dw below_landing_site_enemy_population   ; Enemy population offset (bank $A1)
dw below_landing_site_enemy_graphics_set ; Enemy graphics set offset (bank $B4)
dw $0181                                 ; Layer 2 scroll - TODO
dw below_landing_site_room_scroll_data   ; Room scroll data (bank $8F)
dw $0000                                 ; Room var
dw below_landing_site_main               ; Room main routine (bank $8F)
dw below_landing_site_room_plms          ; Room PLM list address (bank $8F)
dw $B76A                                 ; Library background (bank $8F) - TODO
dw below_landing_site_setup              ; Room setup routine (bank $8F)

below_landing_site_room_scroll_data:
{
  db 00, 00, 00, 02, 02
  db 00, 00, 00, 02, 02
  db 00, 00, 00, 02, 02
  db 01, 01, 01, 01, 01
  db 01, 01, 01, 01, 01
  db 01, 01, 01, 01, 01
}

below_landing_site_setup:
{
  RTS
}

below_landing_site_main:
{
  RTS
}

below_landing_site_doors:
{
}

below_landing_site_room_plms:
{
  dw $B703,$281E,$92B0 ; scroll
  dw $B647,$271E,$8000 ; downward extension
  dw $B647,$261E,$8000 ; downward extension
  dw $B647,$251E,$8000 ; downward extension
  ; dw $C872,$468E,$0000 ; green door facing left
  ; dw $C85A,$168E,$0001 ; yellow door facing left
  dw $0000
}

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
