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

; if not touching then we just move the enemy and not Samus
JSL $A0AC29
BNE .touching
BRL do_move_enemy_horiz

.touching

LDA $0F7A,x : PHA  ; Push [enemy X pos]
LDA $0B58   : PHA  ; Push [Samus X displacement]

JSL do_move_enemy_horiz

PLA : STA $18      ; $18 = [previous Samus X displacement]
PLA : STA $16      ; $16 = [previous enemy X pos]

PHP

; If Samus X changed, then don't move Samus on the X axis
; (this is to avoid moving Samus twice on trippers and kamers)
LDA $0B58
CMP $18
BNE .return

; Extra samus X displacement = [enemy X pos] - [previous enemy X pos]
LDA $0F7A,x
SEC
SBC $16
CLC
ADC $0B58
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

; if not touching then we just move the enemy and not Samus
JSL $A0AC29
BNE .touching
BRL do_move_enemy_vert

.touching:

LDA $07FE,x : PHA ; Push [enemy Y pos]
LDA $0B5C   : PHA ; Push [Samus Y displacement]

JSL do_move_enemy_vert

PLA : STA $18 ; $18 = [previous Samus Y displacement]
PLA : STA $16 ; $16 = [previous enemy Y pos]

PHP

; If Samus Y changed, then don't move Samus on the Y axis
; (this is to avoid moving Samus twice on trippers and kamers)
LDA $0B5C
CMP $18
BNE .return

; Extra Samus Y displacement = [enemy Y pos] - [previous enemy Y pos]
LDA $07FE,x
SEC
SBC $16
CLC
ADC $0B5C
STA $0B5C

.return:

PLP
RTL

}
