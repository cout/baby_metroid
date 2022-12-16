; org $C2EB45
incbin "west_ocean.bin" -> $C2EB45
; warnpc $C381EF

;;
; Replace the zeb with a statue
;

; Room $93FE state $940B: Enemy population
org $A18684
;  enemy          x      y      init   props  extra  param1 param2
dw $D6FF,         $04A4, $0570, $0000, $2000, $0000, $0010, $0210 ; fish
dw $D6FF,         $03CB, $057A, $0000, $2000, $0000, $0110, $0210 ; fish
dw !samus_statue, $0154, $0260, $0000, $2400, $0000, $0002, $0006 ; statue
dw $D3FF,         $0590, $0430, $0010, $2800, $0000, $0560, $05C0 ; ripper2 (green)
dw $D7FF,         $0150, $00D8, $0000, $A000, $0000, $0000, $0010 ; horizontal kamer
dw $D7FF,         $0388, $0058, $0000, $A000, $0000, $0000, $0010 ; horizontal kamer
dw $D7FF,         $0370, $0160, $0000, $A000, $0000, $0001, $0010 ; horizontal kamer
dw $FFFF     ; end of list
db $07       ; death quota
warnpc $A1A6FA

; Room $93FE state $940B: Enemy graphics set
org $B48161
;  enemy          palette
dw $D6FF,         $0001 ; fish
dw !samus_statue, $0002 ; zeb
dw $D3FF,         $0003 ; ripper2 (green)
dw $D7FF,         $0007 ; horizontal kamer
dw $FFFF                ; end of list
warnpc $B4817E
