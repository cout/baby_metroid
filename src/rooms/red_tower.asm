org $C684EE
incbin "red_tower.bin"
org $C691E3

; Room $A253: Header
org $8FA253
db $20       ; Index
db $01       ; Area
db $21       ; X position on map
db $09       ; Y position on map
db $01       ; Width (in screens)
db $0A       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $00       ; Special graphics bits
dw $A27A     ; Door out
dw $E5E6     ; State $A260 function (default)

; Room $A253 state $A260: Header
; (default)
org $8FA260
dl $C684EE   ; Level data address
db $07       ; Tileset
db $12       ; Music data index
db $05       ; Music track index
dw $834E     ; FX address (bank $83)
dw $9452     ; Enemy population offset (bank $A1)
dw $83F1     ; Enemy graphics set offset (bank $B4)
dw $C1C1     ; Layer 2 scroll
dw $A284     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
; dw $8854     ; Room PLM list address (bank $8F)
dw red_tower_room_plm_list
dw $BB7B     ; Library background (bank $8F)
dw $91D6     ; Room setup routine (bank $8F)

; Room $A253 state $A260: Enemy population
org $A19452
;  enemy  x      y      init   props  extra  param1 param2
dw $D47F, $0098, $0208, $0000, $2000, $0000, $0010, $0000 ; ripper
dw $D47F, $0060, $00E8, $0000, $2000, $0000, $0010, $0001 ; ripper
dw $D47F, $0098, $0140, $0000, $2000, $0000, $0010, $0000 ; ripper
dw $D47F, $0068, $01A0, $0000, $2000, $0000, $0010, $0001 ; ripper
dw $E87F, $00CF, $0658, $0000, $2000, $0000, $0000, $0000 ; beetom
dw $D47F, $0098, $0948, $0000, $2000, $0000, $0010, $0000 ; ripper
dw $D47F, $005F, $08E8, $0000, $2000, $0000, $0010, $0001 ; ripper
dw $D47F, $009D, $0888, $0000, $2000, $0000, $0010, $0000 ; ripper
dw $D47F, $0068, $0800, $0000, $2000, $0000, $0010, $0001 ; ripper
; dw $F253, $0018, $0530, $0000, $6100, $0000, $0000, $0020 ; geega
; dw $F253, $00C8, $0550, $0000, $6100, $0000, $0001, $0020 ; geega
dw !samus_statue, $0078, $099C, $0000, $2400, $0000, test_samus_has_speed, $0205
dw $FFFF     ; end of list
db $0B       ; death quota

; Room $A253 state $A260: Enemy graphics set
org $B483F1
;  enemy  palette
dw $D47F, $0001 ; ripper
dw $E87F, $0002 ; beetom
; dw $F253, $0003 ; geega
dw !samus_statue, $0003
dw $FFFF     ; end of list

; Room $A253 state $A260: FX
org $83834E
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
dw $0000, $FFFF, $FFFF, $0000 : db $00, $00, $02, $02, $00, $06, $03, $00

org !FREESPACE_8F

red_tower_room_plm_list:
{
  dw $B703, $6A09, $A28E
  dw $B63B, $6A0A, $8000
  dw $C878, $9601, $0038
  dw $C860, $6601, $0039
  dw $B703, $6A07, $A28E ; new scroll plm
  dw $B703, $6A08, $A28E ; new scroll plm
  dw $0000
}

end_red_tower_freespace_8f:
!FREESPACE_8F := end_red_tower_freespace_8f
