;;;;;
;
; Allow Samus to "ride" enemies as if they are trippers/kamers.
;
; Bugs/Limitations:
; * Samus cannot jump above a geemer going up a slope if her feet are
;   touching the geemer
; * If Samus is touching an enemy while in morph, she can fall slightly
;   behind the enemy at slope changes
; * If Samus falls onto a geemer, she sometimes fails to change to a
;   standing pose
;
;;;;;

;;
; Hook routine to move enemies horizontally to move Samus with them

org $A0C6AD

move_enemy_horiz:
{
  BRL move_samus_horiz_with_enemy
}

do_move_enemy_horiz = $A0C6B5


;;
; Hook routine to move enemies vertically to move Samus with them

org $A0C788

move_enemy_vert:
{
  BRL move_samus_vert_with_enemy
}

do_move_enemy_vert = $A0C790

;;
; Hook Geemer Main AI
;

org $A3E6C2
BRL move_samus_with_geemer_main_ai

org !FREESPACE_A0

move_samus_horiz_with_enemy:
{
  LDA $12
  ORA $14
  BNE .nonzero_movement
  CLC
  RTL

.nonzero_movement:

  ; if enemy is intangible then do not move Samus
  LDA $0F86,x
  AND #$8000
  BNE .no_collision

  ; if not standing on enemy then we just move the enemy and not Samus
  JSL ride_enemies_check_collision
  BNE .collision

.no_collision
  BRL do_move_enemy_horiz

.collision

  LDA $0F7C,x : PHA  ; Push [enemy X sub-pixel pos]
  LDA $0F7A,x : PHA  ; Push [enemy X pos]
  LDA $0B58   : PHA  ; Push [Samus X displacement]

  JSL do_move_enemy_horiz

  PLA : STA $16      ; $16 = [previous Samus X displacement]
  PLA : STA $18      ; $18 = [previous enemy X pos]
  PLA : STA $20      ; $20 = [previous enemy X sub-pixel pos]

  PHP

  ; If Samus X changed, then don't move Samus on the X axis
  ; (this is to avoid moving Samus twice on trippers and kamers)
  LDA $0B58
  CMP $16
  BNE .return

  ; [$18].[$20] = change in enemy X pos/sub-pixel pos
  LDA $0F7C,x
  SEC
  SBC $20
  STA $20
  LDA $0F7A,x
  SBC $18
  STA $18

  ; Extra Samus X displacement += change in enemy X pos/sub-pixel pos
  LDA $0B56
  CLC
  ADC $20
  STA $0B56
  LDA $0B58
  ADC $18
  STA $0B58

  ; If Samus is not morphed, we are done
  PHX
  LDA $0A1F
  AND #$00FF
  TAX
  LDA.l pose_collision_type_table,x
  PLX
  AND #$00FF
  CMP #$0001
  BNE .return

  ; If Samus is morphed and below the enemy, then move her up one pixel
  ; to lift her off the ground.  This lets Samus ride the zeelas across
  ; the crumble blocks in noob bridge.
  ; TODO - if we lift samus to just below the top of the enemy, then it
  ; looks as if the enemy has "picked up" samus
  LDA $0AFA
  CLC
  ADC $0B5C
  CMP $0F7E,x
  BMI .return
  DEC $0AFA

.return:

  PLP
  RTL
}

