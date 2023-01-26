; Room $B698: Header
org $8FB698
db $49       ; Index
db $02       ; Area
db $16       ; X position on map
db $11       ; Y position on map
db $01       ; Width (in screens)
db $01       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $B6BF     ; Special graphics bits
dw $E5E6     ; State $B6A5 function (default)

; Room $B698 state $B6A5: Header
org $8FB6A5
dl $C9C30D   ; Level data address
db $09       ; Tileset
db $00       ; Music data index
db $00       ; Music track index
dw $88BC     ; FX address (bank $83)
; dw $AEAB     ; Enemy population offset (bank $A1)
; dw $88F3     ; Enemy graphics set offset (bank $B4)
dw ridley_etank_enemy_population   ; Enemy population offset (bank $A1)
dw ridley_etank_enemy_graphics_set ; Enemy graphics set offset (bank $B4)
dw $0101     ; Layer 2 scroll
dw $0000     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $9108     ; Room PLM list address (bank $8F)
dw $BF32     ; Library background (bank $8F)
dw $91F7     ; Room setup routine (bank $8F)

;;  ; Room $B698 state $B6A5: Enemy population
;;  org $A1AEAB
;;  ;  enemy  x      y      init   props  extra  param1 param2
;;  dw $FFFF     ; end of list
;;  db $00       ; death quota
;;  
;;  ; Room $B698 state $B6A5: Enemy graphics set
;;  org $B488F3
;;  ;  enemy  palette
;;  dw $FFFF     ; end of list

org !FREESPACE_A1

ridley_etank_enemy_population:

;  enemy  x      y      init   props  extra  param1 param2
dw small_baby, $0060, $0060, $0000, $2000, $0000, $0000, $0005
dw $FFFF     ; end of list
db $00       ; death quota

end_ridley_etank_freespace_a1:
!FREESPACE_A1 := end_ridley_etank_freespace_a1

org !FREESPACE_B4

ridley_etank_enemy_graphics_set:
;  enemy  palette
dw small_baby, $0001
dw $FFFF     ; end of list

end_ridley_etank_freesapce_b4:
!FREESPACE_B4 = end_ridley_etank_freesapce_b4
