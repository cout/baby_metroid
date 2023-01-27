; Room $D6D0: Header
org $8FD6D0
db $26       ; Index
db $04       ; Area
db $20       ; X position on map
db $0F       ; Y position on map
db $02       ; Width (in screens)
db $02       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $D6F7     ; Door out
dw $E5E6     ; State $D6DD function (default)

; Room $D6D0 state $D6DD: Header
; (default)
org $8FD6DD
dl $CCBD31   ; Level data address
db $0C       ; Tileset
db $00       ; Music data index
db $00       ; Music track index
dw $9EF4     ; FX address (bank $83)
; dw $DD35     ; Enemy population offset (bank $A1)
; dw $8FCA     ; Enemy graphics set offset (bank $B4)
dw spring_ball_room_enemy_population
dw spring_ball_room_enemy_graphics_set
dw $00C0     ; Layer 2 scroll
dw $D6F9     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $C6E5     ; Room PLM list address (bank $8F)
dw $0000     ; Library background (bank $8F)
dw $C8D2     ; Room setup routine (bank $8F)

;; ; Room $D6D0 state $D6DD: Enemy population
;; org $A1DD35
;; ;  enemy  x      y      init   props  extra  param1 param2
;; dw $FFFF     ; end of list
;; db $00       ; death quota
;; 
;; ; Room $D6D0 state $D6DD: Enemy graphics set
;; org $B48FCA
;; ;  enemy  palette
;; dw $FFFF     ; end of list

; Room $D6D0 state $D6DD: FX
org $839EF4
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $00B0, $FFFF, $0000 : db $00, $06, $02, $14, $82, $01, $00, $E8

org !FREESPACE_A1

spring_ball_room_enemy_population:
; Room $D6D0 state $D6DD: Enemy population
;  enemy         x      y      init   props  extra  param1 param2
dw water_zoomer, $011B, $0169, $0000, $2801, $0000, $0002, $0000
dw $FFFF     ; end of list
db $00       ; death quota

end_spring_ball_room_freespace_a1:
!FREESPACE_A1 := end_spring_ball_room_freespace_a1

org !FREESPACE_B4

spring_ball_room_enemy_graphics_set:
; Room $D6D0 state $D6DD: Enemy graphics set
;  enemy     palette
; dw !zoomer, $0000
; dw !hzoomer, $0000
dw water_zoomer, $0001
dw $FFFF     ; end of list

end_spring_ball_room_freespace_b4:
!FREESPACE_B4 := end_spring_ball_room_freespace_b4
