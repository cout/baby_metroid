%BEGIN_FREESPACE(A0)

hatchling:

dw $0200          ; tile data size
; dw $A725          ; palette
dw $E9AF          ; palette
dw $0064          ; health
dw $005A          ; damage
dw $0008          ; x radius
dw $0008          ; y radius
db $A3            ; bank
db $00            ; hurt ai time
dw $0058          ; cry
dw $0000          ; boss value
; dw $A77D          ; init ai routine
dw hatchling_setup
dw $0001          ; number of parts
dw $0000          ; unused
; dw $A790          ; main ai routine
dw hatchling_main_ai
dw $800A          ; grapple ai routine
dw $804C          ; hurt ai routine
dw $8041          ; frozen ai routine
dw $0000          ; time is frozen ai routine
dw $0002          ; death animation
dd $00000000      ; unused
dw $0000          ; power bomb reaction
dw $0000          ; unknown
dd $00000000      ; unused
dw $A953          ; touch routine
dw $A9A8          ; shot routine
dw $0000          ; unknown
; dl $AC9400        ; tile data
dl hatchling_tile_data
db $05            ; layer
dw $F218          ; drop chances
dw $EC1C          ; vulnerabilities (invulnerable)
dw $DF9D          ; enemy name

%assertpc(hatchling+$40)

big_hatchling:

dw $0400          ; tile data size
dw $A725          ; palette
; dw $E9AF          ; palette
dw $0064          ; health
dw $005A          ; damage
dw $0008          ; x radius
dw $0008          ; y radius
db $A3            ; bank
db $00            ; hurt ai time
dw $0058          ; cry
dw $0000          ; boss value
; dw $A77D          ; init ai routine
dw big_hatchling_setup
dw $0001          ; number of parts
dw $0000          ; unused
; dw $A790          ; main ai routine
dw big_hatchling_main_ai
dw $800A          ; grapple ai routine
dw $804C          ; hurt ai routine
dw $8041          ; frozen ai routine
dw $0000          ; time is frozen ai routine
dw $0002          ; death animation
dd $00000000      ; unused
dw $0000          ; power bomb reaction
dw $0000          ; unknown
dd $00000000      ; unused
dw $A953          ; touch routine
dw $A9A8          ; shot routine
dw $0000          ; unknown
; dl $AC9400        ; tile data
dl big_hatchling_tile_data
db $05            ; layer
dw $F218          ; drop chances
dw $EC1C          ; vulnerabilities (invulnerable)
dw $DF9D          ; enemy name

%assertpc(big_hatchling+$40)

%END_FREESPACE(A0)

%BEGIN_FREESPACE(A3)

hatchling_setup:
{
  ; call mochtroid setup
  JSL $A3A77D

  LDA.w #hatchling_instruction_list
  ; JSR $A942
  STA $0F92,x
  LDA #$0001
  STA $0F94,x

  JSR hatchling_set_exit_block

  ; Hatchling is gone after escaping through flyway exit
  LDA !EVENT_HATCHLING_ESCAPE
  JSL $808233
  BCC +
  LDA #hatchling_sleep_instruction_list
  STA $0F92,x
+

  RTL
}

big_hatchling_setup:
{
  ; call mochtroid setup
  JSL $A3A77D

  JSR hatchling_set_exit_block

  ; Big hatchling is gone after Ridley is visited
  LDA #$0001
  JSL $8081DC
  BCS .sleep

  ; Big hatchling is gone after escaping through screw attack room exit
  LDA !EVENT_HATCHLING_ESCAPE
  JSL $808233
  BCS .sleep

  BRA .return

.sleep:
  LDA #hatchling_sleep_instruction_list
  STA $0F92,x

.return:
  RTL
}

hatchling_set_exit_block:
{
  ; $0FB0,x = position of block to test for an exit
  SEP #$20
  LDA $0FB4,x : STA $4202
  LDA $07A5   : STA $4203
  REP #$20
  LDA $0FB5,x : AND #$00FF
  CLC
  ADC $4216
  ASL
  STA $0FB0,x ; unused mochtroid variable

  RTS
}

