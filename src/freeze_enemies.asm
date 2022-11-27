;;;;;
;
; Overview:
;
; (*) indicates this is one of the instructions that we hook
;
; 9FD4 - Main enemy routine
;   |
;   +-(*)- 903C - checks whether an enemy is frozen
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
; A07A - enemy / samus collsion detection (called from 977E above)
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
org $A0A9DF
BRA solid_enemy_collision_detection

org $A0A9EC
solid_enemy_collision_detection:

;;
; Treat collision with all enemies as if they are frozen (so they do not
; hurt Samus).  This does not make them solid (so you cannot stand on
; them without the above change)
;
; AFAICT this routine controls whether enemies can hurt Samus by moving toward
; her, though (untested) Samus may be able to be hurt by moving toward an
; enemy that is frozen using this hook.
;
; TODO - this does not work with enemy_drops.asm, as it disables collsion
; detection between enemies and projectiles.
;

; org $A0903C
org $A09049
BRA frozen_enemy_collision_handling

org $A0904C
frozen_enemy_collision_handling:

;;
; Disable Samus/enemy collsion handling.  This has the same effect as the
; above patch - Samus can still get hurt from standing on an enemy that is
; climing up a wall.

org $A0A07A
RTS

org $A09B7F
RTS

;;
; Disable touch AI - this should disable knockback and damage.
;
; TODO - I dont't think this works, because it's still possible to dboost, yet
; I don't see any other routine that sets knockback ($0A54) so... ?

org $A0A4A1 ; common touch AI subroutine
RTS

;;
; Disable damage to Samus
;
; TODO - this does not work either.  Clearly there is some other mechanism
; that causes damage to Samus.  It could be:
;   - the enemes I'm testing against (zeela) don't use the normal touch AI
;   - there is some other memory location other than $09C2 that stores Samus
;     health

org $91DF51 ; subroutine called by touch AI and projectile collsion handler to deal damage
RTL

org $91DF71 ; instruction within deal damage subroutine that decrements Samus's health
RTL

;;
; Disable projectile collsion
org $A09785
RTL

;; TODO TODO TODO
;
; - try the pirates changes again!  They might work now.
; - get rid of above routines that are superfluous.
; - test if frozen enemy collsion handling is the same as just disabling
;   either the enemy collision handler or touch AI