move_samus_vert_with_enemy:
{
  LDA $12
  ORA $14
  BNE .nonzero_movement
  CLC
  RTL

.nonzero_movement:

  ; if enemy is intangible then do not move Samus
  LDA $0F86,x
  AND #$8000
  BNE .no_collision

  ; if not standing on enemy then we just move the enemy and not Samus
  JSL ride_enemies_check_collision
  BNE .collision

.no_collision:
  BRL do_move_enemy_vert

.collision:

  LDA $0F80,x : PHA ; Push [enemy Y sub-pixel pos]
  LDA $0F7E,x : PHA ; Push [enemy Y pos]
  LDA $0B5C   : PHA ; Push [Samus Y displacement]

  JSL do_move_enemy_vert

  PLA : STA $16 ; $16 = [previous Samus Y displacement]
  PLA : STA $18 ; $18 = [previous enemy Y pos]
  PLA : STA $20 ; $20 = [previous enemy Y sub-pixel pos]

  PHP

  ; If Samus Y changed, then don't move Samus on the Y axis
  ; (this is to avoid moving Samus twice on trippers and kamers)
  LDA $0B5C
  CMP $16
  BNE .return

  ; [$18].[$20] = change in enemy Y pos/sub-pixel pos
  LDA $0F80,x
  SEC
  SBC $20
  STA $20
  LDA $0F7E,x
  SBC $18
  STA $18

  ; Extra Samus Y displacement += change in enemy Y pos/sub-pixel pos
  LDA $0B5A
  CLC
  ADC $20
  STA $0B5A
  LDA $0B5C
  ADC $18
  STA $0B5C

  ; Zero-out Samus's fall speed
  LDA $0B2C
  BMI +
  STZ $0B2C
+
  LDA $02BE
  BMI +
  STZ $0B2E
+

  ; If Samus is not morphed, we are done
  PHX
  LDA $0A1F
  AND #$00FF
  TAX
  LDA.l pose_collision_type_table,x
  PLX
  AND #$00FF
  CMP #$0001
  BNE .return

  ; If Samus is morphed and below the enemy, then move her up one pixel
  ; to lift her off the ground.  This lets Samus ride the zeelas across
  ; the crumble blocks in noob bridge.
  ; TODO - if we lift samus to just below the top of the enemy, then it
  ; looks as if the enemy has "picked up" samus
  LDA $0AFA
  CLC
  ADC $0B5C
  CMP $0F7E,x
  BMI .return
  DEC $0AFA

.return:

  PLP
  RTL
}

ride_enemies_check_collision:
{
  PHX

.select_collision_type_from_enemy_type:
  ; Mochtroids can pick Samus up
  LDA $0F78,x
  CMP #$D8FF
  BNE +
  LDA #$0001
  BRA .select_collision_routine
+

.select_collision_type_from_pose:
  LDA $0A1F
  AND #$00FF
  TAX
  LDA.l pose_collision_type_table,x
  AND #$00FF

.select_collision_routine:
  ASL
  TAX
  LDA.l pose_collision_routine_table,x

  PLX

  STA $2E
  JMP ($002E)
}

pose_collision_type_table:
{
  db $02 ; 0: Standing
  db $02 ; 1: Running
  db $00 ; 2: Normal jumping
  db $00 ; 3: Spin jumping
  db $01 ; 4: Morph ball - on ground
  db $02 ; 5: Crouching
  db $00 ; 6: Falling
  db $00 ; 7: Unused
  db $01 ; 8: Morph ball - falling
  db $00 ; 9: Unused
  db $00 ; Ah: Knockback / crystal flash ending
  db $00 ; Bh: Unused
  db $00 ; Ch: Unused
  db $00 ; Dh: Unused
  db $02 ; Eh: Turning around - on ground
  db $02 ; Fh: Crouching/standing/morphing/unmorphing transition
  db $00 ; 10h: Moonwalking
  db $01 ; 11h: Spring ball - on ground
  db $01 ; 12h: Spring ball - in air
  db $01 ; 13h: Spring ball - falling
  db $00 ; 14h: Wall jumping
  db $02 ; 15h: Ran into a wall
  db $00 ; 16h: Grappling
  db $00 ; 17h: Turning around - jumping
  db $00 ; 18h: Turning around - falling
  db $00 ; 19h: Damage boost
  db $00 ; 1Ah: Grabbed by Draygon
  db $00 ; 1Bh: Shinespark / crystal flash / drained by metroid / damaged by MB's attacks
}

pose_collision_routine_table:
{
  dw check_samus_always_no_collision
  dw check_samus_is_inside_enemy
  dw check_samus_is_standing_on_enemy
}

check_samus_always_no_collision:
{
  LDA #$0000
  RTL
}

