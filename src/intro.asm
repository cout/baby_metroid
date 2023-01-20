pushtable

%use_intro_text_table()

;;;;;;;;;; TEXT ;;;;;;;;;;

; I first battled the metroids
; on planet Zebes. It was there
; that I foiled the plans of
; the space pirate leader
; Mother Brain to use the
; creater to attack
; Galactic Civilization...

; I next fought the metroids on
; their home world, SR388. I
; completely eradicated them
; except for a larva, which
; after hatching followed me
; like a confused child...

org !intro_text_page_3
{
  dw !intro_text_begin
  dw $0401, "I DELIVERED IT TO SCIENTISTS"
  dw $0601, "AT CERES STATION FOR STUDY,"
  dw $0801, "BUT AS SOON AS I HAD LEFT"
  dw $0A01, "THE STATION, THE SPACE"
  dw $0C01, "PIRATES CAME TO TAKE THE"
  dw $0E01, "BABY METROID, DESTROYING THE"
  dw $1001, "STATION AND EVERYONE ON IT..."
  dw !intro_text_end
  dw !intro_text_page_3_wait
  dw !intro_text_delete
}

org !intro_text_page_4
{
  dw !intro_text_begin
  dw $0401, "I FOUND THE BABY, NOW FULLY"
  dw $0601, "GROWN, DEEP IN MOTHER BRAIN'S"
  dw $0801, "HIDEOUT. I INTENDED TO BRING"
  dw $0A01, "THE ADOLESCENT METROID TO"
  dw $0C01, "SAFETY, BUT IN THE END IT WAS"
  dw $0E01, "I WHO NEEDED SAVING..."
  dw !intro_text_end
  dw !intro_text_page_4_wait
  dw !intro_text_delete
}

;;;;;;;;;; SCENE 3 ;;;;;;;;;;

org $8BB100
LDA #$C11B
STA $1F51
RTS

org $8BC2B8
JSR ceres_station_cutscene_queue_music
RTS

org $8BC37B
JMP ceres_station_falls_init_next_state

org $8BC603
JMP start_intro_page_4

org !FREESPACE_8B

ceres_station_cutscene_queue_music:
{
  LDA $0998
  CMP #$001E : BEQ .ceres_flashback

.ceres_boom_or_escape:
  LDA #$0000 : JSL $808FC1 ; Stop music
  LDA #$FF2D : JSL $808FC1 ; Queue Ceres music data

  LDA $0998
  CMP #$0025 : BNE .ceres_escape

.ceres_flashback:
; TODO - to crossfade into the next scene do something like in $8B:B018

  RTS

.ceres_boom:
  LDA #$0008
  LDY #$000E
  JSL $808FF7
  RTS

.ceres_escape:
  LDA #$0007
  LDY #$000E
  JSL $808FF7
  RTS

  RTS

}

ceres_station_falls_init_next_state:
{
  ; TODO: we want this scene in B&W

  LDA $0998
  CMP #$001E
  BEQ .intro

.cutscene:
  LDA $1993
  JMP $C37E

.intro:
  ; skip the power bomb explosion
  JMP $C3A5
  RTS
}

start_intro_page_4:
{
  JSR $A395 ; TODO: this also stops music...
  JSR $A66F
  LDA.w #wait_for_fade_in_page_4
  STA $1F51
  RTS
}

wait_for_fade_in_page_4:
{
  ; wait for music to be not queued (TODO - we don't want this)
  JSL $808EF4
  BCS .return

  ; advance fade in and return if not max brightness
  ; JSR $911B
  ; BCC .return

  ; force max brightness
  ; TODO - the next scene fades in with a cross-fade, so I think we need
  ; to initialize that correctly
  SEP #$30
  LDA #$0F
  STA $51
  REP #$30

  ; Set enemy projectile X position; this also serves as a sentinel to
  ; indicate that the Mother Brain fight scene has completed (I think?)
  LDA #$007F
  STA $1A4B

  JMP $B346 ; start intro page 4

.return:
  RTS
}

end_intro_scene_3_freespace_8B:
!FREESPACE_8B := end_intro_scene_3_freespace_8B

;;;;;;;;;; SCENE 4 ;;;;;;;;;;

org $8BB131
JSR set_up_new_mother_brain_fight
RTS

org !FREESPACE_8B

set_up_new_mother_brain_fight:
{
  LDA $1BA3              ;\
  BEQ .aec2              ;} If [intro Japanese text timer] != 0:
  DEC A                  ;\
  STA $1BA3              ;} Decrement intro Japanese text timer
  RTS

