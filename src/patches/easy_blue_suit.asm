;;;;;
;
; Easy blue suit - lets players get blue suit by holding the run button
; while on the ground.
;
; Bugs/Limitations:
; * It is not possible to acquire nor cancel blue suit while crouching
; * It is not possible to cancel blue suit in the air (it is
;   intentionally not possible to acquire blue suit in the air)
; * Samus can acquire blue suit slightly faster the first time easy blue
;   suit is used if the memory used by this patch gets initialized to a
;   a value between 400h and 4FFh.
; * Contact damage index ($0A6E) is set to 0 when stationary, 1 when
;   moving
;
;;;;;


;;
; Constants
;

!FULL_ECHOES_SPEED = #$0400
!MAX_ECHOES_SPEED = #$04FF
!ECHOES_ACCELERATION = #$0040

;;
; Memory used by this patch
;

%BEGIN_FREEMEM(7F)

print "Easy blue suit variables:"

; Counter: mimics $0B3E (speed counter)
; Most significant byte is the speed counter (0, 1, 2, 3, or 4)
; Least significant byte oscillates between 1/2 when at full speed
easy_blue_suit_counter:
print "  easy_blue_suit_counter - $", pc
skip 2

; Room where easy blue suit was acquired
easy_blue_suit_room:
print "  easy_blue_suit_room - $", pc
skip 2

easy_blue_suit_held_run_last_check:
print "  easy_blue_suit_held_run_last_check - $", pc
skip 2

easy_blue_suit_end_freemem_7f:

%END_FREEMEM(7F)

;;
; Easy blue suit hooks for various Samus positions
;
; These hooks are placed at the call to $91:DE53 (cancel speed boosting)
;

org $90A3D0 : JSL do_easy_blue_suit_check ; standing
org $90A551 : JSL do_easy_blue_suit_check ; morphed ball - on ground
; org $90A5D9 : JSL do_easy_blue_suit_check ; morphed ball - falling
org $90A685 : JSL do_easy_blue_suit_check ; turning around - on ground
org $90A6CF : JSL do_easy_blue_suit_check ; spring ball - on ground
; org $90A712 : JSL do_easy_blue_suit_check ; spring ball - falling
org $90A768 : JSL do_easy_blue_suit_check ; ran into a wall
; org $90A79E : JSL do_easy_blue_suit_check ; turning around - jumping
; org $90A7BB : JSL do_easy_blue_suit_check ; turning around - falling

; TODO - it would be nice to also hook $90:A573 (crouching), but there
; is no call to $90:A3D0 there, so hooking that routine requires some
; refactoring.

;;
; Set damage contact index to normal with easy blue suit
;
; This allows bomb jumping while pressed against a wall.
;

org $909821
JSR set_speed_boost_damage_contact_index


;;
; Routine to give easy blue suit
;

%BEGIN_FREESPACE(90)

do_easy_blue_suit_check:
{
  ; Disallow carrying easy blue suit to another room
  LDA $079B
  CMP easy_blue_suit_room
  BNE .cancel_blue_suit

  ; If speed booster is not equipped then follow the normal code path
  LDA $09A2
  BIT #$2000
  BEQ .call_cancel_blue_suit_routine

.same_room
  ; Check to see if player is holding the run button
  LDA $8B
  BIT $09B6
  BEQ .not_holding_run

.holding_run:
  ; If the player lets go of run and then presses run again, cancel blue
  ; suit
  LDA easy_blue_suit_held_run_last_check
  BNE .was_holding_run

  LDA #$0001
  STA easy_blue_suit_held_run_last_check
  BRA .cancel_blue_suit

.was_holding_run
  LDA easy_blue_suit_counter
  CMP !FULL_ECHOES_SPEED
  BCS .full_run_speed

.accelerating:
  ; TODO - Is there a sound to play for accelerating, or just when we
  ; reach full run speed?

  ADC !ECHOES_ACCELERATION
  STA easy_blue_suit_counter

  CMP !FULL_ECHOES_SPEED
  BCS .just_reached_full_run_speed

  BRA .store_speed_counter

.just_reached_full_run_speed:
  JSR queue_echoes_sound

.full_run_speed
  ; Simulate the oscillator in the least significant byte of the real
  ; speed counter (though I do not think this has any real effect)
  EOR #$0001
  STA easy_blue_suit_counter
  INC

.store_speed_counter:
  STA $0B3E

  BRA .return

.not_holding_run
  LDA #$0000
  STA easy_blue_suit_held_run_last_check

  ; If the counter is too large then we will never reach echoes, so
  ; reset it.  On snes9x, memory is initialized to 5555h, so this will
  ; set it to zero.  On other platforms it could be initialized to some
  ; other value, and as long as it's in the right range it should be
  ; okay.
  ;
  ; TODO - it would be better to explicitly initialize this memory
  ; somewhere, but I don't know how to do that yet.  It's good to have
  ; this check anyway in case of a stray memory write.
  LDA easy_blue_suit_counter
  CMP !MAX_ECHOES_SPEED
  BCS .cancel_blue_suit

  ; If the counter is greater than 400h then we have easy blue suit and
  ; we don't want to clear it.
  CMP #$0400
  BCS .maybe_keep_blue_suit

  BRA .cancel_blue_suit

.maybe_keep_blue_suit:
  ; If Samus no longer has blue suit, then cancel easy blue suit
  LDA $0B3E
  BEQ .cancel_blue_suit

  ; If Samus has iframes then cancel blue suit (this prevents chain
  ; damage).
  LDA $18A8
  BEQ .return

.cancel_blue_suit:
  BRA cancel_blue_suit

.call_cancel_blue_suit_routine:
  BRA call_cancel_blue_suit_routine

.return:
  RTL
}

cancel_blue_suit:
  ; Clear the easy blue suit counter
  LDA #$0000
  STA easy_blue_suit_counter
  
  ; Set $0B3C so blue suit is no longer permanent
  LDA #$0001
  STA $0B3C

  BRA call_cancel_blue_suit_routine
}

call_cancel_blue_suit_routine:
  ; Cancel blue suit if the run button is not pressed and we didn't
  ; acquire blue suit via a "standing run".
  ; (TODO - it's OK to call this routine even if we have blue suit, as
  ; long as $0B3C is zero)
  JSL $91DE53

  LDA $079B
  STA easy_blue_suit_room

  RTL
}

queue_echoes_sound:
{
  PHA

  ; Set samus echoes sound playing flag
  LDA #$0001
  STA $0B40

  ; Queue sound for echoes
  LDA #$0003
  JSL $80914D

  PLA
  RTS
}

set_speed_boost_damage_contact_index:
{
  LDA easy_blue_suit_counter
  AND #$FF00
  CMP !FULL_ECHOES_SPEED
  BEQ .return

  ; Only set damage contact for real blue suit
  LDA #$0001
  STA $0A6E

.return
  RTS
}

%END_FREESPACE(90)
