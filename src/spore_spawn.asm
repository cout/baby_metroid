;;
; Spore spawn instruction lists

org $A5E6C7

instruction_list_spore_spawn_alive:

dw $0008, $EF61        ; mouth fully open
dw $E8BA, $EB1B        ; start fight
dw $812F               ; sleep

instruction_list_spore_spawn_fight_started:

dw $E91C, $00C0
dw $E82D, $0000, $0000 ; speed = 00h, angle delta = 0

instruction_list_spore_spawn_main_loop:

dw $E8BA, $EB52        ; handle spore spawn movement
dw $812F               ; sleep

org $A5E729

instruction_list_spore_spawn_close_mouth:

; Prevent the mouth from closing
dw $E771
dw $80ED, instruction_list_spore_spawn_fight_started

;;
; Skip the descent into the room

org $A5EB1B ; spore spawn descent function

LDX $0E54
LDA #$0270
STA $0F7E,x
LDA instruction_list_spore_spawn_fight_started
STA $0F92,x

;;
; Disable spore spawn movement reaction to being shot

org $A5EC49 ; update spore spawn stalk segment positions

RTS

org $A5EB55 ; second instruction in spore spawn movement function

JMP $EB8A

; TODO:
; * Change palette (start dead and get greener)
; * Final animation should be a slow close of the mouth
