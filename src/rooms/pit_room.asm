!pop_pit_room = $A18427

; TODO: I can't open the pit room door back to morph any more

;;
; Remove pirates from pit room
;
; TODO: I think it would be fun to put etecoons here instead (or put them in
; the green pirates room instead)
org !pop_pit_room

; These are the original pirates
; dw $F653,$0268,$0070,$0000,$2000,$0004,$8001,$0010
; dw $F353,$02CD,$003F,$0000,$2000,$0004,$0001,$0020
; dw $F653,$01F9,$0070,$0000,$2000,$0004,$8000,$0010
; dw $F653,$0178,$0070,$0000,$2000,$0004,$8001,$0010
; dw $F653,$0068,$0080,$0000,$2000,$0004,$8001,$0020

; This is what an etecoon looks like
; dw E5BF,025F,0B98,0000,0C00,0000,0000,0000

; This would place etecoons in the room, but I guess we can't do that because
; the tileset for pit room doesn't include etecoons?
; dw $E5BF,$0268,$0070,$0000,$0C00,$0000,$0000,$0000
; dw $E5BF,$02CD,$003F,$0000,$0C00,$0000,$0000,$0000
; dw $E5BF,$01F9,$0070,$0000,$0C00,$0000,$0000,$0000
; dw $E5BF,$0178,$0070,$0000,$0C00,$0000,$0000,$0000
; dw $E5BF,$0068,$0080,$0000,$0C00,$0000,$0000,$0000

dw $FFFF
db $00
