org $A09FC4
JMP $9F7D

org $A09F23
{
  CMP #$800A
  BEQ maybe_attach_grapple
  INY
  INY
}
%assertpc($A09F2A)

org $A09F44
maybe_attach_grapple:
