;; Replace climb pirates with rippers
; 
; (this causes the game to crash)

; org $A0F353
; dw $0400, $E457, $00C8, $0005, $0008, $0004
; db $A2, $00
; dw $003E, $0000, $E49F, $0001, $0000, $E4DA, $800F, $804C, $8041, $0000, $0000
; dd $00000000
; dw $0000, $E477
; dd $00000000
; dw $8023, $802D, $E56F
; dl $AEC520
; db $05
; dw $F308, $EDEA, $E08B
; 
; org $A0F393
; dw $0400, $E457, $00C8, $0005, $0008, $0004
; db $A2, $00
; dw $003E, $0000, $E49F, $0001, $0000, $E4DA, $800F, $804C, $8041, $0000, $0000
; dd $00000000
; dw $0000, $E477
; dd $00000000
; dw $8023, $802D, $E56F
; dl $AEC520
; db $05
; dw $F308, $EDEA, $E08B

;;
; Replace the climb pirates with dachora
; (the dachora are invisible and do not move)

; org $A0F353
; 
; dw $0C00, $F225, $7FFF, $0000, $0008, $0018
; db $A7, $00
; dw $0000, $0000, $F4DD, $0001, $0000, $F52E, $8000, $804C, $8041, $0000, $0000
; dd $00000000
; dw $804C, $0000
; dd $00000000
; dw $804C, $804C, $0000
; dl $AC8800
; db $05
; dw $F488, $0000, $0000
; 
; org $A0F393
; 
; dw $0C00, $F225, $7FFF, $0000, $0008, $0018
; db $A7, $00
; dw $0000, $0000, $F4DD, $0001, $0000, $F52E, $8000, $804C, $8041, $0000, $0000
; dd $00000000
; dw $804C, $0000
; dd $00000000
; dw $804C, $804C, $0000
; dl $AC8800
; db $05
; dw $F488, $0000, $0000

;;
; Replace the climb pirates with etecoons
; (the etecoons sing but are invisible and do not move)

; org $A0F353
; dw $0600, $E7FE, $7FFF, $0000, $0006, $0007
; db $A7, $00
; dw $0000, $0000, $E912, $0001, $0000, $E940, $8000, $804C, $8041, $0000, $0000
; dd $00000000
; dw $804C, $0000
; dd $00000000
; dw $804C, $804C, $0000
; dl $AC8200
; db $05
; dw $F482, $0000, $0000
; 
; org $A0F393
; dw $0600, $E7FE, $7FFF, $0000, $0006, $0007
; db $A7, $00
; dw $0000, $0000, $E912, $0001, $0000, $E940, $8000, $804C, $8041, $0000, $0000
; dd $00000000
; dw $804C, $0000
; dd $00000000
; dw $804C, $804C, $0000
; dl $AC8200
; db $05
; dw $F482, $0000, $0000
