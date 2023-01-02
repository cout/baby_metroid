;;
; Disable eye door projectiles
;

org $84D77A
INY
INY
RTS

;;
; Prevent eye from closing when Samus is too close
;

org $84D83C
dw $8724, $D842
