; Room $D1A3: Header
org $8FD1A3
db $0C       ; Index
db $04       ; Area
db $12       ; X position on map
db $07       ; Y position on map
db $02       ; Width (in screens)
db $04       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $D1CA     ; Special graphics bits
dw $E5E6     ; State $D1B0 function (default)

; Room $D1A3 state $D1B0: Header
org $8FD1B0
dl $CAE458   ; Level data address
db $0B       ; Tileset
db $1B       ; Music data index
db $06       ; Music track index
dw $9D44     ; FX address (bank $83)
; dw $8766
; dw $CFC3     ; Enemy population offset (bank $A1)
; dw $8D77     ; Enemy graphics set offset (bank $B4)
dw crab_shaft_enemy_population   ; Enemy population offset (bank $A1)
dw crab_shaft_enemy_graphics_set ; Enemy graphics set offset (bank $B4)
dw $C000     ; Layer 2 scroll
dw $D1D0     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $C4EF     ; Room PLM list address (bank $8F)
dw $0000     ; Library background (bank $8F)
dw $C8D1     ; Room setup routine (bank $8F)

org !FREESPACE_A1

crab_shaft_enemy_population:

; Room $D1A3 state $D1B0: Enemy population
;  enemy          x      y      init   props  extra  param1 param2
dw $D77F,         $0170, $0367, $0002, $2801, $0000, $0003, $0000 ; sciser
dw $D77F,         $0030, $03B8, $0003, $2000, $0000, $0001, $0000 ; sciser
dw $D77F,         $00E0, $0367, $0002, $2000, $0000, $0001, $0000 ; sciser
dw $D77F,         $0080, $00B8, $0003, $2800, $0000, $0004, $0000 ; sciser
dw !samus_statue, $0076, $029D, $0000, $2400, $0000, $0000, $0208 ; statue
dw $FFFF     ; end of list
db $04       ; death quota

end_crab_shaft_freespace_a1:
!FREESPACE_A1 := end_crab_shaft_freespace_a1
 

; Room $D1A3 state $D1B0: Enemy graphics set

org !FREESPACE_B4

crab_shaft_enemy_graphics_set:
;  enemy          palette
dw $D77F,         $0001 ; sciser
dw !samus_statue, $0002 ; statue
dw $FFFF     ; end of list

end_crab_shaft_freespace_b4:
!FREESPACE_B4 := end_crab_shaft_freespace_b4
