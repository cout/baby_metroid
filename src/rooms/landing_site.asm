if !USE_BELOW_LANDING_SITE

org !FREESPACE_B8

escape_landing_site_level_data:
incbin "escape_landing_site.bin"

end_landing_site_freespace_b8:
!FREESPACE_B8 := end_landing_site_freespace_b8

else

escape_landing_site_level_data = $C2C2BB

endif


; Room $91F8: Header
org $8F91F8
db $00       ; Index
db $00       ; Area
db $17       ; X position on map
db $00       ; Y position on map
db $09       ; Width (in screens)
db $05       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $927B     ; Door out
dw $E612     ; State $9261 function (event)
db $0E       ; Event
dw $9261     ; State header address
dw $E669     ; State $9247 function (pbs)
dw $9247     ; State header address
dw $E612     ; State $922D function (event)
db $00       ; Event
dw $922D     ; State header address
dw $E5E6     ; State $9213 function (default)

; Room $91F8 state $9213: Header
; (default)
org $8F9213
dl $C2C2BB   ; Level data address
db $00       ; Tileset
db $06       ; Music data index
db $05       ; Music track index
dw $80C0     ; FX address (bank $83)
dw $883D     ; Enemy population offset (bank $A1)
dw $8193     ; Enemy graphics set offset (bank $B4)
dw $0181     ; Layer 2 scroll
dw $9283     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $C116     ; Room main routine (bank $8F)
dw $8000     ; Room PLM list address (bank $8F)
dw $B76A     ; Library background (bank $8F)
dw $91C9     ; Room setup routine (bank $8F)

; Room $91F8 state $922D: Header
; (event bit 00h)
org $8F922D
dl $C2C2BB   ; Level data address
db $00       ; Tileset
db $06       ; Music data index
db $06       ; Music track index
dw $80C0     ; FX address (bank $83)
dw $883D     ; Enemy population offset (bank $A1)
dw $8193     ; Enemy graphics set offset (bank $B4)
dw $0181     ; Layer 2 scroll
dw $9283     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $C116     ; Room main routine (bank $8F)
dw $8000     ; Room PLM list address (bank $8F)
dw $B76A     ; Library background (bank $8F)
dw $91C9     ; Room setup routine (bank $8F)

; Room $91F8 state $9247: Header
; (pbs)
org $8F9247
dl $C2C2BB   ; Level data address
db $00       ; Tileset
db $0C       ; Music data index
db $05       ; Music track index
dw $80D0     ; FX address (bank $83)
dw $883D     ; Enemy population offset (bank $A1)
dw $8193     ; Enemy graphics set offset (bank $B4)
dw $0181     ; Layer 2 scroll
dw $9283     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $C116     ; Room main routine (bank $8F)
dw $8000     ; Room PLM list address (bank $8F)
dw $B76A     ; Library background (bank $8F)
dw $91C9     ; Room setup routine (bank $8F)

; Room $91F8 state $9261: Header
; (event bit 0eh)
org $8F9261
; dl $C2C2BB   ; Level data address
dl escape_landing_site_level_data ; Level data address
db $00       ; Tileset
db $00       ; Music data index
db $00       ; Music track index
dw $8000     ; FX address (bank $83)
dw $8C0D     ; Enemy population offset (bank $A1)
dw $8283     ; Enemy graphics set offset (bank $B4)
dw $0181     ; Layer 2 scroll
dw $9283     ; Room scroll data (bank $8F)
dw $0000     ; Room var
;dw $C120     ; Room main routine (bank $8F)
dw landing_site_escape_main
dw $8026     ; Room PLM list address (bank $8F)
dw $B76A     ; Library background (bank $8F)
; dw $91BD     ; Room setup routine (bank $8F)
dw $91C9

; Room $91F8 state $9213: Enemy population
org $A1883D
;  enemy  x      y      init   props  extra  param1 param2
dw $D07F, $0480, $0478, $0000, $2400, $0000, $0000, $0000 ; gunship top
dw $D0BF, $0480, $0478, $0000, $2400, $0000, $0000, $0000 ; gunship bottom
dw $D0BF, $0480, $0478, $0000, $2400, $0000, $0000, $0001 ; gunship bottom
dw $FFFF     ; end of list
db $00       ; death quota

; Room $91F8 state $922D: Enemy population
org $A1883D
;  enemy  x      y      init   props  extra  param1 param2
dw $D07F, $0480, $0478, $0000, $2400, $0000, $0000, $0000 ; gunship top
dw $D0BF, $0480, $0478, $0000, $2400, $0000, $0000, $0000 ; gunship bottom
dw $D0BF, $0480, $0478, $0000, $2400, $0000, $0000, $0001 ; gunship bottom
dw $FFFF     ; end of list
db $00       ; death quota

; Room $91F8 state $9247: Enemy population
org $A1883D
;  enemy  x      y      init   props  extra  param1 param2
dw $D07F, $0480, $0478, $0000, $2400, $0000, $0000, $0000 ; gunship top
dw $D0BF, $0480, $0478, $0000, $2400, $0000, $0000, $0000 ; gunship bottom
dw $D0BF, $0480, $0478, $0000, $2400, $0000, $0000, $0001 ; gunship bottom
dw $FFFF     ; end of list
db $00       ; death quota

