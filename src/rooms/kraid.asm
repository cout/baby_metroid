org $C6D620
incbin "kraid.bin"
warnpc $C6DE20

; Room $A59F: Header
org $8FA59F
db $2F       ; Index
db $01       ; Area
db $37       ; X position on map
db $12       ; Y position on map
db $02       ; Width (in screens)
db $02       ; Height (in screens)
db $70       ; Up scroller
db $A0       ; Down scroller
db $05       ; Special graphics bits
dw $A5E5     ; Door out
dw $E629     ; State $A5CB function (boss)
db $01       ; Boss
dw $A5CB     ; State header address
dw $E5E6     ; State $A5B1 function (default)

; Room $A59F state $A5B1: Header
; (default)
org $8FA5B1
dl $C6D620   ; Level data address
db $1A       ; Tileset
db $27       ; Music data index
db $03       ; Music track index
dw $83F4     ; FX address (bank $83)
dw $9EB5     ; Enemy population offset (bank $A1)
dw $85EF     ; Enemy graphics set offset (bank $B4)
dw $0101     ; Layer 2 scroll
dw $A5E9     ; Room scroll data (bank $8F)
dw $0000     ; Room var
; dw $0000     ; Room main routine (bank $8F)
dw kraid_room_main_routine
dw $8A2E     ; Room PLM list address (bank $8F)
dw $B815     ; Library background (bank $8F)
dw $91D6     ; Room setup routine (bank $8F)

; Room $A59F state $A5CB: Header
; (boss bit 01h)
org $8FA5CB
dl $C6D620   ; Level data address
db $1A       ; Tileset
db $00       ; Music data index
db $00       ; Music track index
dw $83F4     ; FX address (bank $83)
dw $9EB5     ; Enemy population offset (bank $A1)
dw $85EF     ; Enemy graphics set offset (bank $B4)
dw $0101     ; Layer 2 scroll
dw $A5E9     ; Room scroll data (bank $8F)
dw $0000     ; Room var
dw $0000     ; Room main routine (bank $8F)
dw $8A2E     ; Room PLM list address (bank $8F)
dw $B840     ; Library background (bank $8F)
dw $91D6     ; Room setup routine (bank $8F)

; Room $A59F state $A5B1: Enemy population
; Room $A59F state $A5CB: Enemy population
org $A19EB5
;  enemy  x      y      init   props  extra  param1 param2
dw $E2BF, $0100, $0218, $0000, $0D00, $0004, $0000, $0000 ; kraid
dw $E2FF, $00E8, $01E8, $0000, $2800, $0004, $0000, $0001 ; kraid arm
dw $E33F, $00C8, $0210, $0000, $A800, $0000, $0000, $0000 ; kraid lint
dw $E37F, $00B0, $0250, $0000, $A800, $0000, $0000, $0001 ; kraid lint
dw $E3BF, $00B2, $0288, $0000, $A800, $0000, $0000, $0002 ; kraid lint
dw $E3FF, $0100, $0278, $0000, $2C00, $0004, $0000, $0003 ; kraid foot
dw $E43F, $00E8, $01E8, $0000, $6800, $0000, $0000, $0000 ; kraid fingernail
dw $E47F, $00E8, $01E8, $0000, $6800, $0000, $0000, $0000 ; kraid fingernail
dw $FFFF     ; end of list
db $00       ; death quota

; Room $A59F state $A5B1: Enemy graphics set
; Room $A59F state $A5CB: Enemy graphics set
org $B485EF
;  enemy  palette
dw $E2BF, $0007 ; kraid
dw $FFFF     ; end of list

%BEGIN_FREESPACE(8F)

kraid_room_main_routine:
{
  LDA $05B6
  BIT #$000F
  BNE .fall

.spawn:
  JSL $808111
  AND #$0030
  CLC
  ADC #$0070
  STA $12

  LDA #$0100
  STA $14

  LDA.w #falling_drop : TAY
  ; TODO: X=enemy index
  LDA #$0000
  JSL $868027

.fall:
  LDY #$0022

.loop:
  LDA $1997,y
  BEQ .next

  LDA $1A93,y
  INC
  STA $1A93,y

  CMP #$0180
  BMI .next
  LDA #$0000
  STA $1997,y

.next:
  DEY : DEY
  BPL .loop

.return:
  RTS
}

%END_FREESPACE(8F)

; vim:ft=pic
