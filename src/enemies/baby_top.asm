org !FREESPACE_A0

baby_top:

; TODO - when the gunship takes off, the steam overwrites the baby's memory (because it is in enemy slot 0).
;
dw $0380                  ; tile data size
dw #$F8E6                 ; palette
dw #$0C80                 ; health
dw #$0028                 ; damage
dw #$0028                 ; x radius
dw #$0028                 ; y radius
db $A9                    ; bank
db $00                    ; hurt ai time
dw $0000                  ; cry
dw $0000                  ; boss value
dw baby_top_init          ; init
dw $0001                  ; number of parts
dw $0000                  ; unused
dw baby_top_main          ; main
dw $800F                  ; grapple ai routine
dw $804C                  ; hurt ai routine
dw $8041                  ; frozen ai routine
dw $0000                  ; time is frozen ai routine
dw $0000                  ; death animation
dd $00000000              ; unused
dw #$EFBA                 ; power bomb reaction
dw $0000                  ; unknown
dd $00000000              ; unused
dw #$F789                 ; touch routine
dw #$F842                 ; shot routine
dw $0000                  ; unknown
; dl #$B18400               ; tile data
dl baby_top_tiles
db $02                    ; layer
dw $F3F2                  ; drop chances
dw $F12E                  ; vulnerabilities
dw $0000                  ; enemy name

!baby_top = baby_top

end_baby_top_freespace_a0:
!FREESPACE_A0 := end_baby_top_freespace_a0

org !FREESPACE_A9

; TODO: we shouldn't manually change $0F86; it should be set in the
; enemy population like other enemies
baby_top_init:
{
  LDX $0E54
  LDA $0F86,x : ORA #$3000 : STA $0F86,x         ; process instructions and block plasma
  LDA.w #baby_top_instruction_list : STA $0F92,x ; instruction pointer
  LDA #$0001 : STA $0F94,x                       ; instruction timer
  STA $7E7808,x                                  ; Enable cry sound effect
  STZ $0F90,x                                    ; Enemy timer = 0
  LDA #$000A : STA $0FB0,x                       ; Enemy palette handler delay = Ah
  STZ $0FAA,x                                    ; Enemy X velocity = 0
  STZ $0FAC,x                                    ; Enemy Y velocity = 0
  LDA #$00F8 : STA $0FB2,x                       ; Enemy function timer = F8h

  RTL
}

baby_top_main:
{
  JSR baby_top_change_palette
  JSR baby_move_with_ship

  RTL
}

baby_top_change_palette:
{
  LDX $0E54

  ; TODO - I'm prety sure this is not the right way to convert to an
  ; offset from palette index to offset from 7EC000:
  LDA $0F96,x
  CLC
  ADC #$010A
  STA $12

  ; Base palette (normal baby colors)
  LDA #$F6D1
  STA $16

  ; Decrement timer and return if nonzero
  SEP #$20
  LDA $0FAF,x
  BEQ .f6aa
  DEC A
  STA $0FAF,x
  REP #$20
  RTS

.f6aa:
  ; Reset timer
  LDA $0FB0,x
  STA $0FAF,x
  LDA $0FAE,x
  INC A
  AND #$07
  STA $0FAE,x
  REP #$20
  AND #$00FF

  ; Play cry sound
  JSR $F751

  ASL A
  ASL A
  ASL A
  ADC $16
  TAY
  LDX $12
  LDA #$0004
  JSL $A9D2E4

  RTS
}

baby_move_with_ship:
{
  LDA $0E54
  TAX

  LDA $0EBA,x
  STA $0F7A,x

  LDA $0EBE,x
  ; SEC
  ; SBC #$0018
  STA $0F7E,x

  RTS
}

baby_top_instruction_list:
{
.top:
  dw $0010, baby_top_spritemap
  dw $80ED, .top
}

baby_top_spritemap:
{
.top:
  dw ((.bottom-.top)/5)

  ;  s xxx       yy       pfnn
  dw $0018 : db $E0 : dw $610F ; left
  dw $C218 : db $E8 : dw $6106 ; bot 0
  dw $C208 : db $E8 : dw $6108 ; bot 1
  dw $C208 : db $D8 : dw $6100 ; top 0

  dw $C200 : db $D8 : dw $6101 ; top 1
  dw $C200 : db $E8 : dw $6109 ; bot 2
  dw $C3F0 : db $E8 : dw $2109 ; bot 3
  dw $C3F0 : db $D8 : dw $2101 ; top 2

  dw $01E0 : db $E0 : dw $210F ; right
  dw $C3D8 : db $E8 : dw $2106 ; bot 5
  dw $C3E8 : db $E8 : dw $2108 ; bot 4
  dw $C3E8 : db $D8 : dw $2100 ; top 3

.bottom:
}

