org $C3C998
incbin "climb.bin"
warnpc $C3D9F7

; Room $96BA: Header
org $8F96BA
db $12       ; Index
db $00       ; Area
db $12       ; X position on map
db $09       ; Y position on map
db $03       ; Width (in screens)
db $09       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
; dw $971F     ; Door out
dw climb_doors
dw $E612     ; State $9705 function (event)
db $0E       ; Event
dw $9705     ; State header address
dw $E612     ; State $96EB function (event)
db $00       ; Event
dw $96EB     ; State header address
dw $E5E6     ; State $96D1 function (default)

; Room $96BA state $96D1: Header
; (default)
org $8F96D1
dl $C3C998   ; Level data address
db $03       ; Tileset
db $00       ; Music data index
db $00       ; Music track index
dw $818E     ; FX address (bank $83)
dw $85E1     ; Enemy population offset (bank $A1)
dw $814F     ; Enemy graphics set offset (bank $B4)
dw $C1C1     ; Layer 2 scroll
dw $9729     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $826E     ; Room PLM list address (bank $8F)
dw $B905     ; Library background (bank $8F)
dw $91D4     ; Room setup routine (bank $8F)

; Room $96BA state $96EB: Header
; (event bit 00h)
org $8F96EB
dl $C3C998   ; Level data address
db $02       ; Tileset
db $09       ; Music data index
db $05       ; Music track index
dw $8060     ; FX address (bank $83)
dw $88C9     ; Enemy population offset (bank $A1)
dw $81D3     ; Enemy graphics set offset (bank $B4)
dw $C1C1     ; Layer 2 scroll
dw $9729     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $826E     ; Room PLM list address (bank $8F)
dw $B905     ; Library background (bank $8F)
dw $91BC     ; Room setup routine (bank $8F)

; Room $96BA state $9705: Header
; (event bit 0eh)
org $8F9705
dl $C3C998   ; Level data address
db $02       ; Tileset
db $24       ; Music data index
db $07       ; Music track index
dw $8020     ; FX address (bank $83)
dw $85B2     ; Enemy population offset (bank $A1)
dw $8111     ; Enemy graphics set offset (bank $B4)
dw $C1C1     ; Layer 2 scroll
dw $9729     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $C124     ; Room main routine (bank $8F)
dw $830C     ; Room PLM list address (bank $8F)
dw $B905     ; Library background (bank $8F)
dw $91A9     ; Room setup routine (bank $8F)

; Room $96BA state $96D1: Enemy population
org $A185E1
;  enemy  x      y      init   props  extra  param1 param2
dw $D87F, $0114, $004C, $0000, $2400, $0000, $5003, $0050 ; sbug
dw $D87F, $0110, $0058, $0000, $2400, $0000, $9002, $0050 ; sbug
dw $D87F, $010D, $0072, $0000, $2400, $0000, $AC03, $0050 ; sbug
dw $D87F, $01EB, $0096, $0000, $2400, $0000, $C804, $0050 ; sbug
dw $D87F, $01F3, $009A, $0000, $2400, $0000, $C303, $0050 ; sbug
dw $D87F, $0115, $0126, $0000, $2400, $0000, $9203, $0050 ; sbug
dw $D87F, $0114, $0123, $0000, $2400, $0000, $6003, $0050 ; sbug
dw $D87F, $0111, $0128, $0000, $2400, $0000, $9C02, $0050 ; sbug
dw $D87F, $01EE, $0217, $0000, $2400, $0000, $F004, $0050 ; sbug
dw $D87F, $0116, $06B9, $0000, $2400, $0000, $BC02, $0050 ; sbug
dw $FFFF     ; end of list
db $00       ; death quota

