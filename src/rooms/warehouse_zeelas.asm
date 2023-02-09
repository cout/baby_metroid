; Room $A471: Header
org $8FA471
db $2A       ; Index
db $01       ; Area
db $2C       ; X position on map
db $12       ; Y position on map
db $02       ; Width (in screens)
db $02       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $A498     ; Door out
dw $E5E6     ; State $A47E function (default)

; Room $A471 state $A47E: Header
; (default)
org $8FA47E
dl $C6BD83   ; Level data address
db $07       ; Tileset
db $00       ; Music data index
db $05       ; Music track index
dw $83D2     ; FX address (bank $83)
; dw $941F     ; Enemy population offset (bank $A1)
; dw $83E3     ; Enemy graphics set offset (bank $B4)
dw warehouse_zeelas_enemy_population
dw warehouse_zeelas_enemy_graphics_set
dw $00C0     ; Layer 2 scroll
dw $A49E     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $8976     ; Room PLM list address (bank $8F)
dw $0000     ; Library background (bank $8F)
dw $91D6     ; Room setup routine (bank $8F)

; Room $A471 state $A47E: FX
org $8383D2
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $FFFF, $FFFF, $0000 : db $00, $00, $02, $02, $00, $04, $00, $00

%BEGIN_FREESPACE(A1)

warehouse_zeelas_enemy_population:
; Room $A471 state $A47E: Enemy population
; org $A1941F
;  enemy  x      y      init   props  extra  param1 param2
dw $DC7F, $006A, $0040, $0001, $2800, $0000, $0002, $0002 ; zeela
dw $DC7F, $006A, $0068, $0001, $2800, $0000, $0002, $0002 ; zeela
dw $DC7F, $002B, $00E8, $0003, $2800, $0000, $0002, $0002 ; zeela
dw !samus_statue, $002A, $00A0, $0000, $2400, $0000, $0000, $0205 ; statue
dw $FFFF     ; end of list
db $03       ; death quota

%END_FREESPACE(A1)

%BEGIN_FREESPACE(B4)

warehouse_zeelas_enemy_graphics_set:
; Room $A471 state $A47E: Enemy graphics set
; org $B483E3
;  enemy  palette
dw $DC7F, $0001 ; zeela
dw !samus_statue, $0002 ; statue
dw $FFFF     ; end of list

%END_FREESPACE(B4)
