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

;;
; Don't put Samus into drained pose when baby tries to heal
;

org $A9C977
JMP $C97E

;;
; Disable palette change (messes up baby graphics)
;

org $A9AF77
JMP $AF91

;;
; Skip head falling
;

org $A9B127
JMP $B1BE
