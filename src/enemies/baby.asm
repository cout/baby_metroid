!BABY_HYPER_FIRING_RATE = #$0030

!BABY_STATE = $0FA8,x
!BABY_X_VELOCITY = $0FAA,x
!BABY_Y_VELOCITY = $0FAC,x
!BABY_PALETTE_FRAME_TIMER = $0FAE,x
!BABY_PALETTE_DELAY = $0FB0,x
!BABY_FUNCTION_TIMER = $0FB2,x
!BABY_PROBABLY_UNUSED = $0FB4,x
!BABY_UNKNOWN = $0FB6,x

!BABY_FLASH_TIMER = $7E780C,x
!BABY_PALETTE_FUNCTION = $7E781E,x

org !FREEMEM_7F

; TODO - ideally these should use the current enenmy index but this is
; fine since there will only ever be one baby

baby_targeted_enemy:
print "Variable baby_targeted_enemy: $", pc
skip 2

baby_start_position_x:
print "Variable baby_start_position_x: $", pc
skip 2

baby_start_position_y:
print "Variable baby_start_position_y: $", pc
skip 2

baby_target_position_x:
print "Variable baby_target_position_x: $", pc
skip 2

baby_target_position_y:
print "Variable baby_target_position_y: $", pc
skip 2

end_baby_freemem_7f:
!FREEMEM_7F := end_baby_freemem_7f

org !FREESPACE_A0

baby:

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
; dw #$EF37                 ; init ai routine
; dw #$C710                 ; init ai routine
dw baby_init_ai           ; init ai routine
dw $0001                  ; number of parts
dw $0000                  ; unused
; dw #$EFC5                 ; main ai routine
; dw #$C779                 ; main ai routine
dw baby_main_ai
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
dw $F3F2                  ; drop chances (shared w/ samus status for now)
dw $F12E                  ; vulnerabilities
dw $0000                  ; enemy name

!baby = baby

print "Baby enemy id: ", hex(baby&$FFFF)

end_baby_freespace_a0:
!FREESPACE_A0 := end_baby_freespace_a0

org !FREESPACE_A9

baby_init_ai:
{
  LDX $0E54
  LDA $0F86,x : ORA #$3000 : STA $0F86,x  ; process instructions and block plasma
  LDA #$CFA2 : STA $0F92,x                ; instruction pointer
  LDA #$0001 : STA $0F94,x                ; instruction timer
  STA $7E7808,x                           ; Enable cry sound effect
  STZ $0F90,x                             ; Enemy timer = 0
  LDA #$000A : STA $0FB0,x                ; Enemy palette handler delay = Ah
  LDA #$00A0 : STA $0F98,x                ; Enemy VRAM tiles index = A0h
  STZ $0FAA,x                             ; Enemy X velocity = 0
  STZ $0FAC,x                             ; Enemy Y velocity = 0
  LDA #$00F8 : STA $0FB2,x                ; Enemy function timer = F8h
  LDA #$F683 : STA $7E781E,x              ; Enemy palette function = $F683 (normal)

  ; Set initial state function
  LDA.w #baby_state_pick_target
  STA $0FA8,x

  ; Set palette colors and return
  LDY #$94D4
  LDA $0F96,x : TAX
  LDA #$000F
  JMP $D2E4
}

baby_main_ai:
{
  LDX $0E54            
  STZ $0FA2,x            ; Enemy shake timer = 0
  JSR ($0FA8,x)          ; Execute [enemy function]
  JSL $A9C3EF            ; Move enemy according to enemy velocity
  JSR $C79C              ; Handle flashing

  ; Execute enemy palette function
  LDX $0E54
  LDA $7E781E,x
  STA $12
  PEA $C79A
  JMP ($0012)

  RTL
}

baby_state_pick_target:
{
  ; Give Samus hyper beam (TODO - if we don't do this, then beam
  ; graphics are glitched)
  LDA #$0003
  JSL $91E4AD

  JSR baby_pick_target
  ; BCC .follow_samus_and_return
  BCC .no_enemy

  STA baby_targeted_enemy

  TAY

  LDA $0F7A,x
  STA baby_start_position_x

  LDA $0F7E,x
  STA baby_start_position_y

  LDA.w #baby_state_move_to_target_position
  STA $0FA8,x
  RTS

.no_enemy:
  LDA #$0000
  STA baby_targeted_enemy

.follow_samus_and_return:
  JMP follow_samus
}

