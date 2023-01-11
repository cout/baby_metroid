; Palette FX object $E1D8 (Zebes lava flow)
; This turns the lava ground-colored (brownish) and lets it fade out
; normally
org $8DD44A
palette_fx_object_E1D8:
{
  dw $C655, $0080  ; Palette FX object colour index = 0080h
.top:
  ;   time  color   done
  dw $0014, $0864, $C595
  dw $0014, $0443, $C595
  dw $0014, $0443, $C595
  dw $0014, $0422, $C595
  dw $0014, $0422, $C595
  dw $0014, $0021, $C595
  dw $0014, $0001, $C595
  dw $0014, $0000, $C595
  dw $C61E, .top ; Goto
}
warnpc $8DD48E

; Inside cinematic function $D837
; This loads only some of the cinematic sprite objects
; In particular, we skip $EEA4 (supernova parts 1 and 2)
org $8BD98D
{
  LDY #$EE9D : JSR $938A ; Planet Zebes
  LDY #$EEAF : JSR $938A ; Planet core
  LDY #$EEA9 : JSR $938A ; Starry background
  JMP $D9A5
}
warnpc $8BD9A5

; Instruction list - Cinematic sprite object $EE9D (supernova part 3)
; This skips the frames where cracks form on the planet's surface and
; keeps the planet on screen a little longer before the ship obscures it
org $8BEB0F
cinematic_sprite_object_EE9D:
{
  dw $94D6, $0004 ; Set timer
.top:
  dw $000D, $A396 ; Zebes frame 1
  dw $000D, $A3AC ; Zebes frame 2
  dw $000D, $A3C2 ; Zebes frame 3
  dw $000D, $A3D8 ; Zebes frame 4
  dw $94C3, .top  ; Decrement timer and goto if non-zero
  dw $F32B
  dw $94D6, $0010 ; Set timer
.animate_planet:
  dw $000D, $A396 ; Zebes frame 1
  dw $000D, $A3AC ; Zebes frame 2
  dw $000D, $A3C2 ; Zebes frame 3
  dw $000D, $A3D8 ; Zebes frame 4
  dw $94C3, .animate_planet ; Decrement timer and goto if non-zero
  dw $9438        ; Delete
}
; Overwrite $8B:EB3D since it is no longer used
warnpc $8BEB51

; Inside cinematic function $DAD3
; Skip assignment to $55 and stop music
org $8BDB4B
{
  STZ $1A49
  LDA #$DB9D
  STA $1F51
  ; TODO: "music" should be stopped just a little bit sooner
  LDA #$0000
  JSL $808FC1
  ; LDA #$0001
  ; JSL $809021
  RTS
}
warnpc $8BDB5C


; Cinematic instruction $F32B
; This skips changing the background color to white
org $8BF32B
{
  PHY

  LDA #$DB9E   ;\
  STA $1F51    ;} Cinematic function = $DB9E
  LDA #$0078   ;\
  STA $1A49    ;} Cinematic function timer = 120
  PLY
  RTS
}
warnpc $8BF35A

org $8BDBBD
JMP play_stardrive_sound_and_transition_to_dbc4

org !FREESPACE_8B

play_stardrive_sound_and_transition_to_dbc4:
{
  LDA #$DBC4
  STA $1F51

  ; Play power bomb explosion sound for stardrive engaged
  ; (this is the same sound that is played when Samus's ship leaves
  ; Ceres station)
  LDA #$0001
  JSL $809021

  RTS
}

end_escape_freespace_8b:
!FREESPACE_8B := end_escape_freespace_8b

; Cinematic function $DB4C
; Skip setting math subscreen backdrop color so we don't cut to white
org $8BDBE1
{
  JMP $DBED
}
warnpc $8BDBED

; Increase number of frames of big planet fade-out before we force a transition
; (the actual transition is handled by cinematic sprite object $EE9D)
org $8BD9F5
; LDA #$003F
LDA #$007F

; Make big planet zoom out more slowly
org $8BDA1E
; ADC #$0004
ADC #$0004

; Fade out every 4 frames instead of every frame
org $8BDA27
; BIT #$0001
; BNE $1E
BIT #$0003
BNE $1E
