; Generated binary files with:
;
; superfamiconv \
; -W 16 -H 16 -R 1 -D 1 \
; -i samus_statue.png \
; -t enemies/samus_statue_tiles.bin \
; -p enemies/samus_statue_palette.bin

org !FREESPACE_A0

samus_statue:
!samus_statue = samus_statue

dw $0800                  ; tile data size
dw samus_statue_palette   ; palette
dw $01C2                  ; health
dw $0050                  ; damage
dw $000C                  ; x radius
dw $0020                  ; y radius
db $A3                    ; bank
db $00                    ; hurt ai time
dw $0068                  ; cry
dw $0000                  ; boss value
dw samus_statue_init_ai   ; init ai routine
dw $0001                  ; number of parts
dw $0000                  ; unused
dw samus_statue_main_ai   ; main ai routine
dw $800F                  ; grapple ai routine
dw $804C                  ; hurt ai routine
dw $8041                  ; frozen ai routine
dw $0000                  ; time is frozen ai routine
dw $0000                  ; death animation
dd $00000000              ; unused
dw $0000                  ; power bomb reaction
dw $0000                  ; unknown
dd $00000000              ; unused
dw samus_statue_touch     ; touch routine
dw samus_statue_shot      ; shot routine
dw $0000                  ; unknown
dl samus_statue_tile_data ; tile data
db $05                    ; layer
dw $F3F2                  ; drop chances
dw $EEC6                  ; vulnerabilities
dw $E2E5                  ; enemy name

end_samus_statue_freespace_a0:
!FREESPACE_A0 := end_samus_statue_freespace_a0

org !FREESPACE_A3

samus_statue_tile_data:
incbin "enemies/samus_statue_tiles.bin"

samus_statue_palette:

incbin "enemies/samus_statue_palette.bin"

samus_statue_looking_up_spritemap:
{

dw $0006 ; number of entries

;  s xxx       yy       pfnn
dw $81F0 : db $E1 : dw $2100 ; (-15, -30)
dw $8000 : db $E1 : dw $2102 ; (  0, -30)
dw $81F0 : db $F1 : dw $2104 ; (-15, -14)
dw $8000 : db $F1 : dw $2106 ; (  0, -14)
dw $81F0 : db $01 : dw $2108 ; (-15,   1)
dw $8000 : db $01 : dw $210a ; (  0,   1)

}

samus_statue_looking_right_spritemap:
{

; TODO TODO TODO - for some odd reason this isn't showing up right.  the
; bottom left tile of this statue is combined with the top tile of the
; other statue.
;

dw $0004 ; number of entries

;  s xxx       yy       pfnn
dw $81F0 : db $EC : dw $210c ; (-15, -14)
dw $8000 : db $EC : dw $210e ; (  0, -14)
dw $81F0 : db $FC : dw $2120 ; (-15,   1)
dw $8000 : db $FC : dw $2122 ; (  0,   1)

}

samus_statue_looking_up_instruction_list:
{
dw $7FFF, samus_statue_looking_up_spritemap
dw $812F ; Sleep
}

samus_statue_looking_right_instruction_list:
{
dw $7FFF, samus_statue_looking_right_spritemap
dw $812F ; Sleep
}

samus_statue_instruction_lists:

dw samus_statue_looking_up_instruction_list
dw samus_statue_looking_right_instruction_list

samus_statue_init_ai:
{
  LDX $0E54
  LDA $0FB4,x
  ASL
  TAY
  LDA samus_statue_instruction_lists,y
  STA $0F92,x

  RTL
}

samus_statue_main_ai:
{
  ; Do nothing
  RTL
}

samus_statue_touch:
{
  ; Do nothing
  RTL
}

samus_statue_shot:
{
  ; Invoke the normal enemy shot AI
  JSL $A0A63D
  RTL
}

end_samus_statue_freespace_a3:
!FREESPACE_A3 := end_samus_statue_freespace_a3
