; Permanently hides the body.
; TODO - undo if samus is hidden when botwoon comes out
org $B39CBC : LDA #$0001

; Hide botwoon's head except when coming out of the hole
; TODO - undo if samus is hidden when botwoon comes out
org $B39E1F : LDA #$9389

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
org $B3995D : RTS

org !FREEMEM_7F

samus_is_hiding:
print "Variable samus_is_hiding: $", pc
skip 2

end_botwoon_freemem_7f:
!FREEMEM_7F := end_botwoon_freemem_7f

org $B396C6

botwoon_death_check:
{
  JSR check_samus_is_hiding

  # TODO - if botwoon is visible and botwoon is near the column, then
  # knock it down and open the door

  # TODO - if Samus is on the right side of the column, then knock it
  # down

  RTS
}

warnpc $B396F5

org !FREESPACE_B3

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
  BRA .return

.clear_samus_is_hiding:
  LDA #$0000
  STA samus_is_hiding

.return:
  RTS
}

end_botwoon_freespace_b3:
!FREESPACE_B3 := end_botwoon_freespace_b3
