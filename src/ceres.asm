;;
; Increase required health for ridley to fly away
org $A6A6F4

CMP #$0777

;;
; Replace ceres escape with transporter

org $A6C117 ; ceres escape timer has started

JMP state_start_transport_sequence

org !FREESPACE_A6

state_start_transport_sequence:
{
  LDA.w #transporter_electricity
  TAY
  LDX #$0000
  JSL $868097

  ; TODO:
  ; 1. Play a sound for the transport sequence
  ; 2. Give Samus iframes for effect
  LDA #$0080
  STA $0FB0

  LDA.w #state_transporter_operating
  STA $0FA8 ; next state

  RTS
}

state_transporter_operating:
{
  DEC $0FB0
  BNE .return

  ; Start the cutscene
  LDA #$0020
  STA $0998

.return:
  ; TODO - I don't know what this call is for, just that the routines
  ; that I'm replacing invoke it.
  ; JSR $C19C

  RTS
}

end_ceres_freespace_a6:
!FREESPACE_A6 = end_ceres_freespace_a6

org !FREESPACE_86

transporter_electricity:

dw transporter_electricity_init ; init ai
dw transporter_electricity_main ; pre-instruction
dw $E683                        ; instruction list
dw $00                          ; x radius
dw $00                          ; y radius
dw $3000                        ; properties
dw $0000                        ; hit instruction list
dw $84FC                        ; shot instruction list

transporter_electricity_init:
{
  RTS
}

transporter_electricity_main:
{
  ; Move the electricity with Samus
  LDA $0AF6 : STA $1A4B,x
  LDA $0AFA : STA $1A93,x

  RTS
}

ceres_freespace_86_end:
!FREESPACE_86 := ceres_freespace_86_end
