; TODO:
;
; Ideas:
; * Replace space pirates with etecoons
; * Replace climb pirates with dachora (ride the dachor up!)
; * Croc really does take a bath
; * Get rid of "nothing" drops
; * Any rooms where all enemies have to be killed to exit the room will
;   currently softlock
; * Elliott does not like the mosquitoes - replace them with something
;   else
; * apple sporespawn - https://metroidconstruction.com/resource.php?id=2
; * easier wall jumps - https://metroidconstruction.com/resource.php?id=545
; * climb room elevator - https://metroidconstruction.com/resource.php?id=445
; * flying ship - https://metroidconstruction.com/resource.php?id=73
; * older flying ship - https://metroidconstruction.com/resource.php?id=39
; * prevent early supers (use power bomb blocks)
; * for kraid, perhaps put mini-kraid into his room instead (and require some trick to get out of the room)
; * is there a more intuitive way through green pirates room?

!debug_flag = $7E0DE0

lorom

incsrc enemies.asm
incsrc freeze_enemies.asm
incsrc death_quota.asm
incsrc torizos.asm
incsrc spore_spawn.asm
incsrc enemy_drops.asm
incsrc ceres.asm
incsrc rooms/climb.asm
incsrc rooms/pit_room.asm
