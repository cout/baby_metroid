; Room $CAF6: Header
org $8FCAF6
db $04       ; Index
db $03       ; Area
db $0C       ; X position on map
db $0B       ; Y position on map
db $06       ; Width (in screens)
db $08       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $CB3C     ; Door out
dw $E629     ; State $CB22 function (boss)
db $01       ; Boss
dw $CB22     ; State header address
dw $E5E6     ; State $CB08 function (default)

; Room $CAF6 state $CB08: Header
; (default)
org $8FCB08
dl $C4A9AC   ; Level data address
db $05       ; Tileset
db $30       ; Music data index
db $05       ; Music track index
dw $9BE4     ; FX address (bank $83)
dw $BCA0     ; Enemy population offset (bank $A1)
dw $8B6D     ; Enemy graphics set offset (bank $B4)
dw $C1C1     ; Layer 2 scroll
dw $CB4A     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $C247     ; Room PLM list address (bank $8F)
dw $E19E     ; Library background (bank $8F)
dw $C8C7     ; Room setup routine (bank $8F)

; Room $CAF6 state $CB22: Header
; (boss bit 01h)
org $8FCB22
dl $C4BDC0   ; Level data address
db $04       ; Tileset
db $30       ; Music data index
db $06       ; Music track index
dw $9B02     ; FX address (bank $83)
dw $CD17     ; Enemy population offset (bank $A1)
dw $8D2B     ; Enemy graphics set offset (bank $B4)
dw $C1C1     ; Layer 2 scroll
dw $CB4A     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $C247     ; Room PLM list address (bank $8F)
dw $E19E     ; Library background (bank $8F)
dw $C8C7     ; Room setup routine (bank $8F)

; Room $CAF6 state $CB08: Enemy population
org $A1BCA0
;  enemy  x      y      init   props  extra  param1 param2
dw $E77F, $0038, $03D8, $0000, $6800, $0000, $0000, $0000 ; covern
; dw $D87F, $0442, $034A, $0000, $2400, $0000, $7002, $0050 ; sbug
dw $D87F, $044D, $0351, $0000, $2400, $0000, $7C02, $0050 ; sbug
dw $D87F, $04C8, $03CC, $0000, $2400, $0000, $CC03, $0050 ; sbug
dw $D87F, $04C5, $03D3, $0000, $2400, $0000, $D804, $0080 ; sbug
dw $D87F, $04CE, $03D9, $0000, $2400, $0000, $D003, $00A0 ; sbug
dw $D87F, $04CB, $04CB, $0000, $2400, $0000, $2003, $00A0 ; sbug
dw $D87F, $04CC, $04D6, $0000, $2400, $0000, $FF02, $00A0 ; sbug
dw $D87F, $04C4, $04D1, $0000, $2400, $0000, $0A03, $0050 ; sbug
dw $D87F, $04DE, $04BE, $0000, $2400, $0000, $D003, $0050 ; sbug
dw $D87F, $03A7, $0521, $0000, $2400, $0000, $7A02, $0050 ; sbug
dw $D87F, $03B9, $052C, $0000, $2400, $0000, $7E02, $0050 ; sbug
dw $D87F, $04C4, $027D, $0000, $2400, $0000, $FC02, $0050 ; sbug
dw $D87F, $04CA, $028A, $0000, $2400, $0000, $0803, $0080 ; sbug
dw $D87F, $04DB, $0278, $0000, $2400, $0000, $E003, $0080 ; sbug
dw $D87F, $0425, $0210, $0000, $2400, $0000, $8402, $0080 ; sbug
dw $D87F, $0424, $0206, $0000, $2400, $0000, $7802, $0040 ; sbug
dw $D87F, $0145, $02BA, $0000, $2400, $0000, $9103, $0040 ; sbug
dw $D87F, $013D, $02C3, $0000, $2400, $0000, $8C02, $0040 ; sbug
dw $D87F, $010D, $02DB, $0000, $2400, $0000, $AC03, $0080 ; sbug
dw $D87F, $01AD, $04E8, $0000, $2400, $0000, $E804, $0020 ; sbug
; TODO - Removing kzan since it's the enemy least likely to be missed;
; the game crashes with so many enemy types in one room (did not
; investigate why; possibly a bug in the statue).
; dw $DFFF, $0260, $0558, $0000, $A000, $0000, $0000, $0000 ; kzan
; dw $E03F, $0260, $0560, $0000, $0100, $0000, $0000, $0000 ; kzan
; dw $DFFF, $01C0, $0558, $0000, $A000, $0000, $0000, $0000 ; kzan
; dw $E03F, $01C0, $0560, $0000, $0100, $0000, $0000, $0000 ; kzan
; dw $DFFF, $0120, $0558, $0000, $A000, $0000, $0000, $0000 ; kzan
; dw $E03F, $0120, $0560, $0000, $0100, $0000, $0000, $0000 ; kzan
; dw $DFFF, $0080, $0558, $0000, $A000, $0000, $0000, $0000 ; kzan
; dw $E03F, $0080, $0560, $0000, $0100, $0000, $0000, $0000 ; kzan
dw $E9FF, $0430, $07D0, $0000, $2000, $0000, $0000, $0000 ; atomic
dw $E9FF, $04D0, $07D0, $0000, $2000, $0000, $0000, $0000 ; atomic
dw !samus_statue, $0440, $069D, $0000, $2400, $0000, $0000, $0205
dw $FFFF     ; end of list
db $03       ; death quota

