org $9BC79D
NOP
NOP
JSR test_should_cancel_grapple
BCC grapple_swinging_no_cancel

grapple_swinging_no_cancel = $9BC7C8

%BEGIN_FREESPACE(9B)

test_should_cancel_grapple:
{
  ; If newly pressing fire then cancel
  LDA $8F
  BIT $09B2
  BNE .cancel

  ; If newly pressing jump then cancel
  BIT $09B4
  BNE .cancel

.no_cancel:
  CLC
  RTS

.cancel:
  SEC
  RTS
}

%END_FREESPACE(9B)
