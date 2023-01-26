org !FREESPACE_A0

small_baby:

dw $1000           ; tile data size
dw $E9AF           ; palette
dw $01F4           ; health
dw $0078           ; damage
dw $000A           ; x radius
dw $000A           ; y radius
db $A3             ; bank
db $00             ; hurt ai time
dw $005A           ; cry
dw $0000           ; boss value
dw $EA4F           ; init ai routine
dw $0001           ; number of parts
dw $0000           ; unused
dw $EB98           ; main ai routine
dw $800F           ; grapple ai routine
; dw $EB33           ; hurt ai routine
; dw $EAE6           ; frozen ai routine
dw $804C           ; hurt ai routine
dw $8041           ; frozen ai routine
dw $0000           ; time is frozen ai routine
dw $0004           ; death animation
dd $00000000       ; unused
; dw $F042           ; power bomb reaction
dw $0000           ; power bomb reaction
dw $0000           ; unknown
dd $00000000       ; unused
dw $EDEB           ; touch routine
dw $EF07           ; shot routine
dw $0000           ; unknown
dl $AE9000         ; tile data
db $05             ; layer
dw $F36E           ; drop chances
; dw $EF60           ; vulnerabilities
dw $EEC6           ; vulnerabilities (invulnerable)
dw $DFAB           ; enemy name

; TODO - if the baby is frozen, it should set a power bomb to unfreeze
; itself

end_small_baby_freespace_A0:
!FREESPACE_A0 := end_small_baby_freespace_A0
