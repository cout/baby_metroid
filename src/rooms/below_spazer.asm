; TODO TODO TODO -
; Below code freezes the enemies in the room, but this code crashes
; sometimes, so there needs to be an easier way through the room

;;;   !room_initialized = $7FFB02
;;;   
;;;   ;;
;;;   ; Set main room handler
;;;   
;;;   org $8FA427
;;;   
;;;   dw below_spazer_main_handler
;;;   
;;;   org $8FA42D
;;;   
;;;   dw below_spazer_init
;;;   
;;;   ;;
;;;   ; Keep all the enemies in the room frozen
;;;   
;;;   org !FREESPACE_8F
;;;   
;;;   copy_ice_palette:
;;;   {
;;;     LDA $90C401 : STA $7EC120 : STA $7EC140
;;;     LDA $90C403 : STA $7EC122 : STA $7EC142
;;;     LDA $90C405 : STA $7EC124 : STA $7EC144
;;;     LDA $90C407 : STA $7EC126 : STA $7EC146
;;;     LDA $90C409 : STA $7EC128 : STA $7EC148
;;;     LDA $90C40B : STA $7EC12A : STA $7EC14A
;;;     LDA $90C40D : STA $7EC12C : STA $7EC14C
;;;     LDA $90C40F : STA $7EC12E : STA $7EC14E
;;;     LDA $90C411 : STA $7EC130 : STA $7EC150
;;;     LDA $90C413 : STA $7EC132 : STA $7EC152
;;;     LDA $90C415 : STA $7EC134 : STA $7EC154
;;;     LDA $90C417 : STA $7EC136 : STA $7EC156
;;;     LDA $90C419 : STA $7EC138 : STA $7EC158
;;;     LDA $90C41B : STA $7EC13A : STA $7EC15A
;;;     LDA $90C41D : STA $7EC13C : STA $7EC15C
;;;     LDA $90C41F : STA $7EC13E : STA $7EC15E
;;;   
;;;     RTS
;;;   }
;;;   
;;;   below_spazer_main_handler:
;;;   {
;;;     LDA !room_initialized
;;;     BEQ .return
;;;   
;;;     LDA #$0001
;;;     STA $185E ; set "enemy time is frozen" flag
;;;   
;;;     JSR copy_ice_palette
;;;   
;;;     LDA #$0000
;;;     STA !room_initialized
;;;   
;;;   .return
;;;     RTS
;;;   }
;;;   
;;;   below_spazer_init:
;;;   {
;;;     LDA #$0001
;;;     STA !room_initialized
;;;   
;;;     RTS
;;;   }
