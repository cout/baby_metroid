org $A198D1 ; address of unused slot just before enemy population for room $A6A1

warehouse_entrance_enemy_population:

;                    x      y   init  props   xtra     p1     p2
dw !elevator,     $0080, $00A0, $0000, $2C00, $0000, $0000, $0140
dw !samus_statue, $00E4, $0094, $0000, $2400, $0000, $0001, $0000
dw $FFFF
db $00

org !FREESPACE_B4

warehouse_entrance_enemy_graphics_set:

dw !samus_statue, $0001, $FFFF
db $00

end_warehouse_entrance_freespace_b4:
!FREESPACE_B4 := end_warehouse_entrance_freespace_b4

org $8FA6AE ; room state for room $A6A1
skip 8 ; offset of enemy population pointer

dw warehouse_entrance_enemy_population
dw warehouse_entrance_enemy_graphics_set
