; Room $975C: Header
org $8F975C
db $13       ; Index
db $00       ; Area
db $14       ; X position on map
db $11       ; Y position on map
db $03       ; Width (in screens)
db $02       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $97A1     ; Door out
dw $E652     ; State $9787 function (zebes_awake)
dw $9787     ; State header address
dw $E5E6     ; State $976D function (default)

; Room $975C state $976D: Header
; (default)
org $8F976D
dl $C3D9F7   ; Level data address
db $03       ; Tileset
db $00       ; Music data index
db $05       ; Music track index
dw $819E     ; FX address (bank $83)
dw $8A15     ; Enemy population offset (bank $A1)
dw $820F     ; Enemy graphics set offset (bank $B4)
dw $C1C1     ; Layer 2 scroll
dw $97A5     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $83B6     ; Room PLM list address (bank $8F)
dw $B905     ; Library background (bank $8F)
dw $91D4     ; Room setup routine (bank $8F)

; Room $975C state $9787: Header
; (zebes_awake)
org $8F9787
dl $C3D9F7   ; Level data address
db $02       ; Tileset
db $09       ; Music data index
db $05       ; Music track index
dw $8080     ; FX address (bank $83)
dw $8427     ; Enemy population offset (bank $A1)
dw $808F     ; Enemy graphics set offset (bank $B4)
dw $C1C1     ; Layer 2 scroll
dw $97A5     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $83D0     ; Room PLM list address (bank $8F)
dw $B905     ; Library background (bank $8F)
dw $91BC     ; Room setup routine (bank $8F)

; Room $975C state $976D: Enemy population
org $A18A15
;  enemy  x      y      init   props  extra  param1 param2
dw $D87F, $006B, $0038, $0000, $2400, $0000, $2802, $0050 ; sbug
dw $D87F, $0070, $0034, $0000, $2400, $0000, $7803, $0050 ; sbug
dw $D87F, $005A, $002D, $0000, $2400, $0000, $7C02, $0050 ; sbug
dw $D87F, $0073, $00AD, $0000, $2400, $0000, $9402, $0050 ; sbug
dw $D87F, $007A, $00B7, $0000, $2400, $0000, $C403, $0050 ; sbug
dw $D87F, $006C, $00C3, $0000, $2400, $0000, $7C03, $0050 ; sbug
dw $D87F, $007F, $00B2, $0000, $2400, $0000, $C203, $0050 ; sbug
dw $D87F, $00BD, $00CA, $0000, $2400, $0000, $C103, $0050 ; sbug
dw $D87F, $02C9, $00A6, $0000, $2400, $0000, $F002, $0050 ; sbug
dw $D87F, $02CC, $00AB, $0000, $2400, $0000, $EC04, $0050 ; sbug
dw $FFFF     ; end of list
db $00       ; death quota

; Room $975C state $9787: Enemy population
org $A18427
;  enemy  x      y      init   props  extra  param1 param2
dw $F653, $0268, $0070, $0000, $2000, $0004, $8001, $0010 ; batta3 (crateria grey walking pirate)
dw $F353, $02CD, $003F, $0000, $2000, $0004, $0001, $0020 ; batta1 (crateria grey wall pirate)
dw $F653, $01F9, $0070, $0000, $2000, $0004, $8000, $0010 ; batta3 (crateria grey walking pirate)
dw $F653, $0178, $0070, $0000, $2000, $0004, $8001, $0010 ; batta3 (crateria grey walking pirate)
dw $F653, $0068, $0080, $0000, $2000, $0004, $8001, $0020 ; batta3 (crateria grey walking pirate)
dw $FFFF     ; end of list
db $05       ; death quota

; Room $975C state $976D: Enemy graphics set
org $B4820F
;  enemy  palette
dw $D87F, $0007 ; sbug
dw $EA7F, $0007 ; koma
dw $FFFF     ; end of list

; Room $975C state $9787: Enemy graphics set
org $B4808F
;  enemy  palette
dw $F653, $0001 ; batta3 (crateria grey walking pirate)
dw $F353, $0002 ; batta1 (crateria grey wall pirate)
dw $FFFF     ; end of list

; Room $975C state $976D: FX
org $83819E
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $FFFF, $FFFF, $0000 : db $00, $0C, $02, $30, $00, $00, $00, $62

; Room $975C state $9787: FX
org $838080
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $FFFF, $FFFF, $0000 : db $00, $00, $02, $02, $00, $00, $00, $00
