;;;;;
;
; Easy blue suit - lets players get blue suit by holding the run button
; while standing.
;
; Bugs/Limitations:
; * Since this code is only executed when Samus is in the standing
;   position, it is possible for Samus to lose blue suit while not in
;   the standing position and then quickly reacquire blue suit by
;   pressing and holding the run button prior to standing.
; * Samus can acquire blue suit slightly faster the first time easy blue
;   suit is used if the memory used by this patch gets initialized to a
;   a value between 400h and 4FFh.
; * Samus loses blue suit if holding B and running into a wall (this can
;   be a problem e.g. in frog speedway)
;
;;;;;


;;
; Constants
;

!FULL_ECHOES_SPEED = #$0400
!ECHOES_ACCELERATION = #$0040

;;
; Memory used by this patch
;

org !FREEMEM_7F

; Counter: mimics $0B3E (speed counter)
; Most significant byte is the speed counter (0, 1, 2, 3, or 4)
; Least significant byte oscillates between 1/2 when at full speed
easy_blue_suit_counter:
skip 2

; Room where easy blue suit was acquired
easy_blue_suit_room:
skip 2

easy_blue_suit_held_run_last_check:
skip 2

easy_blue_suit_end_freemem_7f:

!FREEMEM_7F := easy_blue_suit_end_freemem_7f
;;
; "Cancel speed boosting" hook for Samus standing position
;

org $90A3D0

JSL do_easy_blue_suit_check

org !FREESPACE_90

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
  ; TODO - set Samus contact damage index to 1 ($0A6E)?
  ; (I think the answer is no)
  ; PHA
  ; LDA #$0001
  ; STA $0A6E
  ; PLA

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
  CMP #$04FF
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
  ; Clear the easy blue suit counter
  LDA #$0000
  STA easy_blue_suit_counter
  
  ; Set $0B3C so blue suit is no longer permanent
  LDA #$0001
  STA $0B3C

.call_cancel_blue_suit_routine:
  ; Cancel blue suit if the run button is not pressed and we didn't
  ; acquire blue suit via a "standing run".
  ; (TODO - it's OK to call this routine even if we have blue suit, as
  ; long as $0B3C is zero)
  JSL $91DE53

  LDA $079B
  STA easy_blue_suit_room

.return:
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

easy_blue_suit_end_freespace_90:
!FREESPACE_90 := easy_blue_suit_end_freespace_90
