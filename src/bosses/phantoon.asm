;;
; Unused phantoon state functions
;

;;
; Play elevator music instead of boss music
;

org $A7D542

LDA #$0003

;;
; Skip spinning fireballs
;

org $A7CE7E

; This is the instruction that sets initial state in init ai (so we skip
; D4A9 and D4EE).  After that, the call sequence is:
;
; D508 (pause while fireballs spin, then make phantoon transparent) ->
; D54A (wavy fade-in) ->
; D596 (pick pattern for round one)
;
; and we replace D596 without our own custom state.
;
LDA.w #phantoon_state_initial

;;
; Keep phantoon invisible if already defeated
;

org $A7D51E
JSR phantoon_pick_initial_fade_state

;;
; Make phantoon docile
;

phantoon_eye_spritemap_eye_opening1 = $A7DF05
phantoon_eye_spritemap_eye_opening2 = $A7DF0F
phantoon_eye_spritemap_eye_open = $A7DF19
phantoon_eyeball_spritemap_eye_open = $A7DF23

org $A7CC53

phantoon_instruction_list_open_eye:
{
  dw $000A, phantoon_eye_spritemap_eye_opening1
  dw $000A, phantoon_eye_spritemap_eye_opening2
  dw $808A, begin_tracking_samus_with_eye
  dw $812F ; sleep
}

org $A7CC9D

phantoon_eye_instruction_list_open_eye:
  dw $0001, phantoon_eyeball_spritemap_eye_open
  dw $812F ; sleep
}

org $A7D03F

begin_tracking_samus_with_eye:
{
  ; Clear swooping flag (unneeded, but just in case)
  STZ $1028

  ; Make phantoon tangible (no longer ignores Samus/projectiles)
  ; TODO - this also makes phantoon's forehead solid so Samus can stand
  ; on it
  LDA $0F86
  AND #$FBFF
  STA $0F86

  ; Set phantoon's hitbox as non-empty
  LDA #$0001
  STA $0F94
  ; LDA #$CC47 ; make body vulnerable
  LDA #$CC4D ; make eye vulnerable 
  STA $0F92

  ; This has no effect here, but it is what the original did
  LDA #$0001
  STA $0FD4
  LDA.w #phantoon_eye_instruction_list_open_eye
  STA $0FD2

  ; Set next state
  LDA.w #phantoon_state_track_samus
  STA $0FB2

  RTS
}

phantoon_pick_initial_fade_state:
{
  ; If phantoon is already defeated (i.e. the lights are on), then keep
  ; phantoon invisible
  PHX
  LDX $079F
  LDA $7ED828,x
  PLX
  AND #$0001
  BEQ .lights_on

.lights_off:
  LDA.w #phantoon_state_begin_eye_open
  STA $0FB2,x
  RTS

.lights_on:
  LDA.w #phantoon_state_wait_for_lights_out
  STA $0FB2,x
  RTS
}

phantoon_state_initial:
{
  ; Make the door blue
  JSL $8483D7
  db $00, $06
  dw $B78B

  ; Initial state for vanilla phantoon fight
  LDA #$D508
  STA $0FB2,x

  RTS
}

warnpc $A7D0F1

org $A7D596 ; pick pattern for phantoon round one

phantoon_state_begin_eye_open:
{
  LDA #$0001
  STA $0FD4
  LDA.w #phantoon_instruction_list_open_eye
  STA $0FD2

  LDA.w #phantoon_state_sleep
  STA $0FB2,x

  RTS
}

phantoon_state_sleep:
{
  RTS
}

phantoon_state_track_samus:
{
  ; Update Phantoon's eye sprite
  JSR $D3FA

  ; Check boss flag
  PHX
  LDX $079F
  LDA $7ED828,x
  PLX
  AND #$0001
  BEQ .return

  JSR phantoon_begin_fade_out

.return:
  RTS
}

phantoon_state_wait_for_lights_out:
{
  ; Check boss flag
  PHX
  LDX $079F
  LDA $7ED828,x
  PLX
  AND #$0001
  BNE .return

  ; TODO - when fading back in, phantoon shows up initially as black rather
  ; than fading in gradually
  JSR phantoon_begin_fade_back_in

.return:
   RTS
 }

phantoon_state_fade_in = $A7D54A

phantoon_begin_fade_out:
{
  STZ $0FF2 ; clear fade out flag

  LDA.w #phantoon_state_fade_out
  STA $0FB2,x
  LDA #$0020
  STA $0FB0,x

  RTS
}

warnpc $A7D60D

org $A7D114

phantoon_state_fade_out:
{
  ; Fade out
  LDA #$000C
  JSR $D464

  ; If not done fading out, return
  LDA $0FF2
  BEQ .return

  ; After fading out, wait for the timer to elapse before fading in
  DEC $0FB0,x
  BPL .return

.next_state:
  ; Check the boss flag
  PHX
  LDX $079F
  LDA $7ED828,x
  PLX
  AND #$0001
  BEQ .fade_back_in

.stay_hidden:
  LDA.w #phantoon_state_wait_for_lights_out
  STA $0FB2,x
  RTS

.fade_back_in:
  JSR phantoon_begin_fade_back_in

.return:
  RTS
}

phantoon_begin_fade_back_in:
{
  STZ $0FF2
  STZ $0FB6 ; clear phantoon invisibility flag?
  STZ $1070
  LDA.w #phantoon_state_fade_back_in
  STA $0FB2,x
  LDA #$0040
  STA $0FB0,x
  RTS
}

phantoon_state_fade_back_in:
{
  LDA #$0012
  JSR $D486 ; fade-in

  LDA $CD9B : STA $12
  LDA $CD9D : STA $14
  JSR $CF27 ; wavy pattern
  BCS .next_state

  DEC $0FB0,x
  BEQ .timer_is_up
  BPL .return

.timer_is_up:
  LDA #$0001
  STA $1070
  BRA .return

.next_state:
  LDA $0FF2
  BEQ .return

  LDA.w #phantoon_state_begin_eye_open
  STA $0FB2,x
  LDA #$0001
  STA $1074
  LDA #$001E
  STA $0FB0,x

.return
  RTS
}

warnpc $A7D193

;;
; Make phantoon ethereal
;
; (TODO - this has no effect)
;

org $A7DD95

phantoon_touch_ai:
{
  RTL
}

;;
; Make phantoon disappear when shot
; 

org $A7DD9B

phantoon_shot_ai:
{
  LDX $0E54
  JSR phantoon_begin_fade_out
  RTL
}

;;
; Update BG2 X/Y scroll when the screen scrolls
;

org $A7CECD
JMP $CED2

;;
; Print phantoon states during assembly
;

print "Phantoon states:"
print "  initial - ", hex(phantoon_state_initial&$FFFF)
print "  begin eye open - ", hex(phantoon_state_begin_eye_open&$FFFF)
print "  sleep - ", hex(phantoon_state_sleep&$FFFF)
print "  track samus - ", hex(phantoon_state_track_samus&$FFFF)
print "  wait for lights out - ", hex(phantoon_state_wait_for_lights_out&$FFFF)
print "  fade out - ", hex(phantoon_state_fade_out&$FFFF)
print "  fade in - ", hex(phantoon_state_fade_in&$FFFF)
print "  fade back in - ", hex(phantoon_state_fade_back_in&$FFFF)