end_baby_top_freespace_a9:
!FREESPACE_A9 := end_baby_top_freespace_a9

org !FREESPACE_B8

; TODO - there are some unused tiles here (indicated by 'x'), but I don't think I can remove them and still use 16x16 tiles in the spritemap.
baby_top_tiles:
{
  ; db $30,$80,$70,$C0, $58,$C0,$98,$C0, $68,$60,$0C,$00, $C6,$00,$7E,$00, $60,$F0,$20,$F0, $A0,$F8,$30,$F8, $90,$F8,$F8,$FC, $7C,$FE,$18,$7E ; x
  ; db $B6,$30,$DE,$18, $66,$00,$3F,$00, $0F,$00,$07,$00, $00,$00,$00,$00, $C8,$FE,$64,$FE, $3C,$7E,$1E,$3F, $02,$0F,$00,$07, $00,$00,$00,$00 ; x
  db $00,$00,$00,$00, $00,$00,$00,$00, $03,$03,$08,$0F, $37,$38,$5C,$63, $00,$00,$00,$00, $00,$00,$01,$00, $04,$00,$10,$00, $40,$00,$80,$00
  db $00,$00,$00,$00, $1E,$1F,$E1,$FE, $BE,$C1,$E0,$1F, $3C,$FC,$E0,$E0, $00,$00,$07,$00, $60,$00,$00,$00, $00,$00,$00,$00, $03,$00,$1F,$00
  db $00,$00,$FF,$FF, $00,$FF,$FF,$00, $1F,$FF,$E0,$E0, $1F,$1F,$C7,$F8, $3F,$00,$00,$00, $00,$00,$00,$00, $00,$00,$1F,$00, $E0,$00,$00,$00
  db $2A,$37,$49,$77, $53,$6F,$5B,$67, $53,$6F,$5A,$66, $53,$6F,$5A,$66, $40,$00,$00,$00, $00,$00,$00,$00, $00,$00,$01,$00, $00,$00,$01,$00
  db $CA,$0D,$E0,$C0, $E0,$C0,$D0,$F0, $30,$00,$98,$8B, $08,$14,$80,$86, $30,$00,$1F,$00, $10,$00,$08,$00, $CC,$00,$64,$00, $E3,$00,$71,$00
  db $00,$00,$00,$00, $0C,$00,$2F,$63, $24,$87,$3B,$0C, $D3,$1C,$D8,$1F, $C0,$00,$80,$00, $00,$0F,$03,$0C, $47,$28,$8F,$30, $1F,$E0,$1F,$E0

  db $00,$00,$01,$01, $00,$01,$02,$03, $03,$02,$05,$06, $05,$06,$0B,$0C, $01,$00,$02,$00, $02,$00,$04,$00, $04,$00,$08,$00, $08,$00,$10,$00
  db $B9,$CD,$7E,$86, $EF,$10,$CA,$3A, $BC,$7C,$BA,$7A, $74,$F4,$68,$E8, $02,$00,$01,$00, $00,$00,$05,$00, $03,$00,$05,$00, $0B,$00,$17,$00
  db $00,$04,$81,$9B, $38,$01,$78,$88, $0D,$07,$0B,$03, $02,$03,$3E,$0F, $F0,$00,$60,$00, $C0,$1C,$08,$37, $C7,$08,$C3,$0C, $03,$04,$0F,$30
  db $00,$00,$00,$00, $00,$00,$18,$98, $70,$70,$00,$60, $C8,$28,$1D,$F8, $00,$08,$00,$08, $00,$58,$18,$60, $10,$88,$60,$98, $E8,$10,$F8,$05
  db $0C,$0C,$03,$07, $04,$07,$05,$06, $0D,$06,$46,$4F, $9E,$93,$09,$01, $4C,$00,$27,$00, $07,$00,$07,$80, $07,$48,$4F,$20, $93,$2C,$01,$0E
  db $1C,$13,$16,$19, $06,$09,$03,$0C, $0B,$0C,$03,$04, $05,$06,$01,$02, $20,$00,$00,$00, $10,$00,$10,$00, $00,$00,$08,$00, $08,$00,$04,$00 ; x
  db $D5,$D5,$AB,$AB, $57,$D7,$6C,$EF, $39,$FE,$13,$FC, $86,$79,$CC,$33, $2A,$00,$54,$00, $28,$00,$10,$00, $00,$00,$00,$00, $00,$00,$00,$00 ; x
  db $75,$7F,$C0,$FF, $1F,$E0,$30,$CF, $EF,$1F,$13,$F0, $5D,$C0,$9D,$96, $80,$00,$00,$00, $00,$00,$00,$00, $00,$00,$0C,$03, $27,$1F,$69,$3F ; x

  db $CC,$00,$EC,$00, $3E,$00,$1E,$00, $00,$00,$00,$00, $00,$00,$00,$00, $F0,$FC,$38,$FC, $18,$3E,$00,$1E, $00,$00,$00,$00, $00,$00,$00,$00
  db $00,$00,$02,$03, $05,$06,$0B,$0C, $16,$19,$2C,$33, $58,$67,$70,$4E, $03,$00,$04,$00, $08,$00,$10,$00, $20,$00,$40,$00, $00,$00,$81,$00
  db $B3,$CF,$77,$8F, $BC,$6C,$1C,$F4, $35,$F1,$76,$F1, $C4,$C2,$C4,$C0, $00,$00,$00,$00, $03,$00,$03,$00, $0A,$00,$08,$00, $38,$00,$38,$00
  db $02,$03,$09,$0E, $3F,$3F,$80,$80, $80,$80,$00,$00, $00,$00,$00,$00, $FC,$00,$F0,$00, $C0,$00,$7F,$00, $7E,$00,$DC,$00, $0E,$00,$0B,$00
  db $7F,$80,$C0,$3F, $C0,$C0,$00,$00, $00,$00,$00,$00, $00,$00,$0A,$0A, $00,$00,$00,$00, $3F,$00,$FF,$00, $00,$00,$00,$00, $80,$12,$4A,$00
  db $53,$6F,$1A,$26, $13,$2F,$3A,$26, $31,$2F,$29,$37, $0D,$13,$0D,$13, $00,$00,$41,$00, $40,$00,$41,$00, $40,$00,$00,$00, $20,$00,$20,$00
  db $01,$02,$81,$82, $40,$44,$80,$84, $04,$04,$82,$82, $40,$40,$AA,$AA, $E4,$01,$70,$01, $A2,$01,$70,$01, $F8,$01,$7C,$01, $BF,$00,$55,$00
  db $83,$C3,$4D,$8D, $52,$DE,$D2,$DE, $CC,$CC,$42,$42, $15,$15,$AA,$AA, $C3,$3C,$CD,$32, $DE,$21,$DE,$21, $CC,$33,$5D,$A0, $2A,$C0,$55,$00

  db $0A,$0D,$12,$1D, $14,$1B,$1D,$13, $2C,$33,$2F,$30, $29,$36,$29,$36, $10,$00,$20,$00, $20,$00,$20,$00, $00,$00,$40,$00, $40,$00,$40,$00
  db $70,$F0,$E9,$E8, $D0,$D0,$E0,$E0, $D1,$D0,$60,$E0, $F0,$C0,$F0,$39, $0E,$00,$14,$01, $2C,$00,$1C,$00, $2C,$01,$1C,$00, $0F,$00,$06,$00
  db $C2,$02,$2D,$01, $23,$01,$CB,$09, $0B,$0A,$0B,$10, $0C,$20,$B0,$60, $02,$FD,$01,$2E, $01,$22,$01,$C2, $02,$05,$00,$0F, $00,$0C,$00,$10
  db $61,$64,$01,$21, $2A,$A6,$D8,$90, $9C,$00,$34,$20, $2E,$02,$6D,$01, $64,$9B,$21,$DE, $A6,$59,$90,$6F, $00,$BF,$20,$17, $02,$2D,$01,$6E
  db $CF,$0F,$57,$19, $2B,$37,$2D,$3E, $CB,$CC,$4D,$4E, $87,$87,$33,$33, $0F,$F0,$1F,$E0, $3F,$C0,$3F,$C0, $CF,$30,$4F,$B0, $87,$78,$33,$CC
  ; db $02,$03,$01,$01, $00,$00,$00,$00, $00,$00,$00,$00, $00,$00,$00,$00, $04,$00,$02,$00, $03,$00,$01,$00, $00,$00,$00,$00, $00,$00,$00,$00 ; x
  ; db $F9,$07,$75,$8C, $2B,$D8,$97,$F0, $6E,$60,$BD,$21, $7A,$03,$3E,$07, $00,$00,$02,$01, $05,$03,$08,$07, $93,$0F,$46,$9F, $0C,$7F,$08,$3F ; x
  ; db $01,$37,$CD,$79, $FD,$11,$FE,$00, $1F,$00,$CF,$C0, $6F,$E0,$2B,$E0, $C8,$7F,$86,$FF, $0E,$FF,$E3,$FF, $F8,$FF,$3C,$FF, $1E,$FF,$1E,$FF ; x
}

end_baby_top_freespace_b8:
!FREESPACE_B8 := end_baby_top_freespace_b8
