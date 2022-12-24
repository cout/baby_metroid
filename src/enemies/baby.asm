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
  LDA.w #baby_state_follow_samus_hyper
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
  LDX $0E54            
  LDA $7E781E,x          ;\
  STA $12                ;|
  PEA $C79A              ;} Execute [enemy palette function]
  JMP ($0012)            ;/

  RTL
}

baby_state_follow_samus_hyper:
{
  ; Give Samus hyper beam (TODO - this should not be necessary; I'm just
  ; doing it as an experiment to see if that's why the baby can't shoot
  ; hyper)
  LDA #$0003
  JSL $91E4AD

LDX #$0000

.loop:
  ; If enemy id is 0, skip it
  LDA $0F78,x
  BEQ .next

  ; If this is the baby, skip it
  CMP !baby
  BEQ .next

  ; If enemy is deleted, skip it
  LDA $0F86,x
  BIT #$0200
  BNE .next

  JSL baby_fire_hyper_beam

  LDA #$0100
  STA $0FB2
  LDA.w #baby_state_follow_samus
  STA $0FA8,x

  BRA .follow_samus_and_return

.next:
  TXA
  CLC
  ADC #$0040
  CMP #$0800
  TAX
  BPL .loop

.follow_samus_and_return:
  JMP follow_samus
}

baby_state_follow_samus:
{
  DEC $0FB2,x
  BNE .follow_samus_and_return

  LDA.w #baby_state_follow_samus_hyper
  STA $0FA8,x

.follow_samus_and_return:
  JMP follow_samus
}

follow_samus:
{
  LDA $0AF6              ;\
  STA $12                ;} $12 = [Samus X position]

  LDA $0AFA              ;\
  SEC                    ;|
  SBC #$0014             ;} $14 = [Samus Y position] - 20
  STA $14                ;/

  LDY #$0000             ; Y = 0 (slowest acceleration)

  JMP $F451              ; Gradually accelerate towards point ([$12], [$14])
}

end_baby_freespace_a9:
!FREESPACE_A9 = end_baby_freespace_a9

org !FREESPACE_90

baby_fire_hyper_beam:
{
  PHX

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
  ; 3. Are the baby's shots being blocked by the shutters or by the
  ;    baby?
  ; 4. The shutters definitely do not respond to hyper beam currently.
  ;    To test if this is because of the baby: remove baby from the
  ;    room, give Samus hyper beam, and see if she can get out.
  LDA #$0007  : STA $0C04,x ; direction
  LDA $0F7A,y : STA $0B64,x ; X pos
  LDA $0F7E,y : STA $0B78,x ; Y pos
  LDA #$9018  : STA $0C18,x ; projectile type
  LDA #$000A  : STA $18AC   ; projectile invincibility timer

  LDA #$001F
  JSL $809021 ; queue sound from library 1, max=15

  JSL $938000 ; initialize projectile
  STZ $0BDC,x ; projectile X speed = 1
  STZ $0BF0,x ; projectile Y speed = 0

  STX $0DDE ; set current projectile index
  JSR $BDB2 ; beam collision detection
  LDX $0DDE ; X = current projectile index

  LDA $9383BF : STA $0C2C,x ; projectile damage = hyper beam damage value
  LDA #$B159  : STA $0C68,x ; Projectile pre-instruction = B159h

  STX $14
  JSL $90B197 ; set initial speed for projectile (including boost from Samus)

.return:
  PLX ; TODO - does this affect the carry flag?
  RTL
}

end_baby_freespace_90:
!FREESPACE_90 = end_baby_freespace_90
