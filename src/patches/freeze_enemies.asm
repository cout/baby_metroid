;;;;;
;
; Overview:
;
; (*) indicates this is one of the instructions that we hook
;
; 9FD4 - Main enemy routine
;   |
;   +----- 903C - checks whether an enemy is frozen
;     |
;     +----- 903E - handle not-frozen enemies
;     |      |
;     |      +----- JSR 9758 - check for enemy collsion (below)
;     |      +----- 904C - enemy was killed from collsion
;     |      +----- 9118 - enemy was not killed from collsion
;     |
;     +---- 904C - handle frozen enemies
;
; 9758 - Enemy collision handler (called from 903E above)
;  |
;  +----- 976A - check whether enemy uses extended spritemaps
;    |
;    +----- 976C - enemy does use extended spritemaps
;    |      |
;    |      +----- 976C - JSR 9B7F - call enemy/projectile handler
;    |      +----- 976F - JSR 9D23 - call enemy/bomb handler
;    |      +----- 9772 - JSR 9A5A - call enemy/samus handler
;    |
;    +----- 9778 - enemy does not use extended spritemaps
;           |
;           +----- 9778 - JSR A143 - call enemy/projectile handler
;           +----- 977B - JSR A236 - call enemy/bomb handler
;           +----- 977E - JSR A07A - call enemy/samus handler
;
; (*) A07A - enemy / samus collsion detection (called from 977E above)
;  |
;  +----- A210 - JSL to A226 (execute enemy shot)
;          |
;          +-(*)- A226 - execute enemy shot
;
; A8F0 - Samus / solid enemy collision detection (called from routines in bank
;  |     $80 that move Samus)
;  |
;  +-(*)- A9DF - check for collsion with frozen enemy
;  
;;;;;



;;
; Treat all enemies as solid (but they can still hurt Samus).
;
; AFAICT Samus cannot get hurt by moving into a solid enemy, but she can be
; hurt by a solid enemy that is moving toward her.
;
org $A0A9DC
; BRA treat_enemy_as_solid
JMP check_solid_enemy_detection

org $A0A9EC
treat_enemy_as_solid:

org $A0AABF
treat_enemy_as_ethereal:

org !FREESPACE_A0

check_solid_enemy_detection:
{
  ; If shine sparking then we want to do the normal checks
  LDA $0A1F
  AND #$00FF
  CMP #$001B
  BNE .treat_enemy_as_solid

  ; If the enemy frozen timer is nonzero, the enemy is solid
  LDA $0F9E,x
  BNE .treat_enemy_as_solid

  ; If the enemy hitbox is solid to samus, the enemy is solid
  LDA $0F86,x
  BIT #$8000
  BNE .treat_enemy_as_solid

  JMP treat_enemy_as_ethereal

.treat_enemy_as_solid:
  JMP treat_enemy_as_solid
}

end_freeze_enemies_freespace_a0:
!FREESPACE_A0 := end_freeze_enemies_freespace_a0

;;
; Disable Samus/enemy collsion handling.  This causes enemies to be
; treated as frozen (so they do not hurt Samus) but does not make them
; solid (you cannot stand on them without the above change).

org $A09A5A
RTS

org $A0A07A
RTS

;;
; Disable touch AI - disables knockback and damage.

org $A0A4A1 ; common touch AI subroutine
RTS

;;
; Disable projectile knockback and damage

org $A0994B
STZ $18AA
RTS

;;
; Disable damage to Samus

org $91DF51 ; subroutine called by touch AI and projectile collsion handler to deal damage
RTL

org $91DF71 ; instruction within deal damage subroutine that decrements Samus's health
RTL
