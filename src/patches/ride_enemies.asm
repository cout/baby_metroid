;;;;;
;
; Allow Samus to "ride" enemies as if they are trippers/kamers.
;
; TODO:
; * Samus cannot ride enemies up a slope without oscillating (e.g. in
;   Terminator)
; * It is possible to change the touching function from A0AC29 (check
;   for touching Samus from below) to A0ABE7 (check for touching Samus
;   anywhere).  This does not fix riding up the wall, but it has another
;   interesting effect: Reos push Samus a lot farther when they make
;   contact.
; * Another interesting change is to not push the processor bits.  Since
;   wall collision is communicated in the carry bit, this has the effect
;   of causing rippers to stop at a wall when Samus is riding and
;   causing zeelas to fall off edges when Samus stands on them.  But I
;   don't know what other effects this might have so I need to play both
;   ways and see which way I like best.
;
;;;;;


;;
; Hook routine to move enemies horizontally to move Samus with them

org $A0C6AD

move_enemy_horiz:

BRL move_samus_horiz_with_enemy

org $A0C6B5

do_move_enemy_horiz:


;;
; Hook routine to move enemies vertically to move Samus with them

org $A0C788

move_enemy_vert:

BRL move_samus_vert_with_enemy

org $A0C790

do_move_enemy_vert:


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
BNE .not_touching

; if not touching then we just move the enemy and not Samus
JSL $A0AC29
BNE .touching

.not_touching
BRL do_move_enemy_horiz

.touching

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
BNE .not_touching

; if not touching then we just move the enemy and not Samus
JSL $A0AC29
BNE .touching

.not_touching
BRL do_move_enemy_vert

.touching:

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

end_ride_enemies_freespace_a0:
!FREESPACE_A0 := end_ride_enemies_freespace_a0