; Room $91F8 state $9261: Enemy population
org $A18C0D
{
  ;  enemy  x      y      init   props  extra  param1 param2
if not(!USE_BELOW_LANDING_SITE)
  dw $D07F, $0480, $0478, $0000, $2400, $0000, $0000, $0000 ; gunship top
  dw $D0BF, $0480, $0478, $0000, $2400, $0000, $0000, $0000 ; gunship bottom
  dw $D0BF, $0480, $0478, $0000, $2400, $0000, $0000, $0001 ; gunship bottom
  dw !baby_top, $0480, $0460, $0000, $2C00, $0000, $0000, $0000 ; baby
else
  dw $E1FF, $0051, $04AA, $0000, $2000, $0000, $0000, $0000 ; ceres steam
  dw $E1FF, $0080, $04BC, $0000, $2000, $0000, $0000, $0000 ; ceres steam
  dw $E1FF, $00A1, $04D0, $0000, $2000, $0000, $0000, $0000 ; ceres steam
  dw $E1FF, $00E5, $04D7, $0000, $2000, $0000, $0000, $0000 ; ceres steam
  dw $E1FF, $015B, $04D7, $0000, $2000, $0000, $0000, $0000 ; ceres steam
  dw $E1FF, $019D, $04D5, $0000, $2000, $0000, $0000, $0000 ; ceres steam
  dw $E1FF, $01C0, $04C9, $0000, $2000, $0000, $0000, $0000 ; ceres steam
  dw $E1FF, $0222, $04C8, $0000, $2000, $0000, $0000, $0000 ; ceres steam
  dw $E1FF, $0243, $04C4, $0000, $2000, $0000, $0000, $0000 ; ceres steam
  dw $E1FF, $027C, $04CE, $0000, $2000, $0000, $0000, $0000 ; ceres steam
  dw $E1FF, $0317, $04D7, $0000, $2000, $0000, $0000, $0000 ; ceres steam
  dw $E1FF, $033F, $04C9, $0000, $2000, $0000, $0000, $0000 ; ceres steam
  dw $E1FF, $036C, $04B6, $0000, $2000, $0000, $0000, $0000 ; ceres steam
  dw $E1FF, $0390, $04A9, $0000, $2000, $0000, $0000, $0000 ; ceres steam
  dw $E1FF, $03D9, $04B7, $0000, $2000, $0000, $0000, $0000 ; ceres steam
  dw $E1FF, $041A, $04D9, $0000, $2000, $0000, $0000, $0000 ; ceres steam
  dw $E1FF, $049C, $04D8, $0000, $2000, $0000, $0000, $0000 ; ceres steam
  dw $E1FF, $04F9, $04CA, $0000, $2000, $0000, $0000, $0000 ; ceres steam
  dw $E1FF, $0525, $04BB, $0000, $2000, $0000, $0000, $0000 ; ceres steam
  dw $E1FF, $0557, $04C9, $0000, $2000, $0000, $0000, $0000 ; ceres steam
  dw $E1FF, $05C6, $04D4, $0000, $2000, $0000, $0000, $0000 ; ceres steam
  dw $E1FF, $0624, $04D4, $0000, $2000, $0000, $0000, $0000 ; ceres steam
endif
  dw $FFFF     ; end of list
  db $00       ; death quota
}

; Room $91F8 state $9213: Enemy graphics set
org $B48193
;  enemy  palette
dw $D07F, $0002 ; gunship top
dw $D0BF, $0007 ; gunship bottom
dw $FFFF     ; end of list

; Room $91F8 state $922D: Enemy graphics set
org $B48193
;  enemy  palette
dw $D07F, $0002 ; gunship top
dw $D0BF, $0007 ; gunship bottom
dw $FFFF     ; end of list

; Room $91F8 state $9247: Enemy graphics set
org $B48193
;  enemy  palette
dw $D07F, $0002 ; gunship top
dw $D0BF, $0007 ; gunship bottom
dw $FFFF     ; end of list

; Room $91F8 state $9261: Enemy graphics set
org $B48283
{
  ;  enemy  palette
if not(!USE_BELOW_LANDING_SITE)
  dw !baby_top, $0000 ; baby
  dw $D07F, $0002 ; gunship top
  dw $D0BF, $0007 ; gunship bottom
endif
  dw $FFFF     ; end of list
}

; Room $91F8 state $9213: FX
org $8380C0
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $FFFF, $FFFF, $0000 : db $00, $0A, $02, $0E, $00, $01, $00, $22

; Room $91F8 state $922D: FX
org $8380C0
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $FFFF, $FFFF, $0000 : db $00, $0A, $02, $0E, $00, $01, $00, $22

; Room $91F8 state $9247: FX
org $8380D0
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $FFFF, $FFFF, $0000 : db $00, $00, $02, $02, $00, $00, $00, $00

; Room $91F8 state $9261: FX
org $838000
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
; dw $0000, $FFFF, $FFFF, $0000 : db $00, $00, $02, $02, $00, $06, $00, $00
dw $0000, $FFFF, $FFFF, $0000 : db $00, $00, $02, $02, $00, $04, $00, $00
;                                                            |
;                                                            +-- lightning only, no red flashing
;
;
; TODO:
; 1. is it possible to slow down the lightning?
; 2. can I add some light rain/thunder?

org !FREESPACE_8F

landing_site_escape_main:
{
  JSL $88AF8D
  RTS
}

end_landing_site_freespace_8f:
!FREESPACE_8F := end_landing_site_freespace_8f
