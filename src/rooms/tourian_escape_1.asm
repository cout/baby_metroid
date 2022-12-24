; Room $DE4D: Header
org $8FDE4D
db $0E       ; Index
db $05       ; Area
db $0B       ; X position on map
db $12       ; Y position on map
db $02       ; Width (in screens)
db $01       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $DE74     ; Special graphics bits
dw $E5E6     ; State $DE5A function (default)

; Room $DE4D state $DE5A: Header
org $8FDE5A
dl $CDE914   ; Level data address
db $0D       ; Tileset
db $24       ; Music data index
db $03       ; Music track index
dw $A104     ; FX address (bank $83)
; dw $E3AA     ; Enemy population offset (bank $A1)
; dw $9130     ; Enemy graphics set offset (bank $B4)
dw tourian_escape_1_enemy_population   ; Enemy population offset (bank $A1)
dw tourian_escape_1_enemy_graphics_set ; Enemy graphics set offset (bank $B4)
dw $C1C1     ; Layer 2 scroll
dw $DE78     ; Room scroll data (bank $8F)
dw $0000     ; Room var
; dw $E5A0     ; Room main routine (bank $8F)
dw $E5A3     ; Room main routine (bank $8F)
dw $C87B     ; Room PLM list address (bank $8F)
dw $E439     ; Library background (bank $8F)
; dw $C91F     ; Room setup routine (bank $8F)
dw $C932     ; Room setup routine (bank $8F)

org !FREESPACE_A1

tourian_escape_1_enemy_population:

; Room $DE4D state $DE5A: Enemy population
; org $A1E3AA
;  enemy  x      y      init   props  extra  param1 param2
dw !baby, $01D2, $008B, $0000, $2C00, $0000, $0000, $0000 ; baby
dw $D5BF, $01B8, $0040, $0108, $A800, $FF00, $2000, $0010 ; destructible shutter2
dw $D5BF, $01B8, $00C0, $0008, $A800, $00FF, $2000, $0010 ; destructible shutter2
dw $D5BF, $0168, $0040, $0108, $A800, $FF00, $2000, $0010 ; destructible shutter2
dw $D5BF, $0168, $00C0, $0008, $A800, $00FF, $2000, $0010 ; destructible shutter2
dw $D5BF, $0118, $0040, $0108, $A800, $FF00, $2000, $0018 ; destructible shutter2
dw $D5BF, $0118, $00C0, $0008, $A800, $00FF, $2000, $0018 ; destructible shutter2
dw $D5BF, $00C8, $0040, $0108, $A800, $FF00, $2000, $0020 ; destructible shutter2
dw $D5BF, $00C8, $00C0, $0008, $A800, $00FF, $2000, $0020 ; destructible shutter2
dw $FFFF     ; end of list
db $00       ; death quota

end_tourian_escape_1_freespace_a1:
!FREESPACE_A1 := end_tourian_escape_1_freespace_a1

org !FREESPACE_B4

tourian_escape_1_enemy_graphics_set:

; Room $DE4D state $DE5A: Enemy graphics set
; org $B49130
;  enemy  palette
; TODO - I think maybe both baby and shutters expect to use the first
; palette?
dw $D5BF, $0001 ; destructible shutter2
dw !baby, $0007 ; baby
dw $FFFF     ; end of list

end_tourian_escape_1_freespace_b4:
!FREESPACE_B4 = end_tourian_escape_1_freespace_b4

; Room $DE4D state $DE5A: FX
org $83A104
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $FFFF, $FFFF, $0000 : db $00, $00, $02, $02, $00, $78, $00, $00
