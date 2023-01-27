; TODO
; 1. baby should find samus quickly initially (or maybe always) but the
;    slow follow should be later, or perhaps slow follow if close to
;    samus and fast otherwise
; 2. baby should find enemies to shoot faster than it does
; 3. put baby in correct position coming through the door
; 4. baby should follow samus out the previous door (i.e. accelerate
;    toward the door when the transition starts)

!BABY_HYPER_FIRING_RATE = #$0030
!BABY_ACCELERATION_TO_TARGET_POSITION = #$0002
!BABY_ACCELERATION_TO_SAMUS = #$0000
!BABY_ACCELERATION_ESCAPE = #$0020
!BABY_ALTITUDE_ABOVE_SAMUS = #$0014

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

; TODO - ideally these should use the current enemy index but this is
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

baby_last_firing_angle:
print "Variable baby_last_firing_angle: $", pc
skip 2

baby_last_firing_direction:
print "Variable baby_last_firing_direction: $", pc
skip 2

baby_targeted_enemy_position_x:
print "Variable baby_targeted_enemy_position_x: $", pc
skip 2

baby_targeted_enemy_position_y:
print "Variable baby_targeted_enemy_position_y: $", pc
skip 2

baby_unable_to_fire:
print "Variable baby_unable_to_fire: $", pc
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
dw $F3F2                  ; drop chances
dw $F12E                  ; vulnerabilities
dw $0000                  ; enemy name

!baby = baby

print "Baby enemy id: ", hex(baby&$FFFF)

end_baby_freespace_a0:
!FREESPACE_A0 := end_baby_freespace_a0

baby_accelerate_slowly_toward_point = $A9F451

org !FREESPACE_A9

baby_instruction_list:
{
.top:
  dw $0010, $F9A8 ; claws in - metroid bottom
  dw $0010, $FA40 ; claws down - metroid top
  dw $0010, $FAD8 ; claws out - OK
  dw $0010, $FA40 ; claws down
  dw $80ED, .top
}

; TODO: we shouldn't manually change $0F86; it should be set in the
; enemy population like other enemies
baby_init_ai:
{
  LDX $0E54
  LDA $0F86,x : ORA #$3000 : STA $0F86,x     ; process instructions and block plasma
  LDA.w #baby_instruction_list : STA $0F92,x ; instruction pointer
  LDA #$0001 : STA $0F94,x                   ; instruction timer
  STA $7E7808,x                              ; Enable cry sound effect
  STZ $0F90,x                                ; Enemy timer = 0
  LDA #$000A : STA $0FB0,x                   ; Enemy palette handler delay = Ah
  STZ $0FAA,x                                ; Enemy X velocity = 0
  STZ $0FAC,x                                ; Enemy Y velocity = 0
  LDA #$00F8 : STA $0FB2,x                   ; Enemy function timer = F8h
  LDA #$F683 : STA $7E781E,x                 ; Enemy palette function = $F683 (normal)
  ; LDA.w #baby_null_palette_function
  ; STA $7E781E,x

  ; Set initial state function
  LDA $0FB6,x
  BNE .baby_is_immobile

.baby_is_mobile:
  LDA.w #baby_state_pick_target
  STA $0FA8,x

  ; Set palette colors and return
  LDY #$94D4
  LDA $0F96,x : TAX
  LDA #$000F
  JMP $D2E4

.baby_is_immobile:
  LDA.w #baby_state_stay
  STA $0FA8,x

  RTL
}

baby_null_palette_function:
RTS

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

  ; If this is the climb room the baby has a special task
  LDA $079B
  CMP #$96BA
  BNE .follow_samus_and_return

  ; But all the enemies in the room must be dead, not just off screen
  LDA $0E50
  CMP $0E52
  BCC .follow_samus_and_return

  LDA.w #baby_state_rush_to_save_samus
  STA $0FA8,x

.follow_samus_and_return:
  JMP follow_samus
}

baby_state_stay:
{
  RTS
}

