org !FREESPACE_86

transporter_electricity:

dw transporter_electricity_init ; init ai
dw transporter_electricity_main ; pre-instruction
dw $E683                        ; instruction list
dw $00                          ; x radius
dw $00                          ; y radius
dw $3000                        ; properties
dw $0000                        ; hit instruction list
dw $84FC                        ; shot instruction list

transporter_electricity_init:
{
  RTS
}

transporter_electricity_main:
{
  ; Move the electricity with Samus
  LDA $0AF6 : STA $1A4B,x
  LDA $0AFA : STA $1A93,x

  RTS
}

ceres_freespace_86_end:
!FREESPACE_86 := ceres_freespace_86_end