.aec2:
  LDA $8F                ;\
  BNE .aec7              ;} If not newly pressed anything:
  RTS                    ; Return

.aec7:
  SEP #$20
  LDA #$50               ;\
  STA $58                ;} BG1 tilemap base address = $5000, size = 32x32
  REP #$20
  LDA #$0002             ;\
  STA $0A1C              ;} Samus pose = facing left - normal
  JSL $91F433            ; Execute $91:F433
  JSL $91FB08            ; Set Samus animation frame if pose changed
  LDA $0A20              ;\
  STA $0A24              ;} Samus last different pose = [Samus previous pose]
  LDA $0A22              ;\
  STA $0A26              ;} Samus last different pose X direction / movement type = [Samus previous pose X direction / movement type]
  LDA $0A1C              ;\
  STA $0A20              ;} Samus previous pose = [Samus pose]
  LDA $0A1E              ;\
  STA $0A22              ;} Samus previous pose X direction / movement type = Samus pose X direction / movement type
  LDA #$009B             ;\
  STA $0AF6              ;} Samus X position = 9Bh
  STA $0B10              ; Samus previous X position = [Samus X position]
  LDA #$0073             ;\
  STA $0AFA              ;} Samus Y position = 73h
  STA $0B14              ; Samus previous Y position = [Samus Y position]
  STZ $1993              ; $1993 = 0
  LDA #$007F
  STA $1A4B
  ; LDY #$CE55             ;\
  ; STZ $12                ;} Spawn cinematic sprite object $CE55 to index 0 (intro Mother Brain)
  ; JSR $93A2              ;/
  ; LDY #$CF27             ;\
  ; JSR $938A              ;} Spawn cinematic sprite object $CF27 (rinka spawner)
  ; LDX #$0000             ;\

.af21:                   ;|
  ; LDA $8CBEC3,x          ;|
  LDA scene_4_level_data,x
  STA $7F0002,x          ;|
  INX                    ;} Level data = [$8C:BEC3..C082] (old Mother Brain room)
  INX                    ;|
  CPX #$01C0             ;|
  BMI .af21              ;/
  LDX #$0000             ;\
  LDA #$0000             ;|

.af36:                   ;|
  STA $7F6402,x          ;|
  INX                    ;} BTS = 0
  INX                    ;|
  CPX #$0200             ;|
  BMI .af36              ;/

  LDA #$0001             ;\
  STA $09D2              ;} HUD item index = missiles
  LDA #$E6C9             ;\
  STA $0A42              ;} $0A42 = $E6C9 (demo)
  LDA #$E833             ;\
  STA $0A44              ;} $0A44 = $E833 (intro demo)
  JSL $918370            ; Execute $91:8370
  JSL $91834E            ; Execute $91:834E (Set up Samus for game input)
  LDY #$8784             ; Y = $8784
  JSL $918395            ; Execute $91:8395 (Load demo input object)
  LDA #$FFFF             ;\
  STA $1A57              ;} Set Samus to be displayed over cinematic sprite objects
  ; JMP $B018              ; Go to set up intro crossfade into Samus gameplay
  JSR $B018

  LDA.w #cinematic_function_start_new_mother_brain_fight
  STA $1F51

  RTS
}

cinematic_function_start_new_mother_brain_fight:
{
  JSR $B250
  RTS
}

end_intro_scene_4_freespace_8B:
!FREESPACE_8B := end_intro_scene_4_freespace_8B

org $8BB2CA
RTS

org !FREESPACE_8C

pushtable
' ' = $0000
'8' = $8000
'1' = $1000

scene_4_level_data:
{
  ; dw "                "
  ; dw "8888888888888888"
  ; dw "888888   8      "
  ; dw "888888  888     "
  ; dw "88888           "
  ; dw "888888          "
  ; dw "8888            "
  ; dw "8888            "
  ; dw "8888     1  1111"
  ; dw "888888   8  8888"
  ; dw "8888888  8      "
  ; dw "8888888  8      "
  ; dw "8888888  88     "
  ; dw "8888888888888888"
  dw "                "
  dw "8888888888888888"
  dw "8               "
  dw "8               "
  dw "8               "
  dw "8               "
  dw "8               "
  dw "8               "
  dw "8               "
  dw "8               "
  dw "8               "
  dw "8111111111111111"
  dw "8888888888888888"
  dw "8888888888888888"
}

pulltable

end_intro_scene_4_freespace_8c:
!FREESPACE_8C := end_intro_scene_4_freespace_8c

pulltable
