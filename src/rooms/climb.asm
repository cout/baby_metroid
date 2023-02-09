!TOP_DOOR_INDEX = $D0

%BEGIN_FREESPACE(B8)

climb_with_elevator_level_data:
incbin "climb.bin"

%END_FREESPACE(B8)

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
; dl $C3C998   ; Level data address
dl climb_with_elevator_level_data
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
; dw $826E     ; Room PLM list address (bank $8F)
dw climb_zebes_awake_room_plm
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
; dw $85B2     ; Enemy population offset (bank $A1)
; dw $8111     ; Enemy graphics set offset (bank $B4)
dw climb_escape_enemy_population
dw climb_escape_enemy_graphics_set
dw $C1C1     ; Layer 2 scroll
dw $9729     ; Room scroll data (bank $8F)
dw $0000     ; Room var
; dw $C124     ; Room main routine (bank $8F)
dw climb_escape_main
; dw $830C     ; Room PLM list address (bank $8F)
dw climb_escape_room_plm
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

%BEGIN_FREESPACE(A1)

climb_escape_enemy_population:

; Room $96BA state $9705: Enemy population
; org $A185B2
;  enemy  x      y      init   props  extra  param1 param2
dw !baby, $0000, $088B, $0000, $2C00, $0000, $0000, $0000 ; baby
; dw $F613, $0080, $0880, $0000, $2800, $0004, $0000, $0000 ; batta2Tu (tourian silver pirate)
; dw $F613, $00C0, $0880, $0000, $2800, $0004, $0000, $0000 ; batta2Tu (tourian silver pirate)
dw $F793, $0080, $0880, $0000, $2800, $0004, $0000, $0000 ; batta3Tu (tourian silver pirate)
dw $F793, $00C0, $0880, $0000, $2800, $0004, $0000, $0000 ; batta3Tu (tourian silver pirate)
dw $FFFF     ; end of list
db $02       ; death quota

%END_FREESPACE(A1)

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

%BEGIN_FREESPACE(B4)

climb_escape_enemy_graphics_set:

; Room $96BA state $9705: Enemy graphics set
;org $B48111
;  enemy  palette
; dw $F613, $0002 ; batta2Tu (tourian silver pirate)
dw $F793, $0002 ; batta2Tu (tourian silver pirate)
dw !baby, $0007 ; baby
dw $FFFF     ; end of list
;warnpc $B48118

%END_FREESPACE(B4)

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
org $838B3E
dw $92FD        ; room id
db $80          ; bitflags
db $07          ; direction (3=up, 7=up w/ closing door behind)
db $16          ; door cap x
db $4D          ; door cap y
db $01          ; screen x
db $04          ; screen y
dw $01C0        ; distance to spawn
; dw $B981        ; door subroutine
dw top_door_sub ; door subroutine

%BEGIN_FREESPACE(8F)

climb_doors:
{
  ; TODO - I do not remember why I needed to add $88FC to the door list
  ; dw $8B3E, $8B4A, $8B56, $8B62, $8B6E
  dw $8B3E, $8B4A, $8B56, $8B62, $8B6E, $88FC
}

top_door_sub:
{
  LDA $0E16
  BEQ .not_on_an_elevator

  LDA $0E18
  CMP #$0002
  BEQ .in_transition

  ; Set Samus position explicitly
  LDA #$0180 : STA $0AF6
  LDA #$04EF : STA $0AFA

  ; Set elevator to inactive
  STZ $0E16
  STZ $0E18

  ; Re-enable Samus controls and set Samus drawing handler to default
  ; (i.e. no longer flashing)
  LDA #$000B
  JSL $90F084

.not_on_an_elevator:
.in_transition:
  JMP $B981
}

; Room $96BA, state $96EB: PLM
climb_zebes_awake_room_plm:
{
  dw $B703, $051D, $9747 ; scroll plm
  dw $B703, $0520, $9744 ; scroll plm
  dw $B703, $761D, $974D ; scroll plm
  dw $B703, $7620, $974A ; scroll plm
  dw $B63F, $8512, $8000 ; rightward extension
  dw $B63F, $8513, $8000 ; rightward extension
  dw $B647, $8514, $8000 ; downward extension
  dw $B647, $8614, $8000 ; downward extension
  dw $B647, $8714, $8000 ; downward extension
  dw $B647, $8814, $8000 ; downward extension
  dw $B703, $8914, $9753 ; scroll plm
  dw $B647, $860F, $8000 ; downward extension
  dw $B647, $870F, $8000 ; downward extension
  dw $B647, $880F, $8000 ; downward extension
  dw $B703, $890F, $9750 ; scroll plm
  dw $B647, $860D, $8000 ; downward extension
  dw $B647, $870D, $8000 ; downward extension
  dw $B647, $880D, $8000 ; downward extension
  dw $B703, $890D, $9756 ; scroll plm
  dw $B647, $8608, $8000 ; downward extension
  dw $B647, $8708, $8000 ; downward extension
  dw $B647, $8808, $8000 ; downward extension
  dw $B703, $8908, $9759 ; scroll plm
  dw $C842, $062E, $9011 ; grey door facing left
  dw $C848, $8601, $9012 ; grey door facing right
  dw $C85A, $762E, $0013 ; yellow door facing left
  dw $C854, $0216, $9014 ; grey door facing down
  dw $0000
}

; Room $96BA, state $9705: PLM
climb_escape_room_plm:
{
  ; existing:
  dw $B703,$051D,$9747 ; scroll plm
  dw $B703,$0520,$9744 ; scroll plm
  dw $B703,$761D,$974D ; scroll plm
  dw $B703,$7620,$974A ; scroll plm
  dw $B63F,$8512,$8000 ; rightward extension
  dw $B63F,$8513,$8000 ; rightward extension
  dw $B647,$8514,$8000 ; downward extension
  dw $B647,$8614,$8000 ; downward extension
  dw $B647,$8714,$8000 ; downward extension
  dw $B647,$8814,$8000 ; downward extension
  dw $B703,$8914,$9753 ; scroll plm
  dw $B647,$860F,$8000 ; downward extension
  dw $B647,$870F,$8000 ; downward extension
  dw $B647,$880F,$8000 ; downward extension
  dw $B703,$890F,$9750 ; scroll plm
  dw $B647,$860D,$8000 ; downward extension
  dw $B647,$870D,$8000 ; downward extension
  dw $B647,$880D,$8000 ; downward extension
  dw $B703,$890D,$9756 ; scroll plm
  dw $B647,$8608,$8000 ; downward extension
  dw $B647,$8708,$8000 ; downward extension
  dw $B647,$8808,$8000 ; downward extension
  dw $B703,$8908,$9759 ; scroll plm
  dw $DB44,$0808,$000C ; set metroids cleared state?
  dw $C842,$062E,$9014 ; grey door facing left
  dw $C842,$762E,$9015 ; grey door facing left
  dw $C842,$861E,$9016 ; grey door facing left
  dw $C848,$8601,$9017 ; grey door facing right

  ; new:
  dw $C854,$0216,($9000|!TOP_DOOR_INDEX)

  dw $0000 ; end of list
}

climb_escape_main:
{
  JSR $C124

  ; Unlock scroll based on Samus's X position rather than relying on
  ; scroll plms
  LDA $0AFA
  CMP #$00D0
  BMI +
  LDA #$0001
  STA $7ECD20+$19
+

  RTS
}

%END_FREESPACE(8F)
