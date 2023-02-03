; Room $A6A1: Header
org $8FA6A1
db $34       ; Index
db $01       ; Area
db $29       ; X position on map
db $12       ; Y position on map
db $03       ; Width (in screens)
db $02       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $A6C8     ; Door out
dw $E5E6     ; State $A6AE function (default)

; Room $A6A1 state $A6AE: Header
; (default)
org $8FA6AE
dl $C6DEE0   ; Level data address
db $07       ; Tileset
db $12       ; Music data index
db $03       ; Music track index
dw $841A     ; FX address (bank $83)
; dw $98E4     ; Enemy population offset (bank $A1)
; dw $8529     ; Enemy graphics set offset (bank $B4)
dw warehouse_entrance_enemy_population
dw warehouse_entrance_enemy_graphics_set
dw $C1C1     ; Layer 2 scroll
dw $A6D0     ; Room scroll data (bank $8F)
dw $0000     ; Room var
; dw $0000     ; Room main routine (bank $8F)
dw warehouse_entrance_main
dw $8A5C     ; Room PLM list address (bank $8F)
dw $BC53     ; Library background (bank $8F)
dw $91F4     ; Room setup routine (bank $8F)

;;  ; Room $A6A1 state $A6AE: Enemy population
;;  org $A198E4
;;  ;  enemy  x      y      init   props  extra  param1 param2
;;  dw $D73F, $0080, $00A0, $0000, $2C00, $0000, $0000, $0140 ; elevator
;;  dw $FFFF     ; end of list
;;  db $00       ; death quota
;;
;;  ; Room $A6A1 state $A6AE: Enemy graphics set
;;  org $B48529
;;  ;  enemy  palette
;;  dw $FFFF     ; end of list

; Room $A6A1 state $A6AE: FX
org $83841A
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $FFFF, $FFFF, $0000 : db $00, $00, $2A, $02, $00, $00, $00, $00

org $A198D1 ; address of unused slot just before enemy population for room $A6A1

warehouse_entrance_enemy_population:

;                     x      y   init  props   xtra     p1     p2
dw !elevator,     $0080, $00A0, $0000, $2C00, $0000, $0000, $0140
dw !samus_statue, $00E4, $0094, $0000, $2500, $0000, $0000, $0101
dw $FFFF
db $00

org !FREESPACE_B4

warehouse_entrance_enemy_graphics_set:

dw !samus_statue, $0001, $FFFF
db $00

end_warehouse_entrance_freespace_b4:
!FREESPACE_B4 := end_warehouse_entrance_freespace_b4

org !FREESPACE_8F

; TODO - the idiomatic way to do this would be to add a new state, but
; that is not easy the way I am repointing
warehouse_entrance_main:
{
	; Check if HJB has been acquired.  If it has, show the statue,
	; otherwise delete it.  It is less jarring to have the statue show up
	; a frame late than to have it disappear after a frame.
  LDA $09A4
  BIT #$0100
  BNE .show_statue

.delete_statue:
  LDA $0F86+($40*1)
  ORA #$0300
  STA $0F86+($40*1)
	LDA #$0000
	STA $7FFC00
	RTS

.show_statue:
  LDA $0F86+($40*1)
  AND #$FEFF
  STA $0F86+($40*1)
	LDA #$0001
	STA $7FFC00
  RTS
}

end_warehouse_entrance_freespace_8f:
!FREESPACE_8F := end_warehouse_entrance_freespace_8f
