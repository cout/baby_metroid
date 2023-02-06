; TODO -
;
; Test all grapple glitches in the physics compendium (e.g. remaining
; grappled to an enemy while touching a transition tile).

; TODO -
;
; Samus can still fall through a 1-tile high ledge by: a) jumping and
; grappling b) positioning horizontal to the ledge c) releasing grapple.

; TODO -
; I was able to get stuck in the left wall by grappling mochtroids to
; the right of Samus in coliseum

; --------------------------------------------------

org $9BBF18
JMP pre_grapple_locked_in_place_collision_detection

org !FREESPACE_9B

pre_grapple_locked_in_place_collision_detection:
{
  ; Use post-grapple collision detection since Samus is in a standing
  ; pose rather than a swinging pose
  JSL $90EF22

  ; Update grapple start position
  JSL $9BBF1B

  PLB
  PLP
  RTL
}

end_pre_grapple_collision_detection_freespace_9b:
!FREESPACE_9B := end_pre_grapple_collision_detection_freespace_9b

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

; Zero-out grapple length delta if there is a collision during growing
; or shrinking
org $94AC9B
JMP $ACF2

org $94ACF2
STZ $0D00

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
