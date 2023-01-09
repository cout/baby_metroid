if !USE_BELOW_LANDING_SITE

org $84B9C1

animals_escape_block_shot_plm_entry:

dw $B978, animals_escape_instruction_list

org !FREESPACE_84

animals_escape_instruction_list:
{
  dw $8C10 : db $0A     ; Queue sound
  dw $0004, $925B       ; Exploding block
  dw $0004, $9265       ; Exploding block
  dw $0004, $926F       ; Exploding block
  dw I_set_animals_escape_door_bts
  dw $0001, D_open_animals_escape_door
  dw $B9B9              ; Set critters escaped event
  dw $86BC              ; Delete
}

D_open_animals_escape_door:
{
  ; dw $8003, $80FF, $80FF, $80FF
  dw        $8003, $00FF, $00FF, $00FF
  dw $0001, $8003, $90FF, $90FF, $90FF
  dw $0000
}

I_set_animals_escape_door_bts:
{
  PHX
  PHY

  LDY $1C27
  LDX $1C87,y
  INX
  LDA #$9001
  JSR $82B4

  TXA
  ADC $07A5
  ADC $07A5
  TAX
  LDA #$9001
  JSR $82B4
  TXA

  ADC $07A5
  ADC $07A5
  TAX
  LDA #$9001
  JSR $82B4

  PLY
  PLX
  RTS
}

end_animals_escape_freespace_84:
!FREESPACE_84 = end_animals_escape_freespace_84

endif
