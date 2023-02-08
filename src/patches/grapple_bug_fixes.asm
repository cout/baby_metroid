; TODO -
;
; Test all grapple glitches in the physics compendium (e.g. remaining
; grappled to an enemy while touching a transition tile).

; TODO -
;
; Samus can still fall through a 1-tile high ledge by: a) jumping and
; grappling b) positioning horizontal to the ledge c) releasing grapple.

; TODO -
; Grappling an enemy that is at floor-level, Samus moves forward or backward a
; few pixels

; --------------------------------------------------

!saved_samus_x_position = $1886
!saved_samus_y_position = $1888

org $91EF4F
JSL update_samus_pose_for_grapple_connected_swinging

org !FREESPACE_9B

update_samus_pose_for_grapple_connected_swinging:
{
  LDA $0AF6 : STA !saved_samus_x_position
  LDA $0AFA : STA !saved_samus_y_position

  JSL $9BBD95 ; Update Samus pose and position for grapple swinging

  ; TODO - grapple angle is set at $9B:C564 -- can we do collision testing
  ; there or is that too early? (because we don't know what pose yet)

  JSL grapple_connected_swinging_pose_change_collision_check
  BCC .no_collision

.cancel:
  LDA !saved_samus_x_position : STA $0AF6
  LDA !saved_samus_y_position : STA $0AFA
  LDA #$C8C5 : STA $0D32

.no_collision:
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
  LDA $0AF6 : STA !saved_samus_x_position
  LDA $0AFA : STA !saved_samus_y_position

  JSL $9BBEEB

  ; Use post-grapple collision detection since Samus is in a standing
  ; pose rather than a swinging pose
  JSL $90EF22

  ; Update grapple start position
  JSL $9BBF1B

  JSL $9484C4 : LDA $0E04 : ORA $0E06 : BNE .cancel_grapple
  JSL $9484CD : LDA $0E04 : ORA $0E06 : BNE .cancel_grapple
  BRA .return

.cancel_grapple:
  LDA !saved_samus_x_position : STA $0AF6
  LDA !saved_samus_y_position : STA $0AFA
  LDA #$C8C5 : STA $0D32

.return:
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

; TODO - This prevents entering a wallgrab pose if I set it below 8

!minimum_grapple_length = #$0008
!minimum_grapple_length_for_wallgrab_pose = #$0008

org $94AC4B
BPL $06

org $94AC48
CMP !minimum_grapple_length

org $94AC50
LDA !minimum_grapple_length

org $94ADD5
CMP !minimum_grapple_length_for_wallgrab_pose
BPL $0F

org $94AEA5
CMP !minimum_grapple_length_for_wallgrab_pose
BPL $0F

; --------------------------------------------------

; Zero-out grapple length delta if there is a collision during growing
; or shrinking
org $94AC9B
JMP $ACF2

org $94ACF2
STZ $0D00

; --------------------------------------------------

!grapple_collision_test_iterations = #$000D
!grapple_collision_test_initial_length = #$0008
!grapple_collision_test_length_increment = #$0004

org $94ABE6
LDA !grapple_collision_test_iterations

org $94ABEC
LDA !grapple_collision_test_initial_length

org $94AC02
ADC !grapple_collision_test_length_increment

org $94ADC8
CMP !grapple_collision_test_iterations

org $94ADCD
CMP !grapple_collision_test_iterations-1

org $94AE98
CMP !grapple_collision_test_iterations

org $94AE9D
CMP !grapple_collision_test_iterations-1
