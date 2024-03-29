%BEGIN_FREESPACE(B8)

below_landing_site_level_data:
incbin "below_landing_site.bin"

%END_FREESPACE(B8)


%BEGIN_FREESPACE(8F)

below_landing_site_header:
{

; Room $91F8: Header
db $00                                   ; Index
db $00                                   ; Area
db $1A                                   ; X position on map
db $02                                   ; Y position on map
db $05                                   ; Width (in screens)
db $07                                   ; Height (in screens)
db $70                                   ; Up scroller
db $A0                                   ; Down scroller
db $00                                   ; Special graphics bits
dw below_landing_site_doors              ; Door out
dw $E5E6                                 ; State $9213 function (default)

below_landing_site_state_header:
dl below_landing_site_level_data         ; Level data address
db $00                                   ; Tileset
db $0C                                   ; Music data index - TODO
db $05                                   ; Music track index - TODO
dw below_landing_site_fx                 ; FX address (bank $83)
dw below_landing_site_enemy_population   ; Enemy population offset (bank $A1)
dw below_landing_site_enemy_graphics_set ; Enemy graphics set offset (bank $B4)
dw $0000                                 ; Layer 2 scroll - TODO
dw below_landing_site_room_scroll_data   ; Room scroll data (bank $8F)
dw $0000                                 ; Room var
dw below_landing_site_main               ; Room main routine (bank $8F)
dw below_landing_site_room_plms          ; Room PLM list address (bank $8F)
; dw below_spazer_library_background       ; Library background (bank $8F) - TODO
dw $0000
dw below_landing_site_setup              ; Room setup routine (bank $8F)

below_landing_site_room_scroll_data:
{
  db 00, 00, 00, 01, 01
  db 00, 00, 00, 01, 01
  db 00, 00, 00, 01, 01
  db 00, 00, 00, 01, 01
  db 01, 01, 01, 01, 01
  db 01, 01, 01, 01, 01
  db 01, 01, 01, 01, 01
}

below_spazer_library_background:
{
  ; original:
  ;  cmd    door       source       dest   size
  ; dw $000E, $8946 : dl $8AC180 : dw $4800, $0800 ; from gauntlet
  ; dw $000E, $896A : dl $8AD180 : dw $4800, $0800 ; from parlor
  ; dw $000E, $89B2 : dl $8AB980 : dw $4C00, $0800 ; from crateria pbs
  ; dw $000E, $8AC6 : dl $8AD180 : dw $4800, $0800 ; from crateria tube
  ; dw $000E, $88FE : dl $8AB180 : dw $4800, $0800 ; from ceres
  ; dw $000E, $890A : dl $8AC180 : dw $4800, $0800 ; demo

  ; This almost works, but it's off by one screen
  ; dw $000E, bomb_torizo_animals_escape_door : dl $8AD180 : dw $4800, $0800 ; from parlor

  dw $000A ; clear layer 2

  dw $0000
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

%END_FREESPACE(8F)

%BEGIN_FREESPACE(A1)

below_landing_site_enemy_population:
{

; Room $91F8 state $9213: Enemy population
;  enemy  x      y      init   props  extra  param1 param2
dw $D07F, $0180, $0678, $0000, $2400, $0000, $0000, $0000 ; gunship top
dw $D0BF, $0180, $0678, $0000, $2400, $0000, $0000, $0000 ; gunship bottom
dw $D0BF, $0180, $0678, $0000, $2400, $0000, $0000, $0001 ; gunship bottom
dw !baby_top, $0180, $0660, $0000, $2C00, $0000, $0000, $0000 ; baby
dw $FFFF     ; end of list
db $00       ; death quota

}

%END_FREESPACE(A1)

%BEGIN_FREESPACE(B4)

below_landing_site_enemy_graphics_set:
{

; Room $91F8 state $9213: Enemy graphics set
;  enemy  palette
dw !baby_top, $0000 ; baby
dw $D07F, $0002 ; gunship top
dw $D0BF, $0007 ; gunship bottom
dw $FFFF     ; end of list

}

%END_FREESPACE(B4)

%BEGIN_FREESPACE(83)

below_landing_site_fx:
{

; Room $91F8 state $9213: FX
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $FFFF, $FFFF, $0000 : db $00, $00, $02, $02, $00, $00, $00, $00

}

%END_FREESPACE(83)
