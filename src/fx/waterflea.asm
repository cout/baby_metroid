!WATERFLEA_FX_INDEX = $16

org !FREEMEM_7F

waterflea_color_factor:
print "Variable waterflea_color_factor: $", pc
skip 2

waterflea_color_offset:
print "Variable waterflea_color_offset: $", pc
skip 2

waterflea_saved_palette:
print "Variable waterflea_saved_palette: $", pc
skip $20

end_waterflea_freemem_7f:
!FREEMEM_7F := end_waterflea_freemem_7f

org $7E1778

org $83ABF0
fx_type_tilemap_table:
skip !WATERFLEA_FX_INDEX
dw $9080 ; water

org $83AC18
fx_type_function_table:
skip !WATERFLEA_FX_INDEX
dw waterflea_fx_init

org !FREESPACE_88

waterflea_fx_init:
{
  ; FX rising function
  LDA #$C428
  STA $196C

  ; FX Y position = [FX base Y position]
  LDA $1978
  STA $195E

  ; Spawn indirect HDMA object for BG3 X scroll
  JSL $888435
  ; dw $1142, $D856
  dw $1142, waterflea_bg3_x_scroll

  ; TODO - for wavy water (liquid options & 2 != 0), there is another
  ; HDMA object that should be spawned

.spawn_bg3_scroll:
  JSL $88D865            ; Spawn BG3 scroll HDMA object

  JSR waterflea_save_palette

  JSR waterflea_init_fireflea_lighting

  RTL
}

waterflea_bg3_x_scroll:
{
  ; water
  dw $8655 : db $88     ; HDMA table bank = $88
  dw $866A : db $7E     ; Indirect HDMA data bank = $7E
  dw $C467              ; HDMA object $1920 = 1
  ; dw $8570 : dl $88C48E ; Pre-instruction = $88:C48E
  dw $8570 : dl waterflea_pre_instruction

  dw $8682              ; Sleep

  ; fireflea
  dw $8655 : db $7E     ; HDMA table bank = $7E
  dw $8570 : dl $88B0BC ; Pre-instruction = $88:B0BC
.loop:
  dw $0001, $9E00       ;
  dw $85EC, .loop       ; Goto
}

waterflea_pre_instruction:
{
  ; Do water effects
  JSL $88C48E

  ; Do fireflea effects
  JSR waterflea_do_fireflea_lighting

  RTL
}

!waterflea_lighting_change_timer = $1778

waterflea_init_fireflea_lighting:
{
  LDA #$0006 : STA $1778
  STZ $177A
  LDA #$0000 : STA $7E9E00
  STZ $177C
  STZ $177E
  LDA #$0018 : STA $1780
  LDA $88B058 : STA $1782

  RTS
}

waterflea_do_fireflea_lighting:
{
  ; If X-ray is active: return
  LDA $0A78
  BNE .return

  DEC !waterflea_lighting_change_timer
  BNE .apply_effect

  LDA #$0006
  STA !waterflea_lighting_change_timer

  LDA $177E : CMP #$000A : BMI .increment     ; If $177E < Ah: go to .increment
  LDA #$0006 : BRA .store                     ; A = 6  and goto .store

.increment:
  LDA $177A : INC A : CMP #$000C : BCC .store ; If $177A + 1 < Ch: go to .store
  LDA #$0000                                  ; A = 0

.store:
  STA $177A

.apply_effect:
  LDA $177A : ASL A : TAX : LDA $88B058,x     ; A = [$88:B058 + [$177A]*2]
  LDX $177E : CLC : ADC $88B070,x             ; A += [$88:B070 + [$177E]

  ; swap B and A
  XBA

  ; TODO - color changes are handled by modifying the base palette, i.e.
  ; the palette that was in effect when the room was loaded.  I think it
  ; should be possible to instead do the color changes with HDMA, and it
  ; would be a neat effect (so we get darkness above the water but under
  ; the water is lit up)
  JSR waterflea_adjust_palette

.return:
  RTS
}

waterflea_save_palette:
{
  LDA #$0018
.loop:
  TAX

  LDA $7EC280,x
  STA waterflea_saved_palette,x

  TXA
  DEC
  DEC
  BPL .loop

  RTS
}

waterflea_adjust_palette:
{
  STA waterflea_color_factor

  STA $12
  ASL : ASL : ASL : ASL : ASL
  STA $14
  ASL : ASL : ASL : ASL : ASL
  STA $16

  LDA #$0018
.loop:
  TAX

  LDA waterflea_saved_palette,x
  AND #$001F
  SEC
  SBC $12
  BPL +
  LDA #$0000
+ STA $20

  LDA waterflea_saved_palette,x
  AND #$03E0
  SEC
  SBC $14
  BPL +
  LDA #$0000
+ ORA $20
  STA $20

  LDA waterflea_saved_palette,x
  AND #$7C00
  SEC
  SBC $16
  BPL +
  LDA #$0000
+ ORA $20

  STA $7EC080,x

  TXA
  DEC
  DEC
  BPL .loop

  RTS
}

end_waterflea_freespace_88:
!FREESPACE_88 := end_waterflea_freespace_88
