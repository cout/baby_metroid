;;
; Give the torizos 0 health.
org $A0EF03 : DW $0000
org $A0EF43 : DW $0000
org $A0EF83 : DW $0000
org $A0EFC3 : DW $0000

;; 
; Make BT crumble into nothing and open the door right away
; TODO: the door should not open until after BT crumbles
org $AAC6C6

LDA #$0004
JSL $8081A6
RTS
