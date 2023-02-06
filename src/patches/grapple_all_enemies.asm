; TODO -
;
; I think this covers most of the cases of clipping through an up-facing
; door.
;
; Sadly, swinging on grapple above a ledge, grapple gets lengthened as
; soon as I swing away from the ledge.  Something needs to set a flag to
; tell grapple to stop lengthening (or only lengthen while I am holding
; down).

; TODO -
;
; Also, when grappling an enemy at floor level, Samus sinks into the
; floor (but gets ejected when she stops grappling).

; TODO -
;
; There may be some other bugs to work around, e.g. remaining grappled
; to an enemy while touching a transition tile.

; --------------------------------------------------

; Fix horizontal/vertical extension post-grapple collsion handling
org $9482E1+(2*$05) : dw $9411
org $9482E1+(2*$0C) : dw $9447
org $948301+(2*$05) : dw $9411
org $948301+(2*$0C) : dw $9447

; --------------------------------------------------

; Change Samus's hitbox size when using grapple
; (this does not have any effect because it is not used when grappling,
; but it seems like the right thing to do since she really is that long
; when grappling)
org $91BBB9+$06 : db $15
org $91BBC1+$06 : db $15

; --------------------------------------------------

!minimum_grapple_length = #$0000

org $94AC4B
BPL $06

org $94AC48
CMP !minimum_grapple_length

org $94AC50
LDA !minimum_grapple_length

; --------------------------------------------------

org $94ABE6 ; number of iterations
LDA #$000D

org $94ABEC ; initial extra test length
LDA #$0004

org $94AC02 ; test length per iteration
ADC #$0004

; --------------------------------------------------

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
