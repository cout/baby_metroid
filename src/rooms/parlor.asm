; Room $92FD: Header
org $8F92FD
db $02       ; Index
db $00       ; Area
db $12       ; X position on map
db $04       ; Y position on map
db $05       ; Width (in screens)
db $05       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $9362     ; Door out
dw $E612     ; State $9348 function (event)
db $0E       ; Event
dw $9348     ; State header address
dw $E612     ; State $932E function (event)
db $00       ; Event
dw $932E     ; State header address
dw $E5E6     ; State $9314 function (default)

; Room $92FD state $9314: Header
; (default)
org $8F9314
dl $C2DBC4   ; Level data address
db $00       ; Tileset
db $00       ; Music data index
db $00       ; Music track index
dw $80F0     ; FX address (bank $83)
dw $86FA     ; Enemy population offset (bank $A1)
dw $8185     ; Enemy graphics set offset (bank $B4)
dw $C1C1     ; Layer 2 scroll
dw $9370     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $805A     ; Room PLM list address (bank $8F)
dw $B8B4     ; Library background (bank $8F)
dw $91D3     ; Room setup routine (bank $8F)

; Room $92FD state $932E: Header
; (event bit 00h)
org $8F932E
dl $C2DBC4   ; Level data address
db $00       ; Tileset
db $09       ; Music data index
db $05       ; Music track index
dw $8050     ; FX address (bank $83)
dw $8261     ; Enemy population offset (bank $A1)
dw $8067     ; Enemy graphics set offset (bank $B4)
dw $C1C1     ; Layer 2 scroll
dw $9370     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $805A     ; Room PLM list address (bank $8F)
dw $B8B4     ; Library background (bank $8F)
dw $91BC     ; Room setup routine (bank $8F)

; Room $92FD state $9348: Header
; (event bit 0eh)
org $8F9348
dl $C2DBC4   ; Level data address
db $00       ; Tileset
db $00       ; Music data index
db $00       ; Music track index
dw $8010     ; FX address (bank $83)
dw $8DA0     ; Enemy population offset (bank $A1)
dw $8295     ; Enemy graphics set offset (bank $B4)
dw $C1C1     ; Layer 2 scroll
dw $9370     ; Room scroll data (bank $8F)
dw $0000     ; Room var
; dw $C124     ; Room main routine (bank $8F)
dw parlor_escape_main
dw $8104     ; Room PLM list address (bank $8F)
dw $B8B4     ; Library background (bank $8F)
; dw $9194     ; Room setup routine (bank $8F)
dw parlor_escape_setup

; Room $92FD state $9314: Enemy population
org $A186FA
;  enemy  x      y      init   props  extra  param1 param2
dw $D87F, $04BE, $00C0, $0000, $2400, $0000, $AA02, $0050 ; sbug
dw $D87F, $04A4, $00C9, $0000, $2400, $0000, $B502, $0050 ; sbug
dw $D87F, $04BB, $00CF, $0000, $2400, $0000, $D003, $0050 ; sbug
dw $D87F, $04E4, $0041, $0000, $2400, $0000, $4804, $0080 ; sbug
dw $D87F, $0455, $002A, $0000, $2400, $0000, $6003, $00A0 ; sbug
dw $D87F, $043F, $002E, $0000, $2400, $0000, $6C03, $00A0 ; sbug
dw $D87F, $046F, $0027, $0000, $2400, $0000, $7802, $00A0 ; sbug
dw $D87F, $03D8, $00C3, $0000, $2400, $0000, $CA03, $0050 ; sbug
dw $D87F, $03D2, $00C9, $0000, $2400, $0000, $C803, $0050 ; sbug
dw $D87F, $03DB, $00CE, $0000, $2400, $0000, $E202, $0050 ; sbug
dw $D87F, $011B, $00BC, $0000, $2400, $0000, $A002, $0050 ; sbug
dw $D87F, $0112, $00C4, $0000, $2400, $0000, $AB02, $0050 ; sbug
dw $D87F, $012C, $0229, $0000, $2400, $0000, $7C03, $0080 ; sbug
dw $D87F, $0124, $022D, $0000, $2400, $0000, $9403, $0080 ; sbug
dw $D87F, $0143, $023F, $0000, $2400, $0000, $8402, $0080 ; sbug
dw $D87F, $013F, $02BF, $0000, $2400, $0000, $A102, $0040 ; sbug
dw $D87F, $0145, $02BA, $0000, $2400, $0000, $9103, $0040 ; sbug
dw $D87F, $013D, $02C3, $0000, $2400, $0000, $8C02, $0040 ; sbug
dw $D87F, $010D, $02DB, $0000, $2400, $0000, $AC03, $0080 ; sbug
dw $D87F, $01A5, $04E0, $0000, $2400, $0000, $E804, $0020 ; sbug
dw $FFFF     ; end of list
db $00       ; death quota

