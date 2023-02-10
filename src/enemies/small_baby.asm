%BEGIN_FREESPACE(A0)

small_baby:

dw $1000           ; tile data size
dw $E9AF           ; palette
dw $01F4           ; health
dw $0078           ; damage
dw $000A           ; x radius
dw $000A           ; y radius
db $A3             ; bank
db $00             ; hurt ai time
dw $005A           ; cry
dw $0000           ; boss value
; dw $EA4F           ; init ai routine
dw small_baby_setup
dw $0001           ; number of parts
dw $0000           ; unused
; dw $EB98           ; main ai routine
dw small_baby_main_ai
dw $800F           ; grapple ai routine
; dw $EB33           ; hurt ai routine
dw $804C           ; hurt ai routine
; dw $EAE6           ; frozen ai routine
; dw $8041           ; frozen ai routine
dw small_baby_frozen_ai
dw $0000           ; time is frozen ai routine
dw $0004           ; death animation
dd $00000000       ; unused
; dw $F042           ; power bomb reaction
dw $0000           ; power bomb reaction
dw $0000           ; unknown
dd $00000000       ; unused
dw $EDEB           ; touch routine
; dw $EF07           ; shot routine
dw small_baby_shot_routine
dw $0000           ; unknown
dl $AE9000         ; tile data
db $05             ; layer
dw $F36E           ; drop chances
; dw $EF60           ; vulnerabilities
dw $EEC6           ; vulnerabilities (invulnerable)
dw $DFAB           ; enemy name

%assertpc(small_baby+$40)

%END_FREESPACE(A0)

%BEGIN_FREESPACE(A3)

small_baby_setup:
{
  ; jump to normal metroid setup
  JMP $EA4F
}

small_baby_main_ai:
{
  ; If the door is open, make a run for it
  LDA $7F0002+(2*(($10*6)+$0E))
  CMP #$0082
  BEQ .escape
  CMP #$800F
  BEQ .stop

.metroid_ai:
  ; jump to normal metroid main ai
  JMP $EB98

.stop:
  LDA #$0000 : STA $0FAA,x
  LDA #$0000 : STA $0FAC,x
  RTL

.escape:
  LDA #$0200 : STA $12
  LDA #$0080 : STA $14
  LDA #$0040
  ; LDY #$0001
  JSL small_baby_accel_to_point
  JSL $A9C3EF
  JMP $EBAD
}

small_baby_shot_routine:
{
  ; spawn PB explosion
  LDX $0E54
  LDA $0F7A,x : STA $0CE2
  LDA $0F7E,x : STA $0CE4
  JSL $888AB0

  ; jump to normal metroid shot routine
  JMP $EF07
}

small_baby_frozen_ai:
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

small_baby_accel_to_point:
{
  JSR $F5A6
  RTL
}

%END_FREESPACE(A9)
