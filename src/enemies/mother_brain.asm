;;
; Disable MB turrets
;

org $A986F2
RTL

;;
; Skip phase 2
;

org $A98F3F
LDA #$BDD2

;;
; Don't put Samus into drained pose when baby latches
;

org $A9C849
RTS

;;
; Skip phase 3
;

org $A9C059
LDA #$AF54
