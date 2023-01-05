; Room $DE7A: Header
org $8FDE7A
db $0F       ; Index
db $05       ; Area
db $0B       ; X position on map
db $13       ; Y position on map
db $01       ; Width (in screens)
db $02       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $DEA1     ; Door out
dw $E5E6     ; State $DE87 function (default)

; Room $DE7A state $DE87: Header
; (default)
org $8FDE87
dl $CDEB5B   ; Level data address
db $0D       ; Tileset
db $00       ; Music data index
db $00       ; Music track index
dw $A114     ; FX address (bank $83)
; dw $E59C     ; Enemy population offset (bank $A1)
; dw $9188     ; Enemy graphics set offset (bank $B4)
dw tourian_escape_2_enemy_population
dw tourian_escape_2_enemy_graphics_set
dw $C1C1     ; Layer 2 scroll
dw $DEA5     ; Room scroll data (bank $8F)
dw $0000     ; Room var
; dw $E57C     ; Room main routine (bank $8F)
dw $E5A3     ; Room main routine (bank $8F)
dw $C889     ; Room PLM list address (bank $8F)
dw $E454     ; Library background (bank $8F)
; dw $C933     ; Room setup routine (bank $8F)
dw $C945     ; Room setup routine (bank $8F)

org !FREESPACE_A1

tourian_escape_2_enemy_population:

; TODO
; 1. baby graphics are messed up in this room
; 2. baby should find samus quickly initially (or maybe always) but the
;    slow follow should be later, or perhaps slow follow if close to
;    samus and fast otherwise
; 3. baby should find enemies to shoot faster
; 4. put baby in correct position coming through the door
; 5. baby should follow samus out the previous door

; Room $DE7A state $DE87: Enemy population
; org $A1E59C
;  enemy  x      y      init   props  extra  param1 param2
dw !baby, $01D2, $008B, $0000, $2C00, $0000, $0000, $0000 ; baby
dw $F493, $002B, $00D8, $0000, $2000, $0004, $0000, $00A0 ; batta1Tu (tourian silver wall pirate)
dw $F493, $00D0, $0128, $0000, $2000, $0004, $0001, $00A0 ; batta1Tu (tourian silver wall pirate)
dw $FFFF     ; end of list
db $02       ; death quota

end_tourian_escape_freespace_a1:
!FREESPACE_A1 := end_tourian_escape_freespace_a1

org !FREESPACE_B4

tourian_escape_2_enemy_graphics_set:

; Room $DE7A state $DE87: Enemy graphics set
; org $B49188
;  enemy  palette
dw $F493, $0001 ; batta1Tu (tourian silver wall pirate)
dw !baby, $0007 ; baby
dw $FFFF     ; end of list

end_tourian_escape_freespace_b4:
!FREESPACE_B4 := end_tourian_escape_freespace_b4

; Room $DE7A state $DE87: FX
org $83A114
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
; dw $0000, $FFFF, $FFFF, $0000 : db $00, $00, $02, $02, $00, $70, $00, $00
dw $0000, $FFFF, $FFFF, $0000 : db $00, $00, $02, $02, $00, $78, $00, $00

