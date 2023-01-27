org !FREESPACE_A0

water_zoomer:

dw $0600          ; tile data size
; dw $E5B0          ; palette
; dw $DFA2          ; palette - hzoomer (TODO: not sure why this doesn't show up right)
; dw $965B          ; palette - sciser (this looks cool, orange/green/blue)
; dw $E57C          ; palette - nova (orange/gold/green)
; dw $B3A1            ; palette - zoa (purple/green/brown)
dw $8C0F            ; palette - fireflea (orange/green/blue, like sciser)
; dw $900A            ; palette - fish (purple/yellow/red)
; dw $AF85            ; palette - desgeega (purple/green/red)
dw $000F          ; health
dw $0005          ; damage
dw $0008          ; x radius
dw $0008          ; y radius
db $A3            ; bank
db $00            ; hurt ai time
dw $0023          ; cry
dw $0000          ; boss value
dw $E669          ; init ai routine
dw $0001          ; number of parts
dw $0001          ; unused
dw $E6C2          ; main ai routine
dw $800A          ; grapple ai routine
dw $804C          ; hurt ai routine
dw $8041          ; frozen ai routine
dw $0000          ; time is frozen ai routine
dw $0000          ; death animation
dd $00000000      ; unused
dw $0000          ; power bomb reaction
dw $0000          ; unknown
dd $00000000      ; unused
dw $8023          ; touch routine
dw $802D          ; shot routine
dw $0000          ; unknown
dl $AE8000        ; tile data
db $05            ; layer
dw $F224          ; drop chances
; dw $EC48          ; vulnerabilities
dw $EEC6           ; vulnerabilities (invulnerable)
dw $E1DB          ; enemy name

end_water_zoomer_freespace_a0:
!FREESPACE_A0 := end_water_zoomer_freespace_a0