check_samus_is_inside_enemy:
{
  ; A = |[Samus X position] - [Enemy X position]|
  LDA $0AF6
  SEC
  SBC $0F7A,x
  BPL +
  EOR #$FFFF
  INC A

  ; If A - [Samus X radius] - [Enemy X radius] >= 0: return 0
+ SEC
  SBC $0AFE
  BCC +
  CMP $0F82,x
  BCC +
  BRA .no_collision

  ; A = |[Samus Y position] - [Enemy Y position]|
+ LDA $0AFA
  SEC
  SBC $0F7E,x
  BPL +
  EOR #$FFFF
  INC A

  ; If A - [Samus Y radius] - [Enemy Y radius] >= 0: return 0
+ SEC
  SBC $0B00
  BCC .collision
  DEC
  CMP $0F84,x
  BCC .collision

.no_collision
  LDA #$0000
  RTL

.collision:
  LDA #$FFFF
  RTL
}

check_samus_is_standing_on_enemy:
{
  ; A = |[Samus X position] - [Enemy X position]|
  LDA $0AF6
  SEC
  SBC $0F7A,x
  BPL .label1
  EOR #$FFFF
  INC A

.label1:
  ; If A - [Samus X radius] - [Enemy X radius] >= 0: return 0
  SEC
  SBC $0AFE
  BCC .label2
  CMP $0F82,x
  BCC .label2
  LDA #$0000
  RTL

.label2:
  ; If [Samus Y position] + [Samus Y radius] > [Enemy Y position]: return 0
  LDA $0AFA
  CLC
  ADC $0B00
  SEC
  SBC $0F7E,x
  BMI .label3
  BRA .not_standing_on_enemy

.label3
  ; If [Samus Y position] + [Samus Y radius] + 1 >= [Enemy Y position] + [Enemy Y radius]: return FFFFh
  INC
  CLC
  ADC $0F84,x
  BPL .standing_on_enemy

.not_standing_on_enemy:
  LDA #$0000
  RTL

.standing_on_enemy:
  LDA #$FFFF
  RTL
}

end_ride_enemies_freespace_a0:
!FREESPACE_A0 := end_ride_enemies_freespace_a0

org !FREESPACE_A3

move_samus_with_geemer_main_ai:
{
  LDX $0E54

  ; if not standing on enemy then we just move the enemy and not Samus
  JSL ride_enemies_check_collision
  BNE .collision

.no_collision:
  JMP ($0FB2,x)

.collision:
  LDA $0F80,x : PHA ; Push [enemy Y sub-pixel pos]
  LDA $0F7E,x : PHA ; Push [enemy Y pos]
  LDA $0F7C,x : PHA ; Push [enemy X sub-pixel pos]
  LDA $0F7A,x : PHA ; Push [enemy X pos]

  JSL geemer_function_trampoline

  PLA : STA $12     ; $12 = [previous enemy X pos]
  PLA : STA $14     ; $14 = [previous enemy X sub-pixel pos]
  PLA : STA $16     ; $16 = [previous Samus Y displacement]
  PLA : STA $18     ; $18 = [previous enemy Y pos]

  ; Extra Samus X displacement = change in enemy X pos/sub-pixel pos
  LDA $0F7C,x
  SEC
  SBC $14
  STA $0B56
  LDA $0F7A,x
  SBC $12
  STA $0B58

  ; Extra Samus Y displacement = change in enemy Y pos/sub-pixel pos
  LDA $0F80,x
  SEC
  SBC $18
  STA $0B5A
  LDA $0F7E,x
  SBC $16
  STA $0B5C

  ; Zero-out Samus's fall speed
  LDA $0B2C
  BMI +
  STZ $0B2C
+
  LDA $02BE
  BMI +
  STZ $0B2E
+

  RTL
}

geemer_function_trampoline:
{
  JMP ($0FB2,x)
}

end_ride_enemies_freespace_a3:
!FREESPACE_A3 := end_ride_enemies_freespace_a3
