;;
; Disable spore spawn cry -- we will queue sound manually based on
; projectile type.
;

org $A0DF4D

dw $0000

;;
; Palettes
;
; The color change order is reversed from normal

org $A5E359 ; initial palette
dw $3800, $36BA, $29F4, $0089, $0002, $3236, $1DB2, $0D0D, $04CB, $36FC, $19B2, $00CB, $0004, $36FC, $19B2, $00CB
%assertpc($A5E379)

org $A5E379 ; damage palettes
dw $3800, $2E78, $25D2, $0088, $0002, $2E14, $1990, $0D0C, $04CA, $32DA, $19B1, $00CB, $0024, $2EBC, $1593, $00CB
dw $3800, $2A55, $21B1, $0087, $0001, $25F2, $156F, $08EB, $04A9, $32B9, $1991, $04EA, $0024, $269D, $1173, $00AB
dw $3800, $2213, $1D8F, $0086, $0001, $21D0, $114D, $08EA, $04A8, $2E97, $1990, $04EA, $0044, $1E5D, $0D54, $00AB
dw $3800, $1DF1, $156D, $0466, $0001, $198F, $112B, $08C8, $04A7, $2E96, $158F, $08EA, $0045, $1A3E, $0D35, $008C
%assertpc($A5E3F9)

org $A5E3F9 ; death-sequence palettes
dw $3800, $2213, $1D8F, $0086, $0001, $21D0, $114D, $08EA, $04A8, $2E97, $1990, $04EA, $0044, $1E5D, $0D54, $00AB
dw $3800, $1DF1, $156D, $0466, $0001, $198F, $112B, $08C8, $04A7, $2E96, $158F, $08EA, $0045, $1A3E, $0D35, $008C
dw $3800, $15AF, $114B, $0465, $0001, $156D, $0D09, $08C7, $04A6, $2A74, $158E, $08EA, $0065, $11FE, $0916, $008C
dw $3800, $118C, $0D2A, $0464, $0000, $0D4B, $08E8, $04A6, $0485, $2A53, $156E, $0D09, $0065, $09DF, $04F6, $006C
dw $3800, $094A, $0908, $0463, $0000, $0929, $04C6, $04A5, $0484, $2631, $156D, $0D09, $0085, $019F, $00D7, $006C
dw $3800, $15EF, $156B, $00A5, $0063, $15AC, $0D49, $0907, $04C6, $36D6, $21D0, $114B, $00A6, $025F, $0137, $008D
dw $3800, $2A92, $21CC, $00C4, $0062, $260E, $15AA, $0D27, $04E5, $475A, $2E52, $198C, $00C6, $033F, $01B6, $008F
dw $0000, $3F57, $2E4D, $00E2, $0060, $3AB0, $220B, $1166, $0924, $57FF, $3AB5, $1DCE, $00E7, $03FF, $0216, $00B0
%assertpc($A5E4F9)

org $A5E4F9 ; level palette
dw $0000, $6318, $6318, $0089, $19B2, $0D0D, $0089, $0002, $04CB, $04CB, $092E, $0004, $3236, $29F4, $19B2, $0002
dw $0000, $6318, $6318, $0488, $19B0, $110B, $0488, $0001, $090B, $08EB, $092C, $0003, $3254, $25B1, $19F2, $0002
dw $0000, $6318, $6318, $08A6, $19AF, $150A, $0C86, $0000, $0D4A, $0D2A, $0D2B, $0002, $2E52, $1D8F, $1E32, $0002
dw $0000, $6318, $6318, $0CA5, $19AD, $1908, $1085, $0400, $118A, $114A, $0D29, $0001, $2E70, $194C, $1E72, $0002
dw $0000, $6318, $6318, $14C4, $1DAC, $2126, $18A4, $0C00, $19EA, $196A, $1147, $0001, $2A6F, $112A, $22B1, $0001
dw $2003, $6318, $6318, $18C3, $1DAA, $2524, $1CA3, $1000, $1E2A, $1D8A, $1145, $0000, $2A8D, $0CE7, $22F1, $0001
dw $2003, $6318, $6318, $1CE1, $1DA9, $2923, $24A1, $1400, $2269, $21C9, $1544, $0420, $268B, $04C5, $2731, $0000
%assertpc($A5E5D9)

org $A5E5D9 ; background palette
dw $3800, $19B2, $0D0D, $0089, $19B2, $0D0D, $0089, $0002, $04CB, $04CB, $092E, $0004, $7FFF, $7FFF, $19B2, $0002
dw $3800, $2190, $14EC, $0488, $198F, $110B, $0488, $0402, $090E, $08ED, $092E, $0424, $7FFF, $7FFF, $19D4, $0002
dw $3800, $2D8D, $1CEA, $0866, $1D6D, $10E9, $0486, $0421, $0971, $090E, $0D0E, $0425, $7FFF, $7FFF, $1A16, $0401
dw $3800, $356B, $24C9, $0C65, $1D4A, $14E7, $0885, $0821, $0DB4, $0D30, $0D0E, $0845, $7FFF, $7FFF, $1A38, $0401
dw $3800, $4169, $2CA7, $0C64, $2128, $14C6, $0C84, $0821, $0DF6, $0D72, $110E, $0C45, $7FFF, $7FFF, $1659, $0401
dw $3800, $4947, $3486, $1063, $2105, $18C4, $1083, $0C21, $1239, $1194, $110E, $1065, $7FFF, $7FFF, $167B, $0401
dw $3800, $5544, $3C84, $1441, $24E3, $18A2, $1081, $0C40, $129C, $11B5, $14EE, $1066, $7FFF, $7FFF, $16BD, $0800
%assertpc($A5E6B9)