; Room $CAF6 state $CB22: Enemy population
org $A1CD17
;  enemy  x      y      init   props  extra  param1 param2
dw $EA3F, $0498, $02A8, $0000, $2000, $0000, $0001, $0030 ; spark
dw $EA3F, $0470, $0359, $0000, $2000, $0000, $0001, $0028 ; spark
dw $EA3F, $0420, $048C, $0000, $2000, $0000, $0001, $0020 ; spark
dw $EA3F, $04C8, $0508, $0000, $2000, $0000, $0001, $0020 ; spark
dw $EA3F, $0488, $05BC, $0000, $2000, $0000, $0001, $0018 ; spark
dw $EA3F, $0469, $071A, $0000, $2000, $0000, $0000, $0000 ; spark
dw $EA3F, $0418, $0788, $0000, $2000, $0000, $0002, $0030 ; spark
dw $E9FF, $0478, $0252, $0000, $2000, $0000, $0000, $0008 ; atomic
dw $E9FF, $04D5, $02AB, $0000, $2000, $0000, $0001, $0008 ; atomic
dw $E9FF, $04C0, $0507, $0000, $2000, $0000, $0002, $0008 ; atomic
dw $E9FF, $0426, $05B9, $0000, $2000, $0000, $0002, $0008 ; atomic
dw $DFFF, $0260, $0558, $0000, $A000, $0000, $0020, $5030 ; kzan
dw $E03F, $0260, $0560, $0000, $0100, $0000, $0000, $0000 ; kzan
dw $DFFF, $01C0, $0558, $0000, $A000, $0000, $0020, $5030 ; kzan
dw $E03F, $01C0, $0560, $0000, $0100, $0000, $0000, $0000 ; kzan
dw $DFFF, $0120, $0558, $0000, $A000, $0000, $0020, $5030 ; kzan
dw $E03F, $0120, $0560, $0000, $0100, $0000, $0000, $0000 ; kzan
dw $DFFF, $0080, $0558, $0000, $A000, $0000, $0020, $5030 ; kzan
dw $E03F, $0080, $0560, $0000, $0100, $0000, $0000, $0000 ; kzan
dw $EA3F, $04D0, $07C8, $0000, $2000, $0000, $0001, $0030 ; spark
dw $EA3F, $0430, $07C8, $0000, $2000, $0000, $0001, $0020 ; spark
dw $FFFF     ; end of list
db $04       ; death quota

; Room $CAF6 state $CB08: Enemy graphics set
org $B48B6D
;  enemy  palette
dw !samus_statue, $0007 ; statue
dw $E77F, $0001 ; covern
; dw $DFFF, $0002 ; kzan
dw $E9FF, $0003 ; atomic
dw $D87F, $0003 ; sbug
dw $FFFF     ; end of list

; Room $CAF6 state $CB22: Enemy graphics set
org $B48D2B
;  enemy  palette
dw $EA3F, $0001 ; spark
dw $E9FF, $0002 ; atomic
dw $DFFF, $0003 ; kzan
dw $FFFF     ; end of list

; Room $CAF6 state $CB08: FX
org $839BE4
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $FFFF, $FFFF, $0000 : db $00, $00, $08, $02, $00, $00, $00, $00

; Room $CAF6 state $CB22: FX
org $839B02
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $FFFF, $FFFF, $0000 : db $00, $00, $02, $02, $00, $01, $06, $00