hatchling_sleep_instruction_list:
{
  dw $812F
}

hatchling_instruction_list:
{
.top:
  dw $000E, hatchling_frame_1
  dw $000E, hatchling_frame_2
  dw $000E, hatchling_frame_3
  dw $000E, hatchling_frame_2
  dw $80ED, .top
}

hatchling_frame_1:
dw $0004
dw $01F8 : db $F8 : dw $2102
dw $0000 : db $F8 : dw $2103
dw $01F8 : db $00 : dw $2106
dw $0000 : db $00 : dw $2107

hatchling_frame_2:
dw $0004
dw $01F8 : db $F8 : dw $2108
dw $0000 : db $F8 : dw $2109
dw $01F8 : db $00 : dw $210C
dw $0000 : db $00 : dw $210D

hatchling_frame_3:
dw $0004
dw $01F8 : db $F8 : dw $210A
dw $0000 : db $F8 : dw $210B
dw $01F8 : db $00 : dw $210E
dw $0000 : db $00 : dw $210F

hatchling_main_ai:
{
  ; Only try to escape if player has bombs
  ; (TODO - BT code?)
  LDA $09A4
  AND #$1000
  BEQ .main_ai

  LDA !EVENT_HATCHLING_ESCAPE
  JSL $8081FA

  JSR hatchling_try_to_escape
  BCS .escaped

.main_ai:
  JMP $A790

.escaped:
  RTL
}

big_hatchling_main_ai:
{
  ; Only try to escape if GT has been visited
  LDA #$0004
  JSL $8081DC
  BCC .main_ai

  LDA !EVENT_BIG_HATCHLING_ESCAPE
  JSL $8081FA

  JSR hatchling_try_to_escape
  BCS .escaped

.main_ai:
  JMP $A790

.escaped:
  RTL
}

hatchling_try_to_escape:
{
  ; If the door is open, make a run for it
  PHX
  LDA $0FB0,x
  TAX
  LDA $7F0002,x
  PLX
  CMP #$0082 : BEQ .escape_right
  CMP #$0482 : BEQ .escape_left
  AND #$F0FF
  CMP #$800F : BEQ .stop

  CLC
  RTS

.stop:
  LDA #$0000 : STA $0FAA,x
  LDA #$0000 : STA $0FAC,x
  SEC
  RTS

.escape_left:
  LDA $0FB5,x
  AND #$00FF
  ASL : ASL : ASL : ASL
  SEC : SBC #$0020
  STA $12
  BRA .escape

.escape_right:
  ; Set X target position
  LDA $0FB5,x
  AND #$00FF
  ASL : ASL : ASL : ASL
  CLC : ADC #$0020
  STA $12

.escape:
  ; Set Y target position
  LDA $0FB4,x
  AND #$00FF
  INC
  ASL : ASL : ASL : ASL
  STA $14
  STA $7FFC02

  ; Accelerate and move toward target
  LDA #$0040
  JSL hatchling_accel_to_point
  JSL $A9C3EF

  SEC
  RTS
}

hatchling_shot_routine:
{
  ;;; ; spawn PB explosion
  ;;; LDX $0E54
  ;;; LDA $0F7A,x : STA $0CE2
  ;;; LDA $0F7E,x : STA $0CE4
  ;;; JSL $888AB0

  ;;; ; jump to normal metroid shot routine
  ;;; JMP $EF07

  JMP $A9A8
}

hatchling_frozen_ai:
{
  LDA $0F9E,x
  CMP #$005A
  BMI .return

  ; limit frozen time to 90 frames
  LDA #$005A
  STA $0F9E,x

.return:
  ; call normal frozen ai
  JSL $A0957E

  RTL
}

%END_FREESPACE(A3)

%BEGIN_FREESPACE(A9)

hatchling_accel_to_point:
{
  JSR $F5A6
  RTL
}

%END_FREESPACE(A9)

%BEGIN_FREESPACE(B8)

hatchling_tile_data:
incbin "hatchling.chr"

big_hatchling_tile_data:
incbin "big_hatchling.chr"

%END_FREESPACE(B8)
