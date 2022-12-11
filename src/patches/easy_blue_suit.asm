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

easy_blue_suit_end_freemem_7f:

!FREEMEM_7F := easy_blue_suit_end_freemem_7f
;;
; "Cancel speed boosting" hook for Samus standing position
;

org $90A3D0

JSR do_easy_blue_suit_check

org !FREESPACE_90

do_easy_blue_suit_check:
{
  LDA $8B
  BIT $09B6
  BEQ .not_holding_run

.holding_run:
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

  ; Simulate the oscillator in the least significant byte of the real
  ; speed counter (though I do not think this has any real effect)
  EOR #$0001
  STA easy_blue_suit_counter
  INC

.store_speed_counter:
  STA $0B3E

  BRA .return

.not_holding_run
  LDA easy_blue_suit_counter

  ; If the counter is too large then we will never reach echoes, so
  ; reset it.  On snes9x, memory is initialized to 5555h, so this will
  ; set it to zero.  On other platforms it could be initialized to some
  ; other value, and as long as it's in the right range it should be
  ; okay.
  ;
  ; TODO - it would be better to explicitly initialize this memory
  ; somewhere, but I don't know how to do that yet.  It's good to have
  ; this check anyway in case of a stray memory write.
  CMP #$04FF
  BCS .cancel_blue_suit

  CMP #$0400
  BCS .return

.cancel_blue_suit:
  ; Clear the easy blue suit counter
  LDA #$0000
  STA easy_blue_suit_counter
  
  ; TODO - I can't remember why I set this nor whether it has any effect
  LDA #$0000
  STA $0B3C

  ; Cancel blue suit if the run button is not pressed and we didn't
  ; acquire blue suit via a "standing run".
  JSL $91DE53

.return:
  RTS
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
