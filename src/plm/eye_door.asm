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

; facing left
org $84D83C
dw $8724, $D842

;facing right
org $84D973
dw $8724, $D979

;;
; Blink faster
;

;facing left
org $84D862
dw #$0006

;facing left
org $84D866
dw #$0006

;facing right
org $84D999
dw #$0006

;facing right
org $84D99D
dw #$0006
