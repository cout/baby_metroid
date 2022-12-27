; TODO: Chewing sound during death?
; TODO: Remove hitbox for kraid arm
; TODO: Fix hitbox for kraid mouth/body (make it smaller)
; TODO: Sound effect for "eating" missiles
; TODO: Shorter earthquake during rise/sink

;;
; Disable Kraid spitting rocks
;

org $A7BC14 ; jsr for spawn rock projectile

BRA .earthquake_sound

org $A7BC1B

.earthquake_sound:

;;
; Disable lunging
;

org $A786F3 ; walk forward

dw $B633, $812F

org $A787BD ; lunge forward

dw $B633, $812F

org $A78887 ; walk backward

dw $B633, $812F

;;
; Play elevator music instead of boss music
;

org $A7C8AF

LDA #$0003

;;
; Clear the spikes and unfix the camera
;

org $A7A9E7

JSR $C171

;;
; Replace Kraid roar with a less intimidating sound
;

org $A7AF95

LDA #$0060

;;
; Disable Kraid standup
;

org $A7C00C

RTS

;;
; Fix camera after kqk
;

org $A7C456

JMP $C0AE ; release camera (horizontal only) and return

;;
; Turn off death cry
;

org $A7AF9F

JMP $AF88

;;
; Make Kraid sink slower
;

org $A7C540

JSR kraid_sink

org $A7BCB5

kraid_sink:
{
  LDA $0F80
  CLC
  ADC #$8000
  STA $0F80
  LDA $0F7E
  ADC #$0000
  STA $0F7E
  RTS
}

warnpc $A7BCCF

;;
; Chew during death sequence
;

org $A7C398

LDA.w #kraid_death_sequence
STA $0FAA
LDA kraid_death_timer
STA $0FAC

org $A7B269

kraid_death_timer:
dw $0012, $97C8, $9788, $FFFF ; 0

kraid_death_sequence:
;                vuln.  invul.
;  timer tilemap hitbox hitbox
dw $0012, $9AC8, $9790, $97B0 ; 1
dw $0012, $9DC8, $9798, $97B8 ; 2
dw $0012, $9AC8, $9790, $97B0 ; 1
dw $0012, $97C8, $9788, $FFFF ; 0
dw $0001, $9AC8, $9790, $97B0 ; 1
dw $0012, $9DC8, $9798, $97B8 ; 2
dw $0012, $A0C8, $97A0, $97C0 ; 3
dw $0012, $9DC8, $9798, $97B8 ; 2
dw $0012, $9AC8, $9790, $97B0 ; 1
dw $0012, $9DC8, $9798, $97B8 ; 2
dw $0012, $9AC8, $9790, $97B0 ; 1
dw $0012, $97C8, $9788, $FFFF ; 0
dw $FFFF
