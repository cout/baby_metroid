org $848CE1
JSR ammo_refill
BRA ammo_refill_unlock_samus
warnpc $848CE7
ammo_refill_unlock_samus = $848CE7

org !FREESPACE_84

ammo_refill:
{
  LDA $09C8 : STA $09C6 ; refill missiles
  LDA $09CC : STA $09CA ; refill super missiles
  LDA $09D0 : STA $09CE ; refill super missiles

  RTS
}

end_ammo_station_freespace_84:
!FREESPACE_84 := end_ammo_station_freespace_84
