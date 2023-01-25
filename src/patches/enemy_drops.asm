;;;;;
;
; Give drops for most enemies when they are shot rather than killing
; them.
;
;;;;;

org $A0A722

JML handle_projectile_damage_beam

spawn_enemy_drops = $A0920E

org !FREESPACE_A0

handle_projectile_damage_beam:
{
  ; If we have ice and this enemy is vulnerable to ice, then freeze the
  ; enemy.
  ; TODO - this only works for enemies that take one shot to freeze; it
  ; does not work e.g. for fish
  ; TODO - we want to get drops if we shoot a frozen enemy
  LDA $0E40
  CMP #$00FF
  BEQ .freeze_enemy

  LDX $0E54 ; X = current enemy index

  ; If this enemy has an extended spritemap, then handle the beam shot
  ; normally (this is probably a boss)
  LDA $0F88,x ; A = extra properties
  AND #$0004
  BNE .handle_beam_shot

  ; If the projectile type is hyper beam, handle the beam shot normally
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

.spawn_drops:
  LDA $0F7A,x : STA $12 ; $12 = enemy x pos
  LDA $0F7E,x : STA $14 ; $14 = enemy y pos
  LDA $0F78,x           ; A = pointer to enemy header
  JSL spawn_enemy_drops

  ; return with no damage
  JML $A0A7D2

.handle_beam_shot:
  ; handle the beam shot
  JML $A0A72D

.freeze_enemy:
  JML $A0A7D5
}

end_enemy_drops_freespace_a0:
!FREESPACE_A0 := end_enemy_drops_freespace_a0
