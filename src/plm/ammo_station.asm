; activate missile station
org $848CD5
JSR test_ammo_full
org $848CE4
JSR refill_ammo

; instruction - enable movement if health is full
org $84AEC2
JSR test_ammo_full

; missile station right access
org $84B2EB
JSR test_ammo_full

; missile station left access
org $84B31E
JSR test_ammo_full

org !FREESPACE_84

refill_ammo:
{
  LDA $09C8 : STA $09C6 ; missiles
  LDA $09CC : STA $09CA ; super missiles
  LDA $09D0 : STA $09CE ; power bombs
  RTS
}

test_ammo_full:
{
  LDA $09C8 : CMP $09C6 : BNE .not_full
  LDA $09CC : CMP $09CA : BNE .not_full
  LDA $09D0 : CMP $09CE : BNE .not_full

.full:
  LDA #$0000
  RTS

.not_full:
  LDA #$FFFF
  RTS
}

end_ammo_station_freespace_84:
!FREESPACE_84 := end_ammo_station_freespace_84
