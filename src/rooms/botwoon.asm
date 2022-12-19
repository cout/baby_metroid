org $8FD970
dl $CD950E   ; Level data address
db $0C       ; Tileset
db $2A       ; Music data index
db $03       ; Music track index (elevator music)

org $CD950E
incbin "botwoon.bin"
warnpc $CD991E
