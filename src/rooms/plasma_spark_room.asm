; Room $D340: Header
org $8FD340
db $14       ; Index
db $04       ; Area
db $16       ; X position on map
db $02       ; Y position on map
db $04       ; Width (in screens)
db $06       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $D367     ; Special graphics bits
dw $E5E6     ; State $D34D function (default)

; Room $D340 state $D34D: Header
org $8FD34D
dl $CBA878   ; Level data address
db $0B       ; Tileset
db $00       ; Music data index
db $05       ; Music track index
dw $9DC4     ; FX address (bank $83)
; dw $8000
dw $D957     ; Enemy population offset (bank $A1)
dw plasma_spark_room_enemy_graphics_set ; Enemy graphics set offset (bank $B4)
dw $00E0     ; Layer 2 scroll
dw $D36F     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $C571     ; Room PLM list address (bank $8F)
dw $0000     ; Library background (bank $8F)
dw $C8D1     ; Room setup routine (bank $8F)

; Room $D340 state $D34D: Enemy population
org $A1D957
;  enemy          x      y      init   props  extra  param1 param2
dw $D03F,         $0350, $04F8, $0000, $2000, $0000, $0100, $0304 ; owtch
dw $D03F,         $0338, $04F8, $0000, $2000, $0000, $0101, $0204 ; owtch
; dw $D03F,         $0170, $0568, $0000, $2000, $0000, $0301, $0002 ; owtch
dw !samus_statue, $0180, $0568, $0000, $2400, $0000, $0000, $0007 ; statue
dw $D03F,         $01A0, $05C8, $0000, $2000, $0000, $0501, $0204 ; owtch
dw $D3BF,         $0100, $029C, $0000, $2000, $0000, $0001, $0010 ; choot
dw $D3BF,         $0230, $039C, $0000, $2000, $0000, $0005, $0000 ; choot
dw $D3BF,         $0300, $03A4, $0000, $2000, $0000, $0207, $0000 ; choot
dw $D3BF,         $01E0, $00AC, $0000, $2000, $0000, $0001, $0010 ; choot
dw $D3BF,         $0270, $00EC, $0000, $2000, $0000, $0001, $0010 ; choot
dw $D6FF,         $0300, $0420, $0000, $2800, $0000, $0010, $0210 ; fish
dw $D6FF,         $0270, $0488, $0000, $2800, $0000, $0110, $0210 ; fish
dw $FFFF     ; end of list
db $0B       ; death quota

;;; ; Room $D340 state $D34D: Enemy graphics set
;;; org $B48F22
;;; ;  enemy  palette
;;; dw $D03F, $0001 ; owtch
;;; dw $D3BF, $0002 ; choot
;;; dw $D6FF, $0003 ; fish
;;; dw $FFFF     ; end of list

org !FREESPACE_B4

plasma_spark_room_enemy_graphics_set:

; TODO - using palette 7 for the statue means the helmet is blue; I'm
; okay with that for now since it stands out

;  enemy          palette
dw $D03F,         $0001 ; owtch
dw $D3BF,         $0002 ; choot
dw $D6FF,         $0003 ; fish
dw !samus_statue, $0007 ; statue
dw $FFFF     ; end of list

end_plasma_spark_room_freespace_b4:
!FREESPACE_B4 := end_plasma_spark_room_freespace_b4
