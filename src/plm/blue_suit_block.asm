!BLUE_SUIT_BLOCK_BTS = $11

%BEGIN_FREESPACE(84)

blue_suit_plm_instruction_list:
{
  dw $86BC ; delete
}

blue_suit_plm_init:
{
  ; If speed booster is not equipped then follow the normal code path
  LDA $09A2
  BIT #$2000
  BEQ .set_block_as_solid_and_return

  JSR give_blue_suit

.set_block_as_solid_and_return:
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
  ; isn't correctly letting the player keep non-easy blue suit.  But
  ; this is what we want to do anyway, to prevent this blue suit from
  ; being carried to another room.
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

%END_FREESPACE(84)

org $949139+(2*!BLUE_SUIT_BLOCK_BTS) : dw blue_suit_plm ; special air/block collision
org $9491D9+(2*!BLUE_SUIT_BLOCK_BTS) : dw blue_suit_plm ; special air/block collision (replaceable)