; Room $92FD state $932E: Enemy population
org $A18261
;  enemy  x      y      init   props  extra  param1 param2
dw $DCFF, $0498, $0040, $0002, $2801, $0000, $0001, $0000 ; zoomer
dw $DCFF, $041F, $0088, $0003, $2801, $0000, $0001, $0000 ; zoomer
dw $DCFF, $0448, $00B8, $0003, $2001, $0000, $0001, $0000 ; zoomer
dw $DB7F, $02FE, $003B, $0000, $2000, $0000, $0000, $0000 ; skree
dw $DB7F, $02BE, $005B, $0000, $2000, $0000, $0000, $0000 ; skree
dw $DB7F, $027E, $003B, $0000, $2000, $0000, $0000, $0000 ; skree
dw $DCFF, $01A0, $0178, $0003, $2001, $0000, $0001, $0000 ; zoomer
dw $D47F, $01B8, $0228, $0000, $2000, $0000, $0010, $0000 ; ripper
dw $DCFF, $0128, $0438, $0000, $2003, $0000, $0001, $0000 ; zoomer
dw $DCFF, $01D4, $0438, $0003, $2000, $0000, $0001, $0000 ; zoomer
dw $DCFF, $0180, $0408, $0003, $2001, $0000, $0001, $0000 ; zoomer
dw $DCFF, $0168, $0328, $0000, $2002, $0000, $0001, $0000 ; zoomer
dw $DCFF, $01EA, $02EA, $0001, $2003, $0000, $0001, $0000 ; zoomer
dw $DCFF, $01C8, $0278, $0003, $2001, $0000, $0001, $0000 ; zoomer
dw $DCFF, $0181, $0115, $0002, $2001, $0000, $0001, $0000 ; zoomer
dw $D47F, $03AD, $01E8, $0000, $2000, $0000, $0010, $0000 ; ripper
dw $FFFF     ; end of list
db $10       ; death quota

; Room $92FD state $9348: Enemy population
org $A18DA0
;  enemy  x      y      init   props  extra  param1 param2
dw $E1FF, $0145, $00B5, $0000, $2000, $0000, $0000, $0000 ; ceres steam
dw $E1FF, $01B9, $00BA, $0000, $2000, $0000, $0000, $0000 ; ceres steam
dw $E1FF, $01DE, $00A9, $0000, $2000, $0000, $0000, $0000 ; ceres steam
dw $E1FF, $0227, $00B1, $0000, $2000, $0000, $0000, $0000 ; ceres steam
dw $E1FF, $023D, $00B9, $0000, $2000, $0000, $0000, $0000 ; ceres steam
dw $E1FF, $026F, $00C0, $0000, $2000, $0000, $0000, $0000 ; ceres steam
dw $E1FF, $02B1, $00D0, $0000, $2000, $0000, $0000, $0000 ; ceres steam
dw $E1FF, $02D1, $00C8, $0000, $2000, $0000, $0000, $0000 ; ceres steam
dw $E1FF, $030B, $00C0, $0000, $2000, $0000, $0000, $0000 ; ceres steam
dw $E1FF, $032F, $00A0, $0000, $2000, $0000, $0000, $0000 ; ceres steam
dw $E1FF, $035E, $0088, $0000, $2000, $0000, $0000, $0000 ; ceres steam
dw $E1FF, $0384, $0077, $0000, $2000, $0000, $0000, $0000 ; ceres steam
dw $E1FF, $03DC, $0079, $0000, $2000, $0000, $0000, $0000 ; ceres steam
dw $E1FF, $03FE, $008E, $0000, $2000, $0000, $0000, $0000 ; ceres steam
dw $E1FF, $041F, $00A1, $0000, $2000, $0000, $0000, $0000 ; ceres steam
dw $E1FF, $045C, $00C4, $0000, $2000, $0000, $0000, $0000 ; ceres steam
dw $E1FF, $047F, $00B3, $0000, $2000, $0000, $0000, $0000 ; ceres steam
dw $E1FF, $04AA, $00AE, $0000, $2000, $0000, $0000, $0000 ; ceres steam
dw $E1FF, $04CC, $00A6, $0000, $2000, $0000, $0000, $0000 ; ceres steam
dw $FFFF     ; end of list
db $00       ; death quota

; Room $92FD state $9314: Enemy graphics set
org $B48185
;  enemy  palette
dw $D87F, $0007 ; sbug
dw $FFFF     ; end of list

; Room $92FD state $932E: Enemy graphics set
org $B48067
;  enemy  palette
dw $DCFF, $0001 ; zoomer
dw $DB7F, $0002 ; skree
dw $D47F, $0003 ; ripper
dw $FFFF     ; end of list

; Room $92FD state $9348: Enemy graphics set
org $B48295
;  enemy  palette
dw $D87F, $0007 ; sbug
dw $FFFF     ; end of list

; Room $92FD state $9314: FX
org $8380F0
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $FFFF, $FFFF, $0000 : db $00, $00, $28, $02, $00, $00, $00, $62

; Room $92FD state $932E: FX
org $838050
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $FFFF, $FFFF, $0000 : db $00, $00, $02, $02, $00, $00, $00, $00

; Room $92FD state $9348: FX
org $838010
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
; dw $0000, $04E8, $0010, $FF98 : db $00, $00, $02, $02, $00, $42, $00, $00
dw $0000, $FFFF, $FFFF, $0000 : db $00, $00, $02, $02, $00, $00, $00, $00

org !FREESPACE_8F

parlor_escape_setup:
{
  ; ?
  JSL $8483D7
  dw  $0B3D, $BB30

  ; Time remaining for quake
  LDA #$0180
  STA $1840

  ; 3px horiz displacement full quake
  LDA #$0018
  STA $183E

  RTS
}

parlor_escape_main:
{
  LDA $1840
  CMP #$0100
  BPL .explosions

  CMP #$0080
  BPL .earthquake2

  CMP #$0040
  BPL .earthquake1

  CMP #$0001
  BPL .earthquake0

  ; Queue elevator music
  LDA #$0003
  JSL $808FC1

  LDA.w #parlor_escape_main_quiet
  STA $07DF

.earthquake0:
  ; No explosions
  BRA .return

.earthquake1:
  ; 1px horiz displacement full quake
  LDA #$0012
  STA $183E

  BRA .explosions

.earthquake2:
  ; 2px horiz displacement full quake
  LDA #$0015
  STA $183E

.explosions:
  ; Generate explosions
  JSR $C131

.return:
  RTS
}

parlor_escape_main_quiet:
{
  RTS
}

end_parlor_freespace_8F:
!FREESPACE_8F := end_parlor_freespace_8F
