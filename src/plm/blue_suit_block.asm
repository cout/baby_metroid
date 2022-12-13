!BLUE_SUIT_BLOCK_BTS = $11

org !FREESPACE_84

blue_suit_plm_instruction_list:
{
  dw $86BC ; delete
}

blue_suit_plm_init:
{
  JSR give_blue_suit

  ; Set the carry flag to indicate a collision (i.e. treat the block as
  ; solid)
  SEC

  RTS
}

; TODO - only give Samus blue suit if speed booster is equipped (TODO -
; I think this may be a problem in Ceres too)
give_blue_suit:
{
  ; Give Samus blue suit
  LDA #$0400
  STA $0B3E

  ; Give Samus "easy" blue suit
  ; TODO: that this is needed at all means the easy blue suit patch
  ; isn't correclty letting the player keep non-easy blue suit
  LDA #$0400
  STA easy_blue_suit_counter
  LDA $079B
  STA easy_blue_suit_room

  RTS
}

blue_suit_plm:
{
  dw blue_suit_plm_init, blue_suit_plm_instruction_list
}

blue_suit_plm_end_freespace_84:
!FREESPACE_84 := blue_suit_plm_end_freespace_84

org $949139+(2*!BLUE_SUIT_BLOCK_BTS) : dw blue_suit_plm ; special air/block collision
org $9491D9+(2*!BLUE_SUIT_BLOCK_BTS) : dw blue_suit_plm ; special air/block collision (replaceable)
