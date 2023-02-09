org !FREEMEM_7F

print "Botwoon variables:"

samus_is_hiding:
print "  samus_is_hiding - $", pc
skip 2

botwoon_is_seeking:
print "  botwoon_is_seeking - $", pc
skip 2

botwoon_wall_crumble_started:
print "  botwoon_wall_crumble_started - $", pc
skip 2

end_botwoon_freemem_7f:
!FREEMEM_7F := end_botwoon_freemem_7f

;;
; Init extra variables
;

org $B39663
JSR botwoon_extra_init
RTL

warnpc $B39668

;;
; Disable botwoon spit
;
;

org $B39F0A : JMP $9F17
org $BE9F57 : JMP $9F61

;;
; Disable spit sound effect
;

org $B39572 : RTL

;;
; Keep health above 800
;

org $B3A036
LDA #$0320
STA $0F8C,x
RTL

;;
; Keep botwoon full health behavior even when damaged
;
; TODO - use the flag set in this function ($7E:803E) to override
; Botwoon's behavior and force coming out of the hole if Samus is hidden
;

org $B3995D

botwoon_set_action_from_health:
{
  ; Never come out of hiding in the first round
  LDA $7E8832,x
  BNE .return

  ; Stay in the hole if Samus is not hiding
  LDA samus_is_hiding
  BEQ .samus_is_not_hiding

.samus_is_hiding:
  ; Come out of the hole if Samus is hiding
  LDA #$0002 : STA $7E803E,x
  LDA #$0003 : STA $7E8030,x
  LDA #$000C : STA $7E0FAC,x

  ; Set the seeking flag is Samus is hiding
  ; TODO - I think this should be unnecessary, but apparently this flag
  ; does not get set in some cases from the other two places it can get
  ; set, and I don't know why.
  LDA #$0001
  STA botwoon_is_seeking
  BRA .return

.samus_is_not_hiding
  LDA #$0000
  STA botwoon_is_seeking

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

;;
; Change when Botwoon comes out of the hole (hide-and-seek game)
;

org $B398C5
JSR filter_hole_state
warnpc $B398C8

org $B39A1E
JSR filter_hole_state_after_spitting
warnpc $B39A21 ; patch for $B3:98C5


;;
; Change Botwoon movement when Samus is hiding (to break the wall)
;

org $B39958
JSR botwoon_store_new_movement_state
RTS

; -----------------------

%BEGIN_FREESPACE(B3)

botwoon_extra_init:
{
  STA $7E881C,x ; instruction at end of $B3:9583 that was overwritten

  LDA #$0000
  STA samus_is_hiding
  STA botwoon_is_seeking
  STA botwoon_wall_crumble_started

  RTS
}

filter_hole_state: ; patch for $B3:98C5 (AND #$000E)
{
  PHA
  LDA samus_is_hiding
  BNE .samus_is_hiding

.samus_is_not_hiding:
  ; If Samus is not hiding, keep Botwoon invisible during movement
  PLA
  LDA #$0008
  RTS

.samus_is_hiding:
  ; If Samus is hiding, set the seeking flag
  ; TODO TODO TODO - sometimes this never gets set and Botwoon has
  ; seeking behavior without the seeking flag set.  In that case Botwoon
  ; keeps seeking even when Samus is out of the hole (desirable after
  ; the wall is broken, but undesirable before).
  LDA #$0001
  STA botwoon_is_seeking

  ; If Samus is hiding, revert to original behavior
  PLA
  AND #$000E

  RTS
}

filter_hole_state_after_spitting: ; patch for $B3:9A1E (AND #$0001)
{
  PHA
  LDA samus_is_hiding
  BNE .samus_is_hiding

.samus_is_not_hiding:
  ; TODO TODO - I probably want to unset botwoon_is_seeking here, in
  ; case Botwoon goes back into the hole.
  ;
  ; I am not sure whether I want to also unset it in filter_hole_state,
  ; because I don't want to unset it until Botwoon is fully in the hole,
  ; and I'm not 100% confident I remember the conditions when
  ; filter_hole_state is called.

  ; If Samus is not hiding, keep spitting
  PLA
  LDA #$0001
  RTS

.samus_is_hiding:
  ; If Samus is hiding, set the seeking flag
  ; TODO - I thought setting the seeking flag here would be unnecessary
  ; (and the wrong thing to do -- since other than on init this makes
  ; botwoon_is_seeking the same as checking $7E;8026.
  LDA #$0001
  STA botwoon_is_seeking

  ; If Samus is hiding, revert to original behavior
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

  ; Break the column if Samus is inside the bowl
  BRA .set_samus_is_hiding

.test_hiding_right_side:
  ; Break the column if Samus enters the room from the right side
  LDA $0AF6
  CMP #$100 : BPL .set_samus_is_hiding

  ; Break the column if Samus is inside the right-side tunnel
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
  ; Check to see if Botwoon is seeking
  LDA botwoon_is_seeking
  BEQ .return

  ; Check to see if this is the first round
  ; TODO - this check does not work; Botwoon can still break the wall
  ; before entering the hole on the first round if he is close enough to
  ; the wall
  LDA $7E8832
  BNE .return

  ; Check to see if botwoon is near the wall
  LDX $0E54
  LDA $0F7A,x
  CMP #$00F0
  BMI .return

  ; Check to see it botwoon is invisible
  LDA $7E8026
  BNE .return

  ; Check to see if botwoon is spitting
  LDA $7E8834
  BNE .return

  LDA $7E8002
  BNE .return

  ; Check to see if botwoon is heading back into a hole
  ; TODO - this check might be a little too aggressive, because it means
  ; that to break the wall Botwoon has to be near the wall but not
  ; heading into the right-side hole.
  LDA $7E802A
  BNE .return

.break_wall:
  JSR break_botwoon_wall

.return:
  RTS
}

break_botwoon_wall:
{
  LDA botwoon_wall_crumble_started
  BNE .return

  LDA #$0001
  STA botwoon_wall_crumble_started

  ; Spawn PLM to break the wall
  JSL $8483D7
  db $0F, $04
  dw $B79B

  ; Set mini boss bits for current area
  LDA #$0002
  JSL $8081A6

.return:
  RTS
}

botwoon_store_new_movement_state:
{
  STA $7E8800,x

  LDA samus_is_hiding
  BEQ .return

  ; If botwoon is at the right-side hole, do a loop toward the right,
  ; through the wall
  ; TODO - I don't think I did this comparison correctly, because it
  ; changes Botwoon's movement even when coming out of hole other than
  ; the right-side hole
  LDA $7E8800,x
  CMP #$0060
  BMI .return

  LDA #$0018
  STA $7E8800,x

.return
  RTS
}

%END_FREESPACE(B3)

;;
; Make the wall break immediately instead of waiting 40 frames
;

org $84AB29
LDA #$0001

;;
; Make the wall crumble faster
;

!botwoon_wall_crumble_delay = $0002

org $84AB39+$00 : dw !botwoon_wall_crumble_delay
org $84AB39+$04 : dw !botwoon_wall_crumble_delay
org $84AB39+$08 : dw !botwoon_wall_crumble_delay
org $84AB39+$0C : dw !botwoon_wall_crumble_delay
