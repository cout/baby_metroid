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

  ; Queue save sound (library 1, sound 9h)
  LDA #$0009
  JSL $809049

  ; TODO: give Samus iframes for effect
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
