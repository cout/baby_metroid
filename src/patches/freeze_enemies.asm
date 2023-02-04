!effective_contact_damage_index = $0A70
!effective_invincibility_timer = $1866

;;
; Treat all enemies as solid (but they can still hurt Samus).
;
; AFAICT Samus cannot get hurt by moving into a solid enemy, but she can be
; hurt by a solid enemy that is moving toward her.
;

; hook into where the game engine does frozen checks
org $A0A9DC
JMP check_solid_enemy_detection

; this is the branch that is taken if the enemy is frozen or solid
treat_enemy_as_solid = $A0A9EC

; this is the branch that is taken if the enemy is not frozen or solid
treat_enemy_as_ethereal = $A0AABF

org !FREESPACE_A0

check_solid_enemy_detection:
{
  ; If contact damage index is nonzero then Samus can damage enemies on
  ; contact, so do the normal checks
  LDA $0A6E
  BNE .do_normal_solid_checks

  LDA !hard_mode_flag
  BEQ .easy_mode

.hard_mode:
  LDA $0A6E
  STA !effective_contact_damage_index

  LDA $18A8
  STA !effective_invincibility_timer

  ; In hard mode, treat enemies as solid only when Samus is morphed
  PHX
  LDA $0A1F
  AND #$00FF
  TAX
  LDA.l pose_collision_type_table,x
  PLX
  AND #$00FF
  CMP #$0001
  BNE .do_normal_solid_checks
  BRA .check_samus_moving_upward

.easy_mode:
  LDA #$0001
  STA !effective_contact_damage_index

.check_samus_moving_upward:
  ; If Samus is moving upward, do not treat the enemy as solid (so Samus
  ; can more easily jump up through enemies)
  LDA $0B36
  CMP #$0001
  BEQ .do_normal_solid_checks

.treat_enemy_as_solid:
  ; Always treat the enemy as solid:

  JMP treat_enemy_as_solid

.do_normal_solid_checks:
  ; Treat the enemy as solid only if it is frozen or has the solid flag
  ; set, otherwise treat it as ethereal:

  ; If the enemy frozen timer is nonzero, the enemy is solid
  LDA $0F9E,x
  BNE .treat_enemy_as_solid

  ; If the enemy hitbox is solid to samus, the enemy is solid
  LDA $0F86,x
  BIT #$8000
  BNE .treat_enemy_as_solid

  JMP treat_enemy_as_ethereal
}

end_freeze_enemies_freespace_a0:
!FREESPACE_A0 := end_freeze_enemies_freespace_a0

;;
; Disable Samus/enemy collsion handling in easy mode.  This causes
; enemies to be treated as frozen (so they do not hurt Samus) but does
; not make them solid (you cannot stand on them without the above
; change).
;

; extended spritemap
org $A09A95
LDA !effective_invincibility_timer

; normal spritemap
org $A0A09B
LDA !effective_invincibility_timer

;;
; Disable touch knockback and damage in easy mode
;

org $A0A4A6
JMP handle_touch_damage_and_knockback

org !FREESPACE_A0

handle_touch_damage_and_knockback:
{
  LDA !hard_mode_flag
  BEQ .easy_mode

.hard_mode:
  JMP $A562

.easy_mode:
  RTS
}

end_freeze_enemies_2_freespace_a0:
!FREESPACE_A0 := end_freeze_enemies_2_freespace_a0

;;
; Disable projectile knockback and damage in easy mode
;

org $A098AC
LDA !effective_contact_damage_index

;;
; Disable all damage to Samus in easy mode
;

org $91DF5B
LDA !hard_mode_flag
BEQ skip_deal_damage
NOP
%assertpc($91DF61)
skip_deal_damage = $91DF79

;;
; Do block collision detection when standing on solid/frozen enemies
;
; This fixes what appears to be a bug in the original code: a solid
; enemy can pull Samus through the floor, because block collision
; detection is skipped when there is enemy collision.
;

org $909450
TAX
BEQ move_samus_down_no_enemy_collision
JMP move_samus_down_enemy_collision
warnpc $90945B

move_samus_down_no_enemy_collision = $90945B

org !FREESPACE_90

move_samus_down_enemy_collision:
{
  JSR $E61B
  JSL $949763
  PLP
  RTS
}

end_freeze_enemies_freespace_90:
!FREESPACE_90 := end_freeze_enemies_freespace_90
