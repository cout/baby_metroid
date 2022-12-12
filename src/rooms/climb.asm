;;
; Replace pirates with elevators

org $A188C9 ; enemy population for state $96EB (zebes awake)

;                    x      y   init  props   xtra     p1     p2
dw !elevator,     $0180, $08A2, $0000, $2C00, $0000, $0001, $0018
dw !samus_statue, $0178, $0894, $0000, $2400, $0000, $0000, $0000
dw $FFFF
db $00

org !FREESPACE_B4

climb_graphics_set:

dw !samus_statue, $0001, $FFFF
db $00

end_climb_graphics_set:
!FREESPACE_B4 := end_climb_graphics_set

org $8F96EB : skip 10 ; enemy graphics set pointer for state $96EB


dw climb_graphics_set

;;
; Top door is an elevator door now

org $838B3E

; dw $92FD
; db $00, $07, $16, $4D, $01, $04
; dw $01C0, $B981

; dw $92FD
; db $80, $03, $00, $00, $00, $00
; dw $0000, $B981

; TODO - I found the "distance to spawn" through trial-and-error.  The
; usual way to do this is to have an elevator bring Samus into the room,
; and the elevator will stop at the right location, but I don't want
; anyone to see an elevator when the door is opened.
dw $92FD        ; room id
db $80          ; bitflags
db $07          ; direction (3=up, 7=up w/ closing door behind)
db $16          ; door cap x
db $4D          ; door cap y
db $01          ; screen x
db $04          ; screen y
dw $05b0        ; distance to spawn
dw top_door_sub ; door subroutine

;;
; Add a new door to the door list

org $8F96C3

dw climb_doors

org !FREESPACE_8F

climb_doors:
; dw $8B3E, $8B4A, $8B56, $8B62, $8B6E, $0000
dw $8B3E, $8B4A, $8B56, $8B62, $8B6E, $88FC

top_door_sub:
{

LDA $0E18
CMP #$0002
BEQ in_door_transition

; Set elevator to inactive
STZ $0E16
STZ $0E18

; Re-enable Samus controls and set Samus drawing handler to default
; (i.e. no longer flashing)
LDA #$000B
JSL $90F084

in_door_transition:
JMP $B981
}

climb_freespace_end:

!FREESPACE_8F := climb_freespace_end

;;
; Level data

incbin climb.bin -> $C3C998