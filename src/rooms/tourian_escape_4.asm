; Room $DEDE: Header
org $8FDEDE
db $11       ; Index
db $05       ; Area
db $12       ; X position on map
db $10       ; Y position on map
db $03       ; Width (in screens)
db $06       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $DF05     ; Door out
dw $E5E6     ; State $DEEB function (default)

; Room $DEDE state $DEEB: Header
; (default)
org $8FDEEB
dl $CDF534   ; Level data address
db $0D       ; Tileset
db $00       ; Music data index
db $00       ; Music track index
dw $A134     ; FX address (bank $83)
; dw $E102     ; Enemy population offset (bank $A1)
; dw $90B0     ; Enemy graphics set offset (bank $B4)
dw tourian_escape_4_enemy_population
dw tourian_escape_4_enemy_graphics_set
dw $C1C1     ; Layer 2 scroll
dw $DF09     ; Room scroll data (bank $8F)
dw $0000     ; Room var
; dw $E5A4     ; Room main routine (bank $8F)
; dw $E5D1     ; Room main routine (bank $8F)
dw tourian_escape_4_room_main
dw $C8A5     ; Room PLM list address (bank $8F)
dw $E46F     ; Library background (bank $8F)
; dw $C953     ; Room setup routine (bank $8F)
dw $C96D     ; Room setup routine (bank $8F)

org !FREESPACE_8F

tourian_escape_4_room_main:
{
  ; Manually set the palette for these enemies, since it is not set
  LDA #$0200
  STA $0F96+($040*7)
  STA $0F96+($040*8)
  STA $0F96+($040*9)
  STA $0F96+($040*10)
  STA $0F96+($040*11)
  STA $0F96+($040*12)
  STA $0F96+($040*13)

  RTS
}

end_tourian_escape_4_freespace_8f:
!FREESPACE_8F := end_tourian_escape_4_freespace_8f

org !FREESPACE_A1

tourian_escape_4_enemy_population:

; Room $DEDE state $DEEB: Enemy population
; org $A1E102
;  enemy  x      y      init   props  extra  param1 param2
dw !baby, $0000, $0384, $0000, $2C00, $0000, $0000, $0000 ; baby
dw $F493, $002B, $04D0, $0000, $2000, $0004, $0000, $0084 ; batta1Tu (tourian silver wall pirate)
dw $F493, $00B2, $0428, $0000, $2000, $0004, $0001, $0084 ; batta1Tu (tourian silver wall pirate)
dw $F493, $002B, $0308, $0000, $2000, $0004, $0000, $0084 ; batta1Tu (tourian silver wall pirate)
dw $F493, $00B2, $0278, $0000, $2000, $0004, $0001, $0084 ; batta1Tu (tourian silver wall pirate)
dw $F493, $002B, $01E8, $0000, $2000, $0004, $0000, $0084 ; batta1Tu (tourian silver wall pirate)
dw $F493, $00B2, $0158, $0000, $2000, $0004, $0001, $0084 ; batta1Tu (tourian silver wall pirate)
dw $F793, $0270, $0180, $0000, $2000, $0004, $0000, $0020 ; batta3Tu (tourian silver walking pirate)
dw $F793, $01D0, $0180, $0000, $2000, $0004, $0000, $0020 ; batta3Tu (tourian silver walking pirate)
dw $F793, $01C8, $02D0, $0000, $2000, $0004, $0000, $0010 ; batta3Tu (tourian silver walking pirate)
dw $F793, $0140, $0200, $0000, $2000, $0004, $0000, $0020 ; batta3Tu (tourian silver walking pirate)
dw $F793, $01B8, $03B0, $0000, $2000, $0004, $0000, $0010 ; batta3Tu (tourian silver walking pirate)
dw $F793, $0168, $0500, $0000, $2000, $0004, $0000, $0010 ; batta3Tu (tourian silver walking pirate)
dw $F793, $0278, $0450, $0000, $2000, $0004, $0000, $0010 ; batta3Tu (tourian silver walking pirate)
dw $FFFF     ; end of list
db $0D       ; death quota

end_tourian_escape_4_freespace_a1:
!FREESPACE_A1 := end_tourian_escape_4_freespace_a1

org !FREESPACE_B4

tourian_escape_4_enemy_graphics_set:

; Room $DEDE state $DEEB: Enemy graphics set
; org $B490B0
;  enemy  palette
dw $F493, $0001 ; batta1Tu (tourian silver wall pirate)
; dw $F793, $0001 ; batta3Tu (tourian silver walking pirate) ; intentionally omitted to trick the game into using vram tiles index 0
dw !baby, $0007 ; baby

dw $FFFF     ; end of list

end_tourian_escape_4_freespace_b4:
!FREESPACE_B4 := end_tourian_escape_4_freespace_b4

; Room $DEDE state $DEEB: FX
org $83A134
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $05E0, $0010, $0000 : db $40, $04, $02, $1E, $01, $70, $02, $00
