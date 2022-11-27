org $A0A226
LDA $0F7A,x : STA $12 ; $12 = enemy x pos
LDA $0F7E,x : STA $14 ; $14 = enemy y pos
LDA $0F78,x           ; A = pointer to enemy header
BRL spawn_enemy_drops

org $A0920E
spawn_enemy_drops:

; TODO - do we also want to do this for enemies with extended spritemaps?
