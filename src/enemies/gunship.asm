;;
; Change where in memory the takeoff dust particles are written in vram.
;
; Only the second 400-byte group seems to conflict with anything on
; screen during the takeoff sequence; by writing elsewhere we avoid
; clobbering the baby's memory.
;

org $A2AC11
; dw $7A00, $7800, $7A00, $7C00, $7E00
dw $7600, $7A00, $7A00, $7C00, $7E00

;;
; Quickly be able to turn on/off individual takeoff dust particles (for
; testing).
;

org $A2AC9A
p0:
; BRA p1

org $A2ACA4
p1:
; BRA p2

; This dust cloud is garbled
org $A2ACAE
p2:
BRA p3

org $A2ACB8
p3:
; BRA p4

org $A2ACC2
p4:
; BRA p5

; This dust cloud is garbled
org $A2ACCC
p5:
BRA r

org $A2ACD6
r:
