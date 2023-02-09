!ENTRY_DOOR_INDEX = $D1

org $C3E0D0
incbin "bomb_torizo.bin"
warnpc $C3E16E

; Room $9804: Header
org $8F9804
db $15       ; Index
db $00       ; Area
db $19       ; X position on map
db $06       ; Y position on map
db $01       ; Width (in screens)
db $01       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
; dw $9869     ; Door out
dw bomb_torizo_door_list
dw $E612     ; State $984F function (event)
db $0E       ; Event
dw $984F     ; State header address
dw $E629     ; State $9835 function (boss)
db $04       ; Boss
dw $9835     ; State header address
dw $E5E6     ; State $981B function (default)
%assertpc($8F981B)

; Room $9804 state $981B: Header
; (default)
org $8F981B
dl $C3E0D0   ; Level data address
db $02       ; Tileset
db $24       ; Music data index
db $03       ; Music track index
dw $81BE     ; FX address (bank $83)
dw $84ED     ; Enemy population offset (bank $A1)
dw $80B3     ; Enemy graphics set offset (bank $B4)
dw $C1C1     ; Layer 2 scroll
dw $0000     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $83FE     ; Room PLM list address (bank $8F)
dw $B905     ; Library background (bank $8F)
dw $91D4     ; Room setup routine (bank $8F)
%assertpc($8F9835)

; Room $9804 state $9835: Header
; (boss bit 04h)
org $8F9835
dl $C3E0D0   ; Level data address
db $02       ; Tileset
db $00       ; Music data index
db $03       ; Music track index
dw $81BE     ; FX address (bank $83)
dw $84ED     ; Enemy population offset (bank $A1)
dw $80B3     ; Enemy graphics set offset (bank $B4)
dw $C1C1     ; Layer 2 scroll
dw $0000     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $83FE     ; Room PLM list address (bank $8F)
dw $B905     ; Library background (bank $8F)
dw $91D4     ; Room setup routine (bank $8F)
%assertpc($8F984F)

; Room $9804 state $984F: Header
; (event bit 0eh)
org $8F984F
dl $C3E0D0   ; Level data address
db $02       ; Tileset
db $00       ; Music data index
db $00       ; Music track index
dw $8030     ; FX address (bank $83)
dw $8ED3     ; Enemy population offset (bank $A1)
dw $82A3     ; Enemy graphics set offset (bank $B4)
dw $C1C1     ; Layer 2 scroll
dw $0000     ; Room scroll data (bank $8F)
dw $986B     ; Room var
dw $C124     ; Room main routine (bank $8F)
dw $8412     ; Room PLM list address (bank $8F)
dw $B905     ; Library background (bank $8F)
dw $91B2     ; Room setup routine (bank $8F)
%assertpc($8F9869)

; Room $9804 state $981B: Enemy population
; Room $9804 state $9835: Enemy population
org $A184ED
;  enemy  x      y      init   props  extra  param1 param2
dw $EEFF, $00DB, $00B3, $0000, $2000, $0000, $0000, $0000 ; bomb torizo
dw $FFFF     ; end of list
db $00       ; death quota

; Room $9804 state $984F: Enemy population
org $A18ED3
;  enemy  x      y      init   props  extra  param1 param2
dw $F313, $00E0, $00B8, $0000, $2400, $0000, $0000, $0000 ; escape dachora
dw $F2D3, $00E0, $00B8, $0000, $2000, $0000, $0000, $0000 ; escape etecoon
dw $F2D3, $00E0, $00B8, $0000, $2000, $0000, $0002, $0000 ; escape etecoon
dw $F2D3, $00E0, $00B8, $0000, $2000, $0000, $0004, $0000 ; escape etecoon
dw $FFFF     ; end of list
db $04       ; death quota

; Room $9804 state $981B: Enemy graphics set
; Room $9804 state $9835: Enemy graphics set
org $B480B3
;  enemy  palette
dw $EEFF, $0001 ; bomb torizo
dw $FFFF     ; end of list

; Room $9804 state $984F: Enemy graphics set
org $B482A3
;  enemy  palette
dw $F2D3, $0001 ; escape etecoon
dw $F313, $0007 ; escape dachora
dw $FFFF     ; end of list

; Room $9804 state $981B: FX
; Room $9804 state $9835: FX
org $8381BE
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $FFFF, $FFFF, $FFFF, $0000 : db $E0, $07, $FF, $FF, $00, $00, $00, $04
dw $1E02, $0040, $4802, $0000 : db $FF, $FF, $FF, $FF, $00, $00, $00, $00
dw $0228, $0000, $6200, $0000 : db $FF, $FF, $FF, $FF, $00, $00, $00, $00
dw $0228, $0000, $6200, $0000 : db $FF, $FF, $FF, $FF, $00, $00, $00, $00
dw $0202, $0000, $0000, $0000 : db $FF, $FF, $FF, $FF, $00, $00, $00, $00
dw $0202, $0100, $0000, $0000 : db $FF, $FF, $FF, $FF, $00, $00, $00, $08
dw $0A02, $0000, $0000, $FFFF : db $FF, $FF, $FF, $FF, $FF, $FF, $00, $00
dw $FFFF, $FFFF, $0000, $2400 : db $02, $02, $00, $00, $00, $00, $FF, $FF
dw $0000, $FFFF, $FFFF, $0000 : db $00, $08, $02, $0A, $00, $00, $00, $00

; Room $9804 state $984F: FX
org $838030
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $00F0, $00B8, $FFF0 : db $30, $04, $02, $1E, $00, $00, $00, $00

; Room $9804, state $984F: PLM
org $8F8412
{
  dw $DB44, $0808, $000E
if not(!USE_BELOW_LANDING_SITE)
  dw $C848, $0601, $181C
else
  dw $C848, $0601, ($9000|!ENTRY_DOOR_INDEX)
endif
  dw $0000
}
warnpc $8F8420

org !FREESPACE_8F

bomb_torizo_door_list:
{
  dw $8BAA
  dw bomb_torizo_animals_escape_door
}

end_bomb_torizo_freespace_8f:
!FREESPACE_8F := end_bomb_torizo_freespace_8f

org !FREESPACE_83

bomb_torizo_animals_escape_door:
{
  ; 91F8,00,04,01,46,00,04,8000,0000

  ; dw $91F8        ; room id - TODO: just landing site for now
  dw below_landing_site_header
  db $40          ; bitflags (40h=reload map)
  db $00          ; direction
  db $01          ; door cap x
  db $46          ; door cap y
  db $00          ; screen x
  db $05          ; screen y
  dw $8000        ; distance to spawn
  dw $B9A2        ; door subroutine (B9A2=set scroll to green? not sure
                  ; if needed but flyway to alcatraz door does this)
}

end_bomb_torizo_freespace_83:
!FREESPACE_83 := end_bomb_torizo_freespace_83
