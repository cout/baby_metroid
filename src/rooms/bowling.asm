org $C48322

incbin "bowling.bin"

warnpc $C492DE

;;
; Prevent transformation of blocks into spikes
;

org $849D0F
dw $000E, $812D, $812D, $812D, $812D, $812D, $812D, $812D, $812D, $812D, $812D, $812D, $812D, $812D, $812D

org $84D3F8
LDA #$8000

org $84D401
LDA #$8000
