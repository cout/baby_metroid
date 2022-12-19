; Init extra variables
org $B39663
JSR botwoon_extra_init
RTL

warnpc $B39668

; Hide the body unless Samus is hidden
org $B39CBC

JSR set_segment_hidden
JMP $9CC3

warnpc $B39CC3

; Hide the head except when coming out of the hole or Samus is hidden
org $B39E1F : JSR get_mouth_close_instruction

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

warnpc $B399A4

org !FREEMEM_7F

samus_is_hiding:
print "Variable samus_is_hiding: $", pc
skip 2

botwoon_segment_behind_wall:
print "Variable botwoon_segment_behind_wall: $", pc
skip 36

end_botwoon_freemem_7f:
!FREEMEM_7F := end_botwoon_freemem_7f

org $B396C6

botwoon_death_check:
{
  JSR check_samus_is_hiding

  ; TODO - if botwoon is visible and botwoon is near the column, then
  ; knock it down and open the door

  ; TODO - if Samus is on the right side of the column, then knock it
  ; down

  RTS
}

warnpc $B396F5

org !FREESPACE_B3

botwoon_extra_init:
{
  STA $7E881C,x ; instruction at end of $B3:9583 that was overwritten

  LDA #$0000
  STA samus_is_hiding

  PHX
  LDX #$0000 : LDA $7E7820,x : STA botwoon_segment_behind_wall,x
  LDX #$0002 : LDA $7E7820,x : STA botwoon_segment_behind_wall,x
  LDX #$0004 : LDA $7E7820,x : STA botwoon_segment_behind_wall,x
  LDX #$0006 : LDA $7E7820,x : STA botwoon_segment_behind_wall,x
  LDX #$0008 : LDA $7E7820,x : STA botwoon_segment_behind_wall,x
  LDX #$000A : LDA $7E7820,x : STA botwoon_segment_behind_wall,x
  LDX #$000C : LDA $7E7820,x : STA botwoon_segment_behind_wall,x
  LDX #$000E : LDA $7E7820,x : STA botwoon_segment_behind_wall,x
  LDX #$0010 : LDA $7E7820,x : STA botwoon_segment_behind_wall,x
  LDX #$0012 : LDA $7E7820,x : STA botwoon_segment_behind_wall,x
  LDX #$0014 : LDA $7E7820,x : STA botwoon_segment_behind_wall,x
  LDX #$0016 : LDA $7E7820,x : STA botwoon_segment_behind_wall,x
  LDX #$0018 : LDA $7E7820,x : STA botwoon_segment_behind_wall,x
  LDX #$001A : LDA $7E7820,x : STA botwoon_segment_behind_wall,x
  LDX #$001C : LDA $7E7820,x : STA botwoon_segment_behind_wall,x
  LDX #$001E : LDA $7E7820,x : STA botwoon_segment_behind_wall,x
  LDX #$0020 : LDA $7E7820,x : STA botwoon_segment_behind_wall,x
  LDX #$0022 : LDA $7E7820,x : STA botwoon_segment_behind_wall,x
  PLX

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

get_mouth_close_instruction:
{
  LDA $7E8832,x
  BNE .samus_is_not_hiding

  LDA samus_is_hiding
  BNE .samus_is_hiding

.samus_is_not_hiding:
  LDA #$9389
  RTS

.samus_is_hiding:
  LDA $946B,y
  RTS
}

set_segment_hidden:
{
  LDA botwoon_segment_behind_wall,x
  EOR #$0001
  STA botwoon_segment_behind_wall,x

  LDA $7E8832,x
  BNE .samus_is_not_hiding

  LDA samus_is_hiding
  BNE .samus_is_hiding

.samus_is_not_hiding:
  LDA #$0001
  STA $7E7820,x
  RTS

.samus_is_hiding:
  LDA botwoon_segment_behind_wall,x
  STA $7E7820,x
  RTS
}

end_botwoon_freespace_b3:
!FREESPACE_B3 := end_botwoon_freespace_b3
