; Room $DEA7: Header
org $8FDEA7
db $10       ; Index
db $05       ; Area
db $0C       ; X position on map
db $13       ; Y position on map
db $06       ; Width (in screens)
db $02       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $DECE     ; Door out
dw $E5E6     ; State $DEB4 function (default)

; Room $DEA7 state $DEB4: Header
; (default)
org $8FDEB4
dl $CDED7A   ; Level data address
db $0D       ; Tileset
db $00       ; Music data index
db $00       ; Music track index
dw $A124     ; FX address (bank $83)
; dw $E695     ; Enemy population offset (bank $A1)
; dw $91B2     ; Enemy graphics set offset (bank $B4)
dw tourian_escape_3_enemy_population
dw tourian_escape_3_enemy_graphics_set
dw $C1C1     ; Layer 2 scroll
dw $DED2     ; Room scroll data (bank $8F)
dw $0000     ; Room var
; dw $E5A0     ; Room main routine (bank $8F)
dw $E5A3     ; Room main routine (bank $8F)
dw $C897     ; Room PLM list address (bank $8F)
dw $E46F     ; Library background (bank $8F)
; dw $C946     ; Room setup routine (bank $8F)
dw $C952     ; Room setup routine (bank $8F)

org !FREESPACE_A1

tourian_escape_3_enemy_population:

; Room $DEA7 state $DEB4: Enemy population
; org $A1E695
;  enemy  x      y      init   props  extra  param1 param2
dw !baby, $0000, $018B, $0000, $2C00, $0000, $0000, $0000 ; baby
dw $F793, $00C0, $0160, $0000, $2000, $0004, $0000, $0010 ; batta3Tu (tourian silver walking pirate)
dw $F793, $0538, $0160, $0000, $2000, $0004, $0000, $0010 ; batta3Tu (tourian silver walking pirate)
dw $F793, $0488, $0160, $0000, $2000, $0004, $0000, $0010 ; batta3Tu (tourian silver walking pirate)
dw $F793, $03D8, $0160, $0000, $2000, $0004, $0000, $0010 ; batta3Tu (tourian silver walking pirate)
dw $F793, $0478, $0050, $0000, $2000, $0004, $0000, $0010 ; batta3Tu (tourian silver walking pirate)
dw $F793, $04E0, $0050, $0000, $2000, $0004, $0000, $0010 ; batta3Tu (tourian silver walking pirate)
dw $F793, $0560, $0050, $0000, $2000, $0004, $0000, $0010 ; batta3Tu (tourian silver walking pirate)
dw $FFFF     ; end of list
db $07       ; death quota

end_tourian_escape_3_freespace_a1:
!FREESPACE_A1 := end_tourian_escape_3_freespace_a1

org !FREESPACE_B4

tourian_escape_3_enemy_graphics_set:

; Room $DEA7 state $DEB4: Enemy graphics set
; org $B491B2
;  enemy  palette
dw $F793, $0001 ; batta3Tu (tourian silver walking pirate)
dw $D4FF, $0002 ; shutter
dw !baby, $0007 ; baby
dw $FFFF     ; end of list

end_tourian_escape_3_freespace_b4:
!FREESPACE_B4 := end_tourian_escape_3_freespace_b4

; Room $DEA7 state $DEB4: FX
org $83A124
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $FFFF, $FFFF, $0000 : db $00, $00, $02, $02, $00, $70, $00, $00
