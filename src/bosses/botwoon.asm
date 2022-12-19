; Permanently hides the body.
; TODO - undo if samus is hidden when botwoon comes out
org $B39CBC : LDA #$0001

; Hide botwoon's head except when coming out of the hole
; TODO - undo if samus is hidden when botwoon comes out
org $B39E1F : LDA #$9389

; Disable botwoon spit
org $B39F0A : JMP $9F17
org $BE9F57 : JMP $9F61

; Disable spit sound effect
org $B39572 : RTL

; Keep health above 800
org $B3A036
LDA #$0320
STA $0F8C,x
RTL

; Keep botwoon full health behavior even when damaged
; TODO - use the flag set in this function ($7E:803E) to override
; Botwoon's behavior and force coming out of the hole if Samus is hidden
org $B3995D : RTS

