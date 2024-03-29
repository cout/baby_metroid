;;;;;;
;
; Grapple hitbox viewer
;
; Draws a box around each of the tiles that is checked for collision during
; grappling.
;
; Based on the hitbox viewer in the SM practice hack
;
;;;;;;

%BEGIN_FREEMEM(7F)

grapple_collision_test_tiles:
skip 64
end_grapple_collision_test_tiles:

next_grapple_collision_test_tile:
skip 2

last_next_grapple_collision_test_tile:
skip 2

%END_FREEMEM(7F)

org $9ADAE0
db $FF, $FF, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80
db $FF, $FF, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80

org $94ABF9
JSR update_grapple_collision_test_tile

org $828B98
JSL draw_grapple_collision_test_tiles

%BEGIN_FREESPACE(94)

reset_grapple_collision_test_tiles:
{
  LDA.w #grapple_collision_test_tiles
  STA next_grapple_collision_test_tile
  RTL
}

update_grapple_collision_test_tile:
{
  LDA.w #grapple_collision_test_tiles
  TAX

.loop:
  TXA
  CMP next_grapple_collision_test_tile
  BCS .done

  LDA $7F0000,x
  CMP $0D96
  BNE .next

  LDA $7F0002,x
  CMP $0D94
  BNE .next

  ; Already added this one
  BRA .return

.next:
  INX : INX : INX : INX
  BRA .loop

.done:
  LDA next_grapple_collision_test_tile
  TAX

  LDA $0D96 ; block Y pos
  STA $7F0000,x
  INX : INX

  LDA $0D94 ; block X pos
  STA $7F0000,x
  INX : INX

  TXA
  STA next_grapple_collision_test_tile

.return:
  JSR $ABB0

  RTS
}

%END_FREESPACE(94)

%BEGIN_FREESPACE(B8)

!OAM_STACK_POINTER = $0590

draw_grapple_collision_test_tiles:
{
  PHX

  LDA.w #grapple_collision_test_tiles
  TAX

  LDA next_grapple_collision_test_tile
  STA last_next_grapple_collision_test_tile

.loop:
  TXA
  CMP next_grapple_collision_test_tile
  BCS .done
  CMP end_grapple_collision_test_tiles
  BCS .done

  ; Y pos
  LDA $7F0000,x
  ASL : ASL : ASL : ASL
  SEC : SBC $0915
  PHA
  INX : INX

  ; X pos
  LDA $7F0000,x
  ASL : ASL : ASL : ASL
  SEC : SBC $0911
  PHA
  INX : INX

  LDA #$0000
  SEP #$20
  LDY !OAM_STACK_POINTER
  PLA ; X coord
  STA $0370,Y : STA $0378,Y
  CLC : ADC #$08
  STA $0374,Y : STA $037C,Y

  PLA : PLA : DEC ; Y coord
  STA $0371,Y : STA $0375,Y
  CLC : ADC #$08
  STA $0379,Y : STA $037D,Y
  PLA

  LDA.b #%00111010 : STA $0373,Y ; Sprite 1 ATTR
  LDA.b #%01111010 : STA $0377,Y ; Sprite 2 ATTR
  LDA.b #%10111010 : STA $037B,Y ; Sprite 3 ATTR
  LDA.b #%11111010 : STA $037F,Y ; Sprite 4 ATTR

  LDA #$47 ; tile number (8/9 bits)
  STA $0372,Y : STA $0376,Y
  STA $037A,Y : STA $037E,Y

  REP #$20
  TYA : CLC : ADC #$0010 : STA !OAM_STACK_POINTER

  JMP .loop

.done:
  PLX

  JSL reset_grapple_collision_test_tiles
  JSL $A0884D
  RTL
}

%END_FREESPACE(B8)
