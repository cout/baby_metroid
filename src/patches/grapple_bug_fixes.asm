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

; TODO -
; Grappling an enemy that is at floor-level, Samus moves forward or backward a
; few pixels

; --------------------------------------------------

org $91EF4F
JSL update_samus_pose_for_grapple_connected_swinging

org !FREESPACE_9B

update_samus_pose_for_grapple_connected_swinging:
{
  LDA $0AF6 : PHA
  LDA $0AFA : PHA

  JSL $9BBD95 ; Update Samus pose and position for grapple swinging

  ; TODO - grapple angle is set at $9B:C564 -- can we do collision testing
  ; there or is that too early? (because we don't know what pose yet)

  JSL grapple_connected_swinging_pose_change_collision_check
  BCC .no_collision

.cancel:
  PLA : STA $0AFA
  PLA : STA $0AF6
  LDA #$C8C5 : STA $0D32
  RTL

.no_collision:
  PLA
  PLA
  RTL
}

end_update_samus_pose_for_grapple_connected_swinging_freespace_9B:
!FREESPACE_9B := end_update_samus_pose_for_grapple_connected_swinging_freespace_9B

org !FREESPACE_94

grapple_connected_swinging_pose_change_collision_check:
{
  JSR $ABE6 ; Grapple swinging collision detection
  RTL
}

end_update_samus_pose_for_grapple_connected_swinging_freespace_94:
!FREESPACE_94 := end_update_samus_pose_for_grapple_connected_swinging_freespace_94

; --------------------------------------------------

org $91EFBC
JSL pre_grapple_locked_in_place_collision_detection

org !FREESPACE_9B

pre_grapple_locked_in_place_collision_detection:
{
  JSL $9BBEEB

  ; Use post-grapple collision detection since Samus is in a standing
  ; pose rather than a swinging pose
  JSL $90EF22

  ; Update grapple start position
  JSL $9BBF1B

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