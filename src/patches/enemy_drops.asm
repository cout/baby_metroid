;;;;;
;
; Give drops for most enemies when they are shot rather than killing
; them.
;
;;;;;

org $A0A722

JMP handle_projectile_damage_beam

spawn_enemy_drops = $A0920E

org !FREESPACE_A0

handle_projectile_damage_beam:
{
  LDX $0E54 ; X = current enemy index

  ; If this enemy has an extended spritemap, then handle the beam shot
  ; normally (this is probably a boss)
  LDA $0F88,x ; A = extra properties
  AND #$0004
  BNE .handle_beam_shot

  ; If the projectile type is hyper beam, handle the beam shot normally.
  ; Hyper beam is detected by checking the projectile damage amount; if
  ; it is 1000 or more we assume this is hyper beam.
  PHX
  LDA $18A6   ; projectile index
  ASL A
  TAX
  LDA $0C2C,x ; projectile damage
  PLX
  CMP #$03E8
  BCS .handle_beam_shot

  ; If we do not have ice beam then just spawn drops without freezing
  PHX
  LDA $18A6   ; projectile index
  ASL A
  TAX
  LDA $0C18,x ; projectile type
  PLX
  BIT #$0002
  BEQ .spawn_drops

  ; If enemy is one-shot to ice, then freeze or refreeze it
  LDA $0E40
  BIT #$00FF
  BNE .ice_beam

  ; If enemy is not vulnerable to ice, then spawn jobs without freezing
  BIT #$0080
  BNE .spawn_drops

.ice_beam:
  ; If enemy is frozen, spawn drops
  LDA $0F9E,x
  BNE .refreeze_and_spawn_drops

  ; If enemy is not frozen, freeze without spawning drops
  BRA .freeze_enemy

.refreeze_and_spawn_drops:
  JSR freeze_enemy

.spawn_drops:
  LDA $0F7A,x : STA $12 ; $12 = enemy x pos
  LDA $0F7E,x : STA $14 ; $14 = enemy y pos
  LDA $0F78,x           ; A = pointer to enemy header
  JSL spawn_enemy_drops

  ; return with no damage
  JMP $A7D2

.handle_beam_shot:
  ; handle the beam shot
  JMP $A72D

.freeze_enemy:
  JMP $A7D5
}

; This is a duplicate of $A0:A88A (which crashes if I try to call it as
; a subroutine even if I PHB first)
freeze_enemy:
{
  LDY #$0190
  LDA $079F
  CMP #$0002
  BNE +
  LDY #$012C
+

  TYA
  STA $0F9E,x
  LDA $0F8A,x
  ORA #$0004
  STA $0F8A,x
  LDA #$000A
  STA $0FA0,x
  LDA #$000A
  JSL $809139

  RTS
}

end_enemy_drops_freespace_a0:
!FREESPACE_A0 := end_enemy_drops_freespace_a0
