;;;;;
;
; Allow Samus to "ride" enemies as if they are trippers/kamers.
;
; Bugs/Limitations:
; * Samus cannot ride enemies up a slope without oscillating (e.g. in
;   Terminator)
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
  BNE .not_standing_on_enemy

  ; if not standing on enemy then we just move the enemy and not Samus
  JSL check_samus_is_standing_on_enemy
  BNE .standing_on_enemy

.not_standing_on_enemy
  BRL do_move_enemy_horiz

.standing_on_enemy

  LDA $0F7C,x : PHA  ; Push [enemy X pos]
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
  BNE .not_standing_on_enemy

  ; if not standing on enemy then we just move the enemy and not Samus
  JSL check_samus_is_standing_on_enemy
  BNE .standing_on_enemy

.not_standing_on_enemy
  BRL do_move_enemy_vert

.standing_on_enemy

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

.return:

  PLP
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
  ; If A - [Samus X radius] - [Enemy X position] >= 0: return 0
  SEC
  SBC $0AFE
  BCC $09
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
