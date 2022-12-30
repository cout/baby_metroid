;;
; Disable croc fireball
;

org $A48797
JMP $87A5

;;
; Keep croc on screen after falling into water/acid
;

org $A491D4
{
  ; Keep sinking croc until he reaches the bottom of the bath
  LDA $0F7E,x
  CMP #$0AB
  BMI sink_crocomire

  ; Clear invisible wall and unlock camera
  JSR $90B7

  ; ; Next state is 3Eh
  LDA #$003E
  STA $0FA8,x

  RTS
}

warnpc $A491E9

sink_crocomire = $A491E9

;;
; Keep Croc positioned correctly after bath
;

org $A497D3 ; state 3Eh

crocomire_state_wait_for_samus_to_visit_spike_wall:
{
  REP #$20

  JSR crocomire_bath

  LDA $0AF6
  CMP #$0280
  BPL .return
  BRA .next_state

.next_state:
  LDA $0F86              ;\
  AND #$7FFF             ;} Set Crocomire to have non-solid hitbox and
  ORA #$0400             ;} set Crocomire as intangible
  STA $0F86              ;/

  ; LDA $0FC6              ;\
  ; ORA #$0500             ;} Set Crocomire (legs? tongue?) as intangible and invisible - TODO
  ; STA $0FC6              ;/

  ; Prevent croc from stomping backward out of the bath
  LDA #$0004
  STA $0FAE
  STZ $0FEE
  LDA #$000A
  STA $102E
  LDA #$0001
  STA $106E
  STZ $0FAA
  LDA #$0038

  STA $0F84              ;} Set Crocomire collision height to 56

  LDA #$0042
  STA $0FA8

.return:
  RTS
}

;;; $990A: Crocomire state function 42h - Start spike wall falling ;;;

org $A4990A ; state 42h

crocomire_state_start_spike_wall_falling:
{
  STZ $0FB0            
  STZ $0FB2            

  JSL $8483D7            ;\
  dw $0320, $B753          ;} Spawn PLM - clear Crocomire invisible wall

  LDA #$0029             ;\
  JSL $8090CB            ;} Queue sound 29h, sound library 2, max queued sounds allowed = 6 (Crocomire's wall explodes)
  LDA #$0000             ;\
  STA $0F96              ;} Crocomire palette = 0

  LDX #$001E
.loop:
  LDA $B8FD,x            ;\
  STA $7EC120,x          ;|
  DEX                    ;} Copy $B8FD to enemy palette 0
  DEX                    ;|
  BPL .loop              ;/

  JSL $868016            ; Clear enemy projectiles

  LDA #$0008
  STA $12              
.loop2:
  LDX $0E54            
  LDY #$90C1             ;\
  JSL $868027            ;} Spawn Crocomire spike wall pieces enemy projectile
  DEC $12              
  BNE .loop2

  LDA #$0030             ;\
  JSL $8090CB            ;} Queue sound 30h, sound library 2, max queued sounds allowed = 6 (Crocomire destroys wall)

  ; Clear scroll lock
  LDA #$0101
  STA $7ECD20
  STA $7ECD22

  LDA #$0046
  STA $0FA8
  RTS
}
warnpc $A499CB

org $A49A38 ; state 46h
{
  JSR crocomire_bath

  ; TODO - this is supposed to function as a delay (I think), but since
  ; we are missing state 44h, the delay is too short.

  LDA $0FB0
  CLC
  ADC #$0800
  STA $0FB0

  LDA $0FB2
  ADC #$0000
  CMP #$0005
  BMI .label1
  LDA #$0005

.label1:
  STA $0FB2

  LDA #$0025             ;\
  JSL $8090CB            ;} Queue sound 25h, sound library 2, max queued sounds allowed = 6 (big explosion)

  LDA $0F96              ;\
  STA $0FD6              ;} Enemy 1 palette index = [Crocomire palette index]

  ; Restore croc palette
  LDA #$0E00
  STA $0F96

  ; Restore movement to Croc legs/arms
  LDA #$BADE
  STA $0F92
  LDA #$0001
  STA $0F94

  JMP $9B06

.return:
  RTS
}

org $A49B06 ; state 48h
{
  JSR crocomire_bath

  JSL $A0B9D8            ; Spawn drops

  STZ $0941              ; Camera distance index = 0 (normal)

  LDX $079F              ;\
  LDA $7ED828,x          ;} Set Crocomire as dead
  ORA #$0002             ;|
  STA $7ED828,x          ;/

  LDA #$FFF0
  JSL $A49ADA
  LDA #$0010
  JSL $A49ADA

  LDA #$0050
  STA $0FA8
  RTS
}
warnpc $A49B65

org $A49B86 ; state 50h
{
  JSR crocomire_bath

  RTS
}

advance_to_next_state_and_return = $A49BB3

;;
; Crocomire bath play routine
;

org $A49099 ; state 3Ch (now unused)

crocomire_bath:
{
  ; TODO - Croc's tongue is gone

  ; TODO - there is a slight delay in adjusting croc after Samus moves

  ; Create smoke from acid bath
  JSR $916C

  ; Keep the body positioned
  LDX $0E54
  JSL $A48B5B

  RTS
}
