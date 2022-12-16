; Generated binary files with:
;
; ./tools/SuperFamiconv/build/superfamiconv -W 16 -H 16 -R 1 -D 1 -i src/enemies/samus_statue.png -t src/enemies/samus_statue_tiles.bin -p src/enemies/samus_statue_palette.bin ;
; Note: when changing image mode to Indexed in GIMP, make sure to
; uncheck "remove unused colors" to ensure correct color order.

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
incbin "samus_statue_tiles.bin"

samus_statue_palette:

; incbin "samus_statue_palette.bin"

samus_statue_lower_crateria_palette:
dw $7c00, $28e7, $41ad, $5a73, $7f9c, $0844, $0000, $0000
dw $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000

samus_statue_warehouse_entrance_palette:
dw $7c00, $2c22, $4167, $5a2d, $7fb9, $1820, $0000, $0000
dw $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000

samus_statue_bubble_mountain_palette:
dw $7c00, $10c2, $25c5, $4309, $53ec, $0885, $0000, $0000
dw $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000

samus_statue_red_norfair_palette:
dw $7c00, $0c49, $0c72, $0c99, $1e7d, $0c41, $0000, $0000
dw $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000

samus_statue_red_brinstar_palette:
dw $7c00, $104c, $14b0, $2117, $2d7c, $0c48, $0804, $0000
dw $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000

samus_statue_red_brinstar_green_palette:
dw $7c00, $0884, $1529, $19af, $2a54, $0821, $0000, $0000
dw $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000

samus_statue_wrecked_ship_green_palette:
dw $7c00, $04c6, $0d08, $25ce, $3e94, $0843, $0000, $0000
dw $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000

samus_statue_palettes:

dw samus_statue_lower_crateria_palette        ; 0
dw samus_statue_warehouse_entrance_palette    ; 1
dw samus_statue_bubble_mountain_palette       ; 2
dw samus_statue_red_norfair_palette           ; 3
dw samus_statue_red_brinstar_palette          ; 4
dw samus_statue_red_brinstar_green_palette    ; 5
dw samus_statue_wrecked_ship_green_palette    ; 6

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

dw $0004 ; number of entries

;  s xxx       yy       pfnn
dw $81F0 : db $EC : dw $210c ; (-15, -14)
dw $8000 : db $EC : dw $210e ; (  0, -14)
dw $81F0 : db $FC : dw $2120 ; (-15,   1)
dw $8000 : db $FC : dw $2122 ; (  0,   1)

}

samus_statue_looking_down_spritemap:
{

dw $0006 ; number of entries

;  s xxx       yy       pfnn
dw $81F0 : db $E1 : dw $2124 ; (-15, -30)
dw $8000 : db $E1 : dw $2126 ; (  0, -30)
dw $81F0 : db $F1 : dw $2128 ; (-15, -14)
dw $8000 : db $F1 : dw $212a ; (  0, -14)
dw $81F0 : db $01 : dw $212c ; (-15,   1)
dw $8000 : db $01 : dw $212e ; (  0,   1)

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

samus_statue_looking_down_instruction_list:
{
dw $7FFF, samus_statue_looking_down_spritemap
dw $812F ; Sleep
}

samus_statue_instruction_lists:

dw samus_statue_looking_up_instruction_list
dw samus_statue_looking_right_instruction_list
dw samus_statue_looking_down_instruction_list

samus_statue_init_ai:
{
  ; X = current enemy index
  LDX $0E54

  ; Pick instruction list based on parameter 1
  LDA $0FB4,x
  ASL
  TAY
  LDA samus_statue_instruction_lists,y
  STA $0F92,x

  ; Copy palette based on parameter 2
  LDA $0FB6,x
  ASL
  TAY
  LDA samus_statue_palettes,y
  TAY ; y is now pointing to the source palette
  LDA $0F96,x
  LSR : LSR : LSR : LSR
  TAX ; x is now pointing to the dest palette
  LDA $0000,y : STA $7EC300,x : INY : INY : INX : INX
  LDA $0000,y : STA $7EC300,x : INY : INY : INX : INX
  LDA $0000,y : STA $7EC300,x : INY : INY : INX : INX
  LDA $0000,y : STA $7EC300,x : INY : INY : INX : INX
  LDA $0000,y : STA $7EC300,x : INY : INY : INX : INX
  LDA $0000,y : STA $7EC300,x : INY : INY : INX : INX
  LDA $0000,y : STA $7EC300,x : INY : INY : INX : INX
  LDA $0000,y : STA $7EC300,x : INY : INY : INX : INX

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
