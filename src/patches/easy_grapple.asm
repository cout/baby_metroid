; Make grapple fire a little bit faster
org $9BC61B
LDA #$000F
STA $0D00
STA $0CFE
%assertpc($9BC624)

org $9BC79D
NOP
NOP
JSR test_should_cancel_grapple
BCC grapple_swinging_no_cancel
%assertpc($9BC7A4)

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