baby_pick_target:
{
  PHY
  LDY #$0000

.loop:
  JSR baby_can_fire_at_enemy
  BEQ .next

  TYA
  SEC
  BRA .return

.next:
  TYA
  CLC
  ADC #$0040
  TAY
  CMP #$0800
  BPL .not_found
  BRA .loop

.not_found:
  CLC

.return:
  PLY
  RTS
}

baby_can_fire_at_enemy:
; Parameters:
;   Y = target enemy index
;
{
  ; If enemy id is 0, skip it
  LDA $0F78,y
  BEQ .no

  ; If this is the baby, skip it
  CMP.w #baby
  BEQ .no

  ; If enemy is deleted, skip it
  LDA $0F86,y
  BIT #$0200
  BNE .no

  ; If enemy is off screen, skip it
  JSR baby_check_enemy_is_on_screen
  BEQ .no

.yes:
  LDA #$0001
  RTS

.no:
  LDA #$0000
  RTS
}

baby_check_enemy_is_on_screen:
; Parameters:
;   Y = target enemy index
;
; Based on $A0:ADE7, but that function expects the enemy index to be in
; $0E54.
{
  ; Check left side
  LDA $0F7A,y
  CLC
  ADC $0F82,y
  CMP $0911
  BMI .off_screen

  ; Check right side
  LDA $0911
  CLC
  ADC #$0100
  CLC
  ADC $0F82,y
  CMP $0F7A,y
  BMI .off_screen

  ; Check top side
  LDA $0F7E,y
  CLC
  ADC #$0008
  CMP $0915
  BMI .off_screen

  ; Check bottom side
  LDA $0915
  CLC
  ADC #$00F8
  CMP $0F7E,y
  BMI .off_screen

.on_screen:
  LDA #$0001
  RTS

.off_screen:
  LDA #$0000
  RTS
}

