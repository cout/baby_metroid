; TODO - use the debug handler at $A5:92AB to control draygon and
; "rescue" samus

org $A586DD : LDA.w #draygon_main

org !FREESPACE_A5

draygon_main:
{
  LDA $7ED828
  AND #$0001
  BNE .return

  JSR $92AB

.return:
  RTS
}

end_draygon_freespace_a5:
!FREESPACE_A5 = end_draygon_freespace_a5
