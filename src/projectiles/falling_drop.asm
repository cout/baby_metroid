%BEGIN_FREESPACE(86)

falling_drop:
; dw $EF29  ; init
dw init_falling_drop
dw $EFE0  ; pre-instruction
dw $ED8D  ; instruction list
dw $1010  ; y/x radius
dw $3000  ; properties
dw $84FC  ; hit instruction list
dw $84FC  ; shot instruction list

init_falling_drop:
{
  PHX
  PHY

  LDA $12    : STA $1A4B,y ; x pos
  LDA $14    : STA $1A93,y ; y pos
  LDA #$0000 : STA $19BB,y ; graphics index

  PHY
  JSL $808111
  AND #$0007
  TAY
  LDA .drop_type,y
  AND #$00FF
  PLY

  JMP $EF45

.drop_type:
  ; TODO - make the drop types configurable by the caller
  db $01, $01, $02, $02, $04, $04, $04, $05
}

%END_FREESPACE(86)
; vim:ft=pic
