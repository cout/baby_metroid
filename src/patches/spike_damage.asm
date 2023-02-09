!spike_damage = $0B08
!air_spike_damage = $0B0C

org $948EB2 : ADC !spike_damage     : %assertpc($948EB5) ; Generic spike
org $948EED : ADC !air_spike_damage : %assertpc($948EF0) ; Kraid spike
org $948F28 : ADC !air_spike_damage : %assertpc($948F2B) ; Draygon turret
org $949889 : ADC !air_spike_damage : %assertpc($94988C) ; Air spike (BTS=2)

org $90E6BC
JSL inside_block_detection

%BEGIN_FREESPACE(94)

; TODO - it would be better to set these when the game starts instead of
; every frame, but then all my save states would have the wrong spike
; damage values
inside_block_detection:
{
  LDA !hard_mode_flag
  BEQ .easy_mode

.hard_mode:
  LDA #$003C : STA !spike_damage
  LDA #$0010 : STA !air_spike_damage
  JMP $9B60

.easy_mode:
  LDA #$0001 : STA !spike_damage
  LDA #$0001 : STA !air_spike_damage
  JMP $9B60
}

%END_FREESPACE(94)