baby_state_move_to_target_position:
{
  LDA baby_targeted_enemy : TAY

  JSR baby_can_fire_at_enemy
  BEQ .enemy_has_been_eliminated

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

; TODO - I think I want the big boy movement function not the mb
; cutscene movement function, because I want the baby to move around
; samus not just sit there

baby_move_to_target_position:
{
  JSR baby_compute_target_position

  LDY !BABY_ACCELERATION_TO_TARGET_POSITION

  ; Gradually accelerate towards point ([$12], [$14])
  JSR baby_accelerate_slowly_toward_point

  LDA $0F7A,x
  SEC
  SBC $12
  BPL +
  EOR #$FFFF
  INC
+ CMP #$0010
  BPL .not_there_yet

  LDA $0F7E,x
  SEC
  SBC $14
  BPL +
  EOR #$FFFF
  INC
+ CMP #$0010
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

  JSR baby_can_fire_at_enemy
  BEQ .enemy_has_been_eliminated

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

baby_state_rush_to_save_samus:
{
  LDA $0AF6
  SEC
  SBC $0F7A,x
  BPL +
  EOR #$FFFF
  INC A
+ CMP #$0010
  BPL .move_to_samus

  LDA $0AFA
  SEC
  SBC $0F7E,x
  BPL +
  EOR #$FFFF
  INC A
+ CMP #$0010
  BPL .move_to_samus

  LDA.w #baby_state_move_samus_to_center
  STA $0FA8,x

.move_to_samus:
  ; $12 = Samus X position
  LDA $0AF6
  STA $12

  ; $14 = Samus Y position
  LDA $0AFA
  SEC
  SBC !BABY_ALTITUDE_ABOVE_SAMUS
  STA $14

  LDY !BABY_ACCELERATION_ESCAPE

  JMP baby_accelerate_slowly_toward_point
}

baby_state_move_samus_to_center:
{
  LDA $0F7A,x
  SEC
  SBC #$0180
  BPL +
  EOR #$FFFF
  INC A
+ CMP #$0010
  BPL .move_to_center

  LDA.w #baby_state_climb_climb_climb
  STA $0FA8,x

.move_to_center
  LDA #$0180
  STA $12

  ; TODO - store the target Y position, because depending on samus's
  ; position is probably not a good idea
  LDA $AFA
  STA $14

  ; TODO - this is a slower movement than I intended, but I think it
  ; works
  LDY !BABY_ACCELERATION_ESCAPE
  JSR baby_accelerate_slowly_toward_point

  LDA $0F7A,x
  STA $0AF6

  ; TODO - this is too low - I can barely see Samus's legs.  But if I
  ; move Samus down then the baby will move down too and they will both
  ; end up out of bounds.
  LDA $0F7E,x
  STA $0AFA

  RTS
}

baby_state_climb_climb_climb:
{
  LDA #$0180
  STA $12

  LDA $0000
  STA $14

  LDY !BABY_ACCELERATION_ESCAPE
  JSR baby_accelerate_slowly_toward_point

  LDA $0F7A,x
  STA $0AF6

  LDA $0F7E,x
  STA $0AFA

  RTS
}

follow_samus:
{
  ; $12 = Samus X position
  LDA $0AF6
  STA $12

  ; $14 = Samus Y position - 20
  LDA $0AFA
  SEC
  SBC !BABY_ALTITUDE_ABOVE_SAMUS
  STA $14

  LDY !BABY_ACCELERATION_TO_SAMUS

  ; Gradually accelerate towards point ([$12], [$14])
  JMP baby_accelerate_slowly_toward_point
}

end_baby_freespace_a9:
!FREESPACE_A9 = end_baby_freespace_a9

org !FREESPACE_90

baby_fire_hyper_beam:
; Parameters:
;   X = baby enemy index
;   Y = target enemy index
{
  PHX

  ; Y = baby enemy index
  ; (it is more convenient to use X for the projectile index)
  TXA : TAY

  LDA $0CCE
  CMP #$0005
  BPL .unable_to_fire

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

  ; Could not find an empty slot; decrement the projectile count
  DEC $0CCE

.unable_to_fire:
  LDA #$0001 : STA baby_unable_to_fire
  BRA .return

.fire_hyper_beam:
  LDA #$0000 : STA baby_unable_to_fire

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
  PLX
  RTL
}

baby_choose_firing_direction:
; Parameters:
;   Y = baby enemy index
{
  PHX
  PHY

  LDA baby_targeted_enemy : TAX

  LDA $0F7A,y : STA baby_targeted_enemy_position_x
  LDA $0F7E,y : STA baby_targeted_enemy_position_y

  ; Compute angle of enemy X from enemy Y
  ; (i.e. from baby to enemy)
  ;
  ; This gives us an angle between 00h and F0h, with 00h directly up.
  JSL $A0C096
  STA baby_last_firing_angle

  ; Divide by 16
  LSR : LSR : LSR : LSR

  ; We now have an angle between 0h and Fh, with 0h directly up; it
  ; needs to be converted to a firing direction:
  ;
  ;       0                 8 9  0 1
  ;    E  |  2               \ || /
  ;      \|/                  \||/
  ;   C --+-- 4      ==>  7 ---++--- 2
  ;      /|\                  /||\
  ;    A  |  6               / || \
  ;       8                 6 5  4 3
  ;
  ; Note this is not perfect; it does not account for "facing left and
  ; firing up/down" vs "facing right and firing up/down".
  ADC #$0001
  LSR
  CMP #$0004
  BCC +
  INC
+
  STA baby_last_firing_direction

  PLY
  PLX

  RTS
}

end_baby_freespace_90:
!FREESPACE_90 := end_baby_freespace_90

print "Baby states:"
print "  pick target - ", hex(baby_state_pick_target&$FFFF)
print "  move to target position - ", hex(baby_state_move_to_target_position&$FFFF)
print "  fire at target - ", hex(baby_state_fire_at_target&$FFFF)
print "  follow samus - ", hex(baby_state_follow_samus&$FFFF)
print "  rush to save samus - ", hex(baby_state_rush_to_save_samus&$FFFF)
print "  move samus to center - ", hex(baby_state_move_samus_to_center&$FFFF)
print "  climb climb climb - ", hex(baby_state_climb_climb_climb&$FFFF)