baby_pick_target:
{
  PHX
  LDX #$0000

.loop:
  ; If enemy id is 0, skip it
  LDA $0F78,x
  BEQ .next

  ; If this is the baby, skip it
  CMP.w #baby
  BEQ .next

  ; If enemy is deleted, skip it
  LDA $0F86,x
  BIT #$0200
  BNE .next

  TXA
  SEC
  BRA .return

.next:
  TXA
  CLC
  ADC #$0040
  TAX
  CMP #$0800
  BPL .not_found
  BRA .loop

.not_found:
  CLC

.return:
  PLX
  RTS
}

baby_state_move_to_target_position:
{
  LDA baby_targeted_enemy : TAY

  LDA $0F78,y
  BEQ .enemy_has_been_eliminated

  LDA $0F86,y
  BIT #$0200
  BNE .enemy_has_been_eliminated

  JSR baby_move_to_target_position
  BCC .return

.ready_to_fire:
  LDA.w #baby_state_fire_at_target
  STA $0FA8,x
  LDA #$0001
  STA $0FB2,x
  RTS

.enemy_has_been_eliminated:
  LDA.w #baby_state_pick_target
  STA $0FA8,x

.return:
  RTS
}

; TODO TODO TODO -
;
; Baby fails to leave state baby_state_move_to_target_position when
; samus shots the shutter
;
; Baby never tries to shoot
;
; If the top of a shutter is shot, Baby moves into the floor (did the
; shutter's coordinates suddenly change to 0?)
;
; I probably want a delay before firing for players that are not
; familiar with the rooms so they have just enough time to spot the
; pirates before they get shot
;
; I think I want the big boy movement function not the mb cutscene
; movement function, because I want the baby to move around samus not
; just sit there

baby_move_to_target_position:
{
  JSR baby_compute_target_position

  ; Y = 0 (slowest acceleration) - TODO: we probably want faster
  LDY #$0000

  ; Gradually accelerate towards point ([$12], [$14])
  JSR $F451

  LDA $0F7A,x
  SEC
  SBC $12
  CMP #$0010
  BPL .not_there_yet

  LDA $0F7E,x
  SEC
  SBC $1E
  CMP #$0010
  BPL .not_there_yet

.reached_target:
  SEC
  RTS

.not_there_yet:
  CLC
  RTS
}

baby_compute_target_position:
{
  LDA baby_targeted_enemy : TAY

  LDA baby_start_position_x
  SEC
  SBC $0F7A,y
  BPL .baby_is_right_of_enemy

.baby_is_left_of_enemy
  EOR #$FFFF
  INC A
  CMP #$0040
  BPL .use_middle
  ADC $0F7A,y
  SEC
  SBC #$0040
  BRA .store_x

.baby_is_right_of_enemy:
  CMP #$0040
  BPL .use_middle
  LDA $0F7A,y
  CLC
  ADC #$0040
  BRA .store_x

.use_middle:
  ; Target X position is halfway between baby and target enemy X
  LDA baby_start_position_x
  SEC
  ROR
  STA $12
  LDA $0F7A,y
  SEC
  ROR
  CLC
  ADC $12

.store_x:
  STA $12
  STA baby_target_position_x

.compute_y:
  ; Target Y position is a 45 degree angle up
  ; TODO - it should randomly (or alternatingly) be up or down
  LDA $12
  SEC
  SBC $0F7A,y
  BMI +
  EOR #$FFFF
  INC A
+ ADC $0F7E,y
  STA $14
  STA baby_target_position_y

  RTS
}

baby_state_fire_at_target:
{
  LDA baby_targeted_enemy : TAY

  LDA $0F78,y
  BEQ .enemy_has_been_eliminated

  LDA $0F86,y
  BIT #$0200
  BNE .enemy_has_been_eliminated

.move_around_target_position:
  JSR baby_move_to_target_position

.wait_for_shot_timer:
  DEC $0FB2,x
  BNE .return

.fire_at_will:
  JSL baby_fire_hyper_beam

  LDA !BABY_HYPER_FIRING_RATE
  STA $0FB2,x

  RTS

.enemy_has_been_eliminated:
  LDA.w #baby_state_pick_target
  STA $0FA8,x

.return:
  RTS
}

baby_state_follow_samus:
{
  DEC $0FB2,x
  BNE .follow_samus_and_return

  LDA.w #baby_state_pick_target
  STA $0FA8,x

.follow_samus_and_return:
  JMP follow_samus
}

follow_samus:
{
  ; $12 = Samus X position
  LDA $0AF6
  STA $12

  ; $14 = Samus Y position - 20
  LDA $0AFA
  SEC
  SBC #$0014
  STA $14

  ; Y = 0 (slowest acceleration)
  LDY #$0000

  ; Gradually accelerate towards point ([$12], [$14])
  JMP $F451
}

end_baby_freespace_a9:
!FREESPACE_A9 = end_baby_freespace_a9

org !FREESPACE_90

baby_fire_hyper_beam:
; Parameters:
;   X = baby enemy index
;   Y = target enemy index (TODO)
{
  PHX

  ; Y = baby enemy index
  ; (it is more convenient to use X for the projectile index)
  TXA : TAY

  LDA $0CCE
  CMP #$0005
  BPL .return

  INC
  STA $0CCE

  ; Find an empty projectile slot
  LDX #$0000
.next_slot:
  LDA $0C2C,x
  BEQ .fire_hyper_beam
  INX
  INX
  CPX #$000A
  BMI .next_slot
  BRA .return

.fire_hyper_beam:
  ; TODO:
  ; 1. Set direction correctly (0..9 for one of 8 possible directions,
  ;    up and down are duplicated)
  ; 2. Compute vector from baby to target then set X/Y speed accordingly
  JSR baby_choose_firing_direction : STA $0C04,x ; direction
  LDA $0F7A,y : STA $0B64,x ; X pos
  LDA $0F7E,y : STA $0B78,x ; Y pos
  LDA #$9018  : STA $0C18,x ; projectile type
  LDA #$000A  : STA $18AC   ; projectile invincibility timer

  LDA #$001F
  JSL $809021 ; queue sound from library 1, max=15

  JSL $938000 ; initialize projectile
  STZ $0BDC,x ; projectile X speed = 0
  STZ $0BF0,x ; projectile Y speed = 0

  STX $0DDE ; set current projectile index
  JSR $BDB2 ; beam collision detection
  LDX $0DDE ; X = current projectile index

  LDA $9383BF : STA $0C2C,x ; projectile damage = hyper beam damage value
  LDA #$B159  : STA $0C68,x ; Projectile pre-instruction = B159h

  STX $14
  JSL $90B197 ; set initial speed for projectile (including boost from Samus)

  ; TODO - can we give the baby hyper colors like Samus does when she
  ; fires?

.return:
  PLX ; TODO - does this affect the carry flag?
  RTL
}

baby_choose_firing_direction:
; Parameters:
;   X = baby enemy index
;   Y = target enemy index (TODO)
{
  ; Compute angle of enemy X from enemy Y
  ; (i.e. from baby to enemy)
  ;
  ; This gives us an angle between 00h and F0h, with 00h directly up.
  JSL $A0C096

  ; Divide by 8
  LSR : LSR : LSR : LSR

  ; We now have an angle between 0h and Fh, with 0h directly up; it
  ; needs to be converted to a firing direction:
  ;
  ;       0                 8 9  0 1
  ;     E | 2                \ || /
  ;      \|/                  \||/
  ;   C -- -- 4      ==>  7 ---++-- 2
  ;      /|\                  /||\
  ;    A  | 6                / || \
  ;       8                 6 5  4 3
  ;
  ; Note this is not perfect; it does not account for "facing left and
  ; firing up/down" vs "facing right and firing up/down".
  ADC #$0001
  LSR
  CMP #$0008
  BCC +
  INC
  +

  RTS
}

end_baby_freespace_90:
!FREESPACE_90 = end_baby_freespace_90

print "Baby states:"
print "  pick target - ", hex(baby_state_pick_target&$FFFF)
print "  move to target position - ", hex(baby_state_move_to_target_position&$FFFF)
print "  fire at target - ", hex(baby_state_fire_at_target&$FFFF)
print "  follow samus - ", hex(baby_state_follow_samus&$FFFF)