;; Make spore spawn vulnerable to uncharged beam
;

org $B4F094

;  $80,$82,$82,$82,$80,$82,$82,$82,$82,$82,$82,$82, $82,$82,$80,$80,$80,$80,$80,$04,$80,$80
db $02,$82,$82,$82,$80,$82,$82,$82,$82,$82,$82,$82, $82,$82,$80,$80,$80,$80,$80,$04,$80,$80

%assertpc($B4F094+22)

;;
; Spore spawn instruction lists

org $A5E6C7
instruction_list_spore_spawn_alive:
{
  dw $E91C, $0000
  dw $0008, $EF61        ; mouth fully open
  dw $E8BA, $EB1B        ; start fight
  dw $812F               ; sleep
}
%assertpc($A5E6D5)

org $A5E6D5
instruction_list_spore_spawn_fight_started:
{
  dw $E82D, $0000, $0000 ; speed = 00h, angle delta = 0
  dw $E8BA, $EB52        ; set enemy function to $EB52
  dw $812F               ; sleep
}

; Prevent the mouth from closing
org $A5E729
instruction_list_spore_spawn_close_mouth:
{
  ; reset flag $801E to prevent a projectile from resetting the close
  ; sequence; if we don't do this, then the next projectile will not
  ; affect the palette (see $A5:ED98)
  ; TODO - do we need to do this since we don't want the mouth to close
  ; anyway?
  dw $E771

  dw $80ED, instruction_list_spore_spawn_fight_started
}
warnpc $A5E75F

;;
; Skip the descent into the room

org $A5EB1B ; spore spawn descent function
{
  LDX $0E54
  LDA #$0270
  STA $0F7E,x
  LDA instruction_list_spore_spawn_fight_started
  STA $0F92,x
  RTS
}
warnpc $A5EB52

;;
; Disable spore spawn movement reaction to being shot

; Disable updating spore spawn stalk segment positions.  This is called
; from multiple places, so we still need to RTS here, even if we skip
; calling this routine in $EB55.
org $A5EC49
RTS

; Skip setting X/Y position in spore spawn movement function.  This
; still sets the angle, which IIRC is required (TODO - verify that this
; is true).
; org $A5EB55
; JMP $EB8A
org $A5EB52
RTS

;;
; Disable spore spawn death explosions

org $A5E9B1

RTL

org $A5E9F5

RTL

;;
; Spore spawn hit with projectile

org $A5ED5A

BRL spore_spawn_projectile_check

spore_spawn_damage = $A5ED6D

%BEGIN_FREESPACE(A5)

spore_spawn_projectile_check:
{
  LDX $0E54

  ; Push current enemy HP to the stack
  LDA $0F8C,x : PHA

  JSL spore_spawn_damage

  ; $12 = previous enemy HP
  PLA : STA $12

  ; $12 = [previous enemy HP] - [enemy HP]
  LDX $0E54
  SEC
  SBC $0F8C,x
  STA $12

  ; A = projectile type
  PHX
  LDA $18A6
  ASL A
  TAX
  LDA $0C18,x
  PLX

  BIT #$0700
  BNE .missiles_or_supers
  BRA .beam

.missiles_or_supers:
  JSR play_sad_sound

  ; Add enemy HP back to undo the damage
  LDA $0F8C,x
  CLC
  ADC $12

  ; Don't allow "undamage" too far beyond beyond original HP
  ; TODO - I shouldn't hard-code this
  CMP #$03C0
  BPL .store_new_hp_and_return

  ; Add enemy HP back to "undamage"
  CLC
  ADC $12

  BRA .store_new_hp_and_return

.beam:
  JSR play_happy_sound

  ; Subtract enemy HP to increase damage (4X)
  ; (but we will always need one more shot to finish)
  LDA $0F8C,x
  SEC : SBC $12
  SEC : SBC $12
  SEC : SBC $12
  BPL .store_new_hp_and_return

  LDA #$0000

.store_new_hp_and_return:
  STA $0F8C,x            ; [enemy HP] = A

  ; TODO - change color to black if too much damage?
  ; TODO - (maybe even explode)
  ; TODO - allow an exit out of the room
  RTL
}

play_sad_sound:
{
  PHX
  JSL $808111
  AND #$0006
  TAX
  LDA .sad_sounds,x
  JSL $8090CB
  PLX
  RTS

.sad_sounds:
  dw $0016, $001A, $0030, $0059
}

play_happy_sound:
{
  PHX
  JSL $808111
  AND #$0006
  TAX
  LDA .happy_sounds,x
  JSL $8090CB
  PLX
  RTS

.happy_sounds:
  dw $0079, $007A, $007B, $0002
}

; TODO:
; * Final animation should be a slow close of the mouth
; * Missiles should not damage spore spawn (only charge shots)
; * (but - if only charge shots damage spore spawn then it's possible to
;   softlock!)
; * Spore spawn color change during fight is too subtle

%END_FREESPACE(A5)