; Room $96BA state $96EB: Enemy population
org $A188C9
; ;  enemy  x      y      init   props  extra  param1 param2
; dw $F353, $0130, $00D8, $0000, $2000, $0004, $8000, $00A0 ; batta1 (crateria grey wall pirate)
; dw $F353, $01D0, $0128, $0000, $2000, $0004, $8001, $00A0 ; batta1 (crateria grey wall pirate)
; dw $F353, $0130, $01D8, $0000, $2000, $0004, $8000, $00A0 ; batta1 (crateria grey wall pirate)
; dw $F353, $0130, $0338, $0000, $2000, $0004, $8000, $00A0 ; batta1 (crateria grey wall pirate)
; dw $F353, $01D0, $03D8, $0000, $2000, $0004, $8001, $00A0 ; batta1 (crateria grey wall pirate)
; dw $F353, $0130, $04B8, $0000, $2000, $0004, $8000, $00A0 ; batta1 (crateria grey wall pirate)
; dw $F353, $01D0, $05A8, $0000, $2000, $0004, $8001, $00A0 ; batta1 (crateria grey wall pirate)
; dw $F353, $012D, $0698, $0000, $2000, $0004, $8000, $00A0 ; batta1 (crateria grey wall pirate)
; dw $F353, $01D0, $0278, $0000, $2000, $0004, $8001, $00A0 ; batta1 (crateria grey wall pirate)
; dw $F353, $01D0, $0708, $0000, $2000, $0004, $8001, $00A0 ; batta1 (crateria grey wall pirate)
; dw $F353, $0130, $07C8, $0000, $2000, $0004, $8000, $00A0 ; batta1 (crateria grey wall pirate)
; dw $FFFF     ; end of list
;                    x      y   init  props   xtra     p1     p2
dw !elevator,     $0180, $08A2, $0000, $2C00, $0000, $0001, $0018
dw !samus_statue, $0178, $0894, $0000, $2400, $0000, $0000, $0000
dw $FFFF
db $00
db $0B       ; death quota

; Room $96BA state $9705: Enemy population
org $A185B2
;  enemy  x      y      init   props  extra  param1 param2
dw $F613, $0080, $0880, $0000, $2800, $0004, $0000, $0000 ; batta2Tu (tourian silver pirate)
dw $F613, $00C0, $0880, $0000, $2800, $0004, $0000, $0000 ; batta2Tu (tourian silver pirate)
dw $FFFF     ; end of list
db $02       ; death quota

; Room $96BA state $96D1: Enemy graphics set
org $B4814F
;  enemy  palette
dw $D87F, $0007 ; sbug
dw $EA7F, $0007 ; koma
dw $FFFF     ; end of list
warnpc $B4815A

; Room $96BA state $96EB: Enemy graphics set
org $B481D3
;  enemy  palette
; dw $F353, $0001 ; batta1 (crateria grey wall pirate)
dw !samus_statue, $0001
dw $FFFF     ; end of list
db $00
warnpc $B481DA

; Room $96BA state $9705: Enemy graphics set
org $B48111
;  enemy  palette
dw $F613, $0002 ; batta2Tu (tourian silver pirate)
dw $FFFF     ; end of list
warnpc $B48118

; Room $96BA state $96D1: FX
org $83818E
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $FFFF, $FFFF, $0000 : db $00, $0C, $02, $30, $00, $00, $00, $62

; Room $96BA state $96EB: FX
org $838060
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $AB34, $0908, $0000, $FF80 : db $20, $02, $02, $1E, $0B, $1F, $01, $02
dw $0000, $FFFF, $FFFF, $0000 : db $00, $00, $02, $02, $00, $00, $00, $00

; Room $96BA state $9705: FX
org $838020
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $08E8, $0010, $FF98 : db $28, $04, $02, $1E, $01, $38, $00, $00

; Room $96BA, door list index 0: Door
; TODO - I found the "distance to spawn" through trial-and-error.  The
; usual way to do this is to have an elevator bring Samus into the room,
; and the elevator will stop at the right location, but I don't want
; anyone to see an elevator when the door is opened.
org $838B3E
dw $92FD        ; room id
db $80          ; bitflags
db $07          ; direction (3=up, 7=up w/ closing door behind)
db $16          ; door cap x
db $4D          ; door cap y
db $01          ; screen x
db $04          ; screen y
dw $05b0        ; distance to spawn
dw top_door_sub ; door subroutine

org !FREESPACE_8F

climb_doors:
{
  ; TODO - I do not remember why I needed to add $88FC to the door list
  ; dw $8B3E, $8B4A, $8B56, $8B62, $8B6E
  dw $8B3E, $8B4A, $8B56, $8B62, $8B6E, $88FC
}

top_door_sub:
{
  LDA $0E18
  CMP #$0002
  BEQ in_door_transition

  ; Set elevator to inactive
  STZ $0E16
  STZ $0E18

  ; Re-enable Samus controls and set Samus drawing handler to default
  ; (i.e. no longer flashing)
  LDA #$000B
  JSL $90F084

  in_door_transition:
  JMP $B981
}

end_climb_freespace_8f:
!FREESPACE_8F := end_climb_freespace_8f
