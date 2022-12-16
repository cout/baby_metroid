org $C48322

incbin "bowling.bin"

warnpc $C492DE

;;
; Prevent transformation of blocks into spikes
;

org $849D0F
; dw $000E, $A12B, $A12B, $A12B, $A12B, $A12B, $A12B, $A12B, $A12B, $A12B, $A12B, $A12B, $A12B, $A12B, $812B
; dw $000E, $8111, $8111, $8111, $8111, $8111, $8111, $8111, $8111, $8111, $8111, $8111, $8111, $8111, $812B
dw $000E, $8161, $8162, $8163, $8164, $8165, $8166, $8167, $8161, $8162, $8163, $8164, $8165, $8166, $8167

org $84D3F8
LDA #$8000

org $84D401
LDA #$8000
