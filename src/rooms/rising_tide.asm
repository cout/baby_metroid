;;
; Make enemies intangible
;
; This is to prevent Samus from getting stuck
;

org $A1A6A8 ; rising tide enemy population

skip 8 : dw $A000 : skip 6 ; squeept
skip 8 : dw $A400 : skip 6 ; squeept
skip 8 : dw $A000 : skip 6 ; nova
skip 8 : dw $A000 : skip 6 ; nova
skip 8 : dw $A001 : skip 6 ; nova
skip 8 : dw $A002 : skip 6 ; nova
skip 8 : dw $A003 : skip 6 ; nova
skip 8 : dw $A000 : skip 6 ; dragon
skip 8 : dw $A400 : skip 6 ; dragon
skip 8 : dw $A000 : skip 6 ; dragon
skip 8 : dw $A400 : skip 6 ; dragon
skip 8 : dw $A000 : skip 6 ; dragon
skip 8 : dw $A400 : skip 6 ; dragon
skip 8 : dw $A000 : skip 6 ; dragon
skip 8 : dw $A400 : skip 6 ; dragon
skip 8 : dw $A400 : skip 6 ; squeept
