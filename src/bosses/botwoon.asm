org !FREEMEM_7F

samus_is_hiding:
print "Variable samus_is_hiding: $", pc
skip 2

botwoon_wall_crumble_started:
print "Variable botwoon_wall_crumble_started: $", pc
skip 2

end_botwoon_freemem_7f:
!FREEMEM_7F := end_botwoon_freemem_7f

; Init extra variables
org $B39663
JSR botwoon_extra_init
RTL

warnpc $B39668

; Disable botwoon spit
org $B39F0A : JMP $9F17
org $BE9F57 : JMP $9F61

; Disable spit sound effect
org $B39572 : RTL

; Keep health above 800
org $B3A036
LDA #$0320
STA $0F8C,x
RTL

; Keep botwoon full health behavior even when damaged
; TODO - use the flag set in this function ($7E:803E) to override
; Botwoon's behavior and force coming out of the hole if Samus is hidden
org $B3995D

botwoon_set_action_from_health:
{
  ; Never come out of hiding in the first round
  LDA $7E8832,x
  BNE .return

  ; Stay in the hole if Samus is not hiding
  LDA samus_is_hiding
  BEQ .return

  ; Come out of the hole if Samus is hiding
  LDA #$0002 : STA $7E803E,x
  LDA #$0003 : STA $7E8030,x
  LDA #$000C : STA $7E0FAC,x

.return:
  RTS
}

org $B396C6

botwoon_death_check:
{
  JSR check_samus_is_hiding
  JSR check_botwoon_is_near_wall

  ; TODO - if Samus is on the right side of the column, then knock it
  ; down (so she can't get stuck)

  RTS
}

warnpc $B396F5


org $B398C5
JSR filter_hole_state
warnpc $B398C8

org $B39A1E
JSR filter_hole_state_after_spitting
warnpc $B39A21

; -----------------------

org !FREESPACE_B3

botwoon_extra_init:
{
  STA $7E881C,x ; instruction at end of $B3:9583 that was overwritten

  LDA #$0000
  STA samus_is_hiding
  STA botwoon_wall_crumble_started

  RTS
}

filter_hole_state:
{
  PHA
  LDA samus_is_hiding
  BNE .samus_is_hiding

.samus_is_not_hiding:
  PLA
  LDA #$0008
  RTS

.samus_is_hiding:
  PLA
  AND #$000E

  RTS
}

filter_hole_state_after_spitting:
{
  PHA
  LDA samus_is_hiding
  BNE .samus_is_hiding

.samus_is_not_hiding:
  PLA
  LDA #$0001
  RTS

.samus_is_hiding:
  PLA
  AND #$0001

  RTS
}

check_samus_is_hiding:
{
  LDA $0AF6 ; samus x
  CMP #$00D4 : BPL .test_hiding_right_side

.test_hiding_left_side:

  CMP #$0049 : BMI .clear_samus_is_hiding
  CMP #$0057 : BPL .clear_samus_is_hiding

  LDA $0AFA ; samus y
  CMP #$00AD : BMI .clear_samus_is_hiding

  BRA .set_samus_is_hiding

.test_hiding_right_side:
  LDA $0AFA ; samus y
  CMP #$00C8 : BMI .clear_samus_is_hiding

.set_samus_is_hiding:
  LDA #$0001
  STA samus_is_hiding
  RTS

.clear_samus_is_hiding:
  LDA #$0000
  STA samus_is_hiding
  RTS
}

check_botwoon_is_near_wall:
{
  ; TODO:
  ; - only do this once
  ; - botwoon must be visible (7E:8026?)
  ; - botwoon should be heading toward the right (7E:8034)

  ; Check to see if botwoon is near the wall
  LDX $0E54
  LDA $0F7A,x
  CMP #$00D0
  BMI .return

.break_wall:
  JSR break_botwoon_wall

  ; TODO: set boss defeated flag

.return:
  RTS
}

break_botwoon_wall:
{
  LDA botwoon_wall_crumble_started
  BNE .return

  LDA #$0001
  STA botwoon_wall_crumble_started

  JSL $8483D7
  db $0F, $04
  dw $B79B
  RTS

.return:
  RTS
}

end_botwoon_freespace_b3:
!FREESPACE_B3 := end_botwoon_freespace_b3
