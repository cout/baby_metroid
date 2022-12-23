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
  LDA.w #baby_state_follow_samus
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

baby_state_follow_samus:
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
