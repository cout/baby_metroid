; Room $B236: Header
org $8FB236
db $36       ; Index
db $02       ; Area
db $11       ; X position on map
db $0B       ; Y position on map
db $08       ; Width (in screens)
db $03       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $B25D     ; Door out
dw $E5E6     ; State $B243 function (default)

; Room $B236 state $B243: Header
; (default)
org $8FB243
dl $C8D59C   ; Level data address
db $09       ; Tileset
db $18       ; Music data index
db $05       ; Music track index
dw $878A     ; FX address (bank $83)
dw $AFEA     ; Enemy population offset (bank $A1)
; dw $893D     ; Enemy graphics set offset (bank $B4)
dw main_hall_enemy_graphics_set
dw $01C1     ; Layer 2 scroll
dw $B265     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $8E12     ; Room PLM list address (bank $8F)
dw $BF17     ; Library background (bank $8F)
dw $91F7     ; Room setup routine (bank $8F)

; Room $B236 state $B243: Enemy population
org $A1AFEA
;  enemy  x      y      init   props  extra  param1 param2
dw $D73F, $0480, $02A2, $0000, $2C00, $0000, $0001, $0018 ; elevator
dw $D4BF, $02D0, $0328, $0000, $2000, $0000, $0000, $0000 ; dragon
dw $D4BF, $02D0, $02F8, $0002, $2400, $0000, $0001, $0000 ; dragon
dw $D4BF, $0330, $02F8, $0000, $2000, $0000, $0000, $0000 ; dragon
dw $D4BF, $0330, $02F8, $0002, $2400, $0000, $0001, $0000 ; dragon

; dw $E07F, $0197, $02B8, $0000, $2500, $0000, $0050, $0000 ; hibashi
; dw $E07F, $0197, $02B8, $0000, $2100, $0000, $0000, $0001 ; hibashi
; dw $E07F, $0117, $02A8, $0000, $2500, $0000, $0060, $0000 ; hibashi
; dw $E07F, $0117, $02A8, $0000, $2100, $0000, $0000, $0001 ; hibashi
; dw $E07F, $0097, $0288, $0000, $2500, $0000, $0060, $0000 ; hibashi
; dw $E07F, $0097, $0288, $0000, $2100, $0000, $0000, $0001 ; hibashi
; dw $E07F, $0217, $02B8, $0000, $2500, $0000, $0050, $0000 ; hibashi
; dw $E07F, $0217, $02B8, $0000, $2100, $0000, $0000, $0001 ; hibashi

; Keep the hibashi from knocking Samus off the rippers (TODO: this does
; not work and I do not know why)
dw $E07F, $0197, $02B8, $0000, $A500, $0000, $0050, $0000 ; hibashi
dw $E07F, $0197, $02B8, $0000, $A500, $0000, $0000, $0001 ; hibashi
dw $E07F, $0117, $02A8, $0000, $A500, $0000, $0060, $0000 ; hibashi
dw $E07F, $0117, $02A8, $0000, $A500, $0000, $0000, $0001 ; hibashi
dw $E07F, $0097, $0288, $0000, $A500, $0000, $0060, $0000 ; hibashi
dw $E07F, $0097, $0288, $0000, $A500, $0000, $0000, $0001 ; hibashi
dw $E07F, $0217, $02B8, $0000, $A500, $0000, $0050, $0000 ; hibashi
dw $E07F, $0217, $02B8, $0000, $A500, $0000, $0000, $0001 ; hibashi

; Remove some of the dragon parts to make room for the rippers
; dw $D4BF, $0238, $02F8, $0000, $2000, $0000, $0000, $0000 ; dragon
; dw $D4BF, $0238, $02F8, $0002, $2400, $0000, $0001, $0000 ; dragon
; dw $D4BF, $0138, $02F8, $0000, $2000, $0000, $0000, $0000 ; dragon
; dw $D4BF, $0138, $02F8, $0002, $2400, $0000, $0001, $0000 ; dragon
; dw $D4BF, $01B8, $02F8, $0000, $2000, $0000, $0000, $0000 ; dragon
; dw $D4BF, $01B8, $02F8, $0002, $2400, $0000, $0001, $0000 ; dragon
dw $D4BF, $0238, $0328, $0000, $2000, $0000, $0000, $0000 ; dragon
dw $D4BF, $0138, $0328, $0000, $2000, $0000, $0000, $0000 ; dragon
dw $D4BF, $01B8, $0328, $0000, $2000, $0000, $0000, $0000 ; dragon

; Add three rippers to make it easier to get across
dw !ripper2_norfair, $02A0, $0258, $0000, $2000, $0000, $0010, $0001 ; ripper
dw !ripper2_norfair, $0310, $026E, $0000, $2000, $0000, $0010, $0001 ; ripper
dw !ripper2_norfair, $0330, $0298, $0000, $2000, $0000, $0010, $0001 ; ripper

dw $FFFF     ; end of list
db $05       ; death quota
warnpc $A1B11D

org !FREESPACE_B4

main_hall_enemy_graphics_set:
; Room $B236 state $B243: Enemy graphics set
; org $B4893D
;  enemy  palette
dw $E07F, $0001 ; hibashi
dw $D4BF, $0007 ; dragon
dw $F213, $0007 ; gamet
dw !ripper2_norfair, $0002
dw $FFFF     ; end of list

end_main_hall_freespace_b4:
!FREESPACE_B4 := end_main_hall_freespace_b4

; Room $B236 state $B243: FX
org $83878A
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $02C1, $FFFF, $0000 : db $00, $04, $02, $1E, $82, $1F, $00, $00
