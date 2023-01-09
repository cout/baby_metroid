org !FREESPACE_A0

baby_top:

dw $0C00                  ; tile data size
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
dl #$B18400               ; tile data
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
  LDA #$F683 : STA $7E781E,x                     ; Enemy palette function = $F683 (normal)
  ; LDA.w #baby_null_palette_function
  ; STA $7E781E,x

  RTL
}

baby_top_main:
{
  LDX $0E54

  ; TODO - palette change routine needs to use correct palette instead
  ; of assuming 7
  ; JSR baby_top_change_palette

  RTL
}

baby_top_change_palette:
{
  LDA #$01EA             ;\
  STA $12                ;} $12 = 1EAh (sprite palette 7 colour 5)
  LDA #$F6D1             ;\
  STA $16                ;} $16 = $F6D1

  LDX $0E54            
  SEP #$20
  LDA $0FAF,x            ;\
  BEQ .f6aa              ;} If [enemy palette handler timer] != 0:
  DEC A                  ;\
  STA $0FAF,x            ;} Decrement enemy palette handler timer
  REP #$20
  RTS                    ; Return

.f6aa:
  LDA $0FB0,x            ;\
  STA $0FAF,x            ;} Enemy palette handler timer = [enemy palette handler delay]
  LDA $0FAE,x            ;\
  INC A                  ;|
  AND #$07               ;} Enemy palette frame timer = ([enemy palette frame timer] + 1) % 8
  STA $0FAE,x            ;/
  REP #$20
  AND #$00FF
  JSR $F751              ; Handle Shitroid cry sound effect
  ASL A                  ;\
  ASL A                  ;|
  ASL A                  ;|
  ADC $16                ;|
  TAY                    ;} Write 4 colours from [$16] + [enemy palette frame timer] * 8 to colour index [$12]
  LDX $12                ;|
  LDA #$0004             ;|
  JSL $A9D2E4            ;/

  RTS
}

baby_top_instruction_list:
{
.top:
  dw $0010, baby_top_spritemap
  ; dw $0010, $F9A8 ; claws in - metroid bottom
  ; dw $0010, $FA40 ; claws down - metroid top
  ; dw $0010, $FAD8 ; claws out - OK
  ; dw $0010, $FA40 ; claws down
  dw $80ED, .top
}

baby_top_spritemap:
{
.top:
  dw ((.bottom-.top)/5)

  ;  s xxx       yy       pfnn
  dw $0018 : db $E0 : dw $6131
  dw $C218 : db $E8 : dw $6140
  dw $C208 : db $E8 : dw $6142
  dw $C208 : db $D8 : dw $6122
  dw $C200 : db $D8 : dw $6123
  dw $C200 : db $E8 : dw $6143
  dw $C3F0 : db $E8 : dw $2143
  dw $C3F0 : db $D8 : dw $2123
  dw $01E0 : db $E0 : dw $2131
  dw $C3D8 : db $E8 : dw $2140
  dw $C3E8 : db $E8 : dw $2142
  dw $C3E8 : db $D8 : dw $2122
.bottom:
}

end_baby_top_freespace_a9:
!FREESPACE_A9 := end_baby_top_freespace_a9
