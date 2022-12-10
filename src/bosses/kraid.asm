;;
; Disable Kraid spitting rocks
;

org $A7BC14 ; jsr for spawn rock projectile

BRA .earthquake_sound

org $A7BC1B

.earthquake_sound:

;;
; Disable lunging
;

org $A786F3 ; walk forward

dw $B633, $812F

org $A787BD ; lunge forward

dw $B633, $812F

org $A78887 ; walk backward

dw $B633, $812F

;;
; Play elevator music instead of boss music
;

org $A7C8AF

LDA #$0003

;;
; Clear the spikes and unfix the camera
;

org $A7A9E7

JSR $C171

;;
; Replace Kraid roar with a less intimidating sound
;

org $A7AF95

LDA #$0060

;;;   ;;
;;;   ; Change Kraid eye color
;;;   ;
;;;
;;;   ; Red eyes (original)
;;;   ; !kraid_eye1 = $559D
;;;   ; !kraid_eye2 = $1816
;;;   ; !kraid_eye3 = $100D
;;;
;;;   ; Blue eyes
;;;   ; !kraid_eye1 = $666E
;;;   ; !kraid_eye2 = $5186
;;;   ; !kraid_eye3 = $4124
;;;
;;;   ; Purple eyes
;;;   ; !kraid_eye1 = $55F5
;;;   ; !kraid_eye2 = $3D4E
;;;   ; !kraid_eye3 = $30CB
;;;
;;;   ; Kraid palette (referenced in enemy header)
;;;   org $A78687 : skip 2 : dw !kraid_eye1, !kraid_eye2, !kraid_eye3
;;;
;;;   ; Kraid BG palette 7
;;;   org $A7B3F3 : skip 2 : dw !kraid_eye1, !kraid_eye2, !kraid_eye3
;;;   org $A7B413 : skip 2 : dw !kraid_eye1, !kraid_eye2, !kraid_eye3
;;;   org $A7B433 : skip 2 : dw !kraid_eye1, !kraid_eye2, !kraid_eye3
;;;   org $A7B453 : skip 2 : dw !kraid_eye1, !kraid_eye2, !kraid_eye3
;;;   org $A7B473 : skip 2 : dw !kraid_eye1, !kraid_eye2, !kraid_eye3
;;;   org $A7B493 : skip 2 : dw !kraid_eye1, !kraid_eye2, !kraid_eye3
;;;   org $A7B4B3 : skip 2 : dw !kraid_eye1, !kraid_eye2, !kraid_eye3
;;;   org $A7B4D3 : skip 2 : dw !kraid_eye1, !kraid_eye2, !kraid_eye3
;;;
;;;   ; ; Kraid sprite palette 7
;;;   ; org $A7B533 : skip 2 : dw !kraid_eye1, !kraid_eye2, !kraid_eye3
;;;   ; org $A7B553 : skip 2 : dw !kraid_eye1, !kraid_eye2, !kraid_eye3
;;;   ; org $A7B573 : skip 2 : dw !kraid_eye1, !kraid_eye2, !kraid_eye3
;;;   ; org $A7B593 : skip 2 : dw !kraid_eye1, !kraid_eye2, !kraid_eye3
;;;   ; org $A7B5B3 : skip 2 : dw !kraid_eye1, !kraid_eye2, !kraid_eye3
;;;   ; org $A7B5D3 : skip 2 : dw !kraid_eye1, !kraid_eye2, !kraid_eye3
;;;   ; org $A7B5F3 : skip 2 : dw !kraid_eye1, !kraid_eye2, !kraid_eye3
;;;   ; org $A7B613 : skip 2 : dw !kraid_eye1, !kraid_eye2, !kraid_eye3
;;;
;;;   org $A7AC24
;;;
;;;   ; Patch init routine to set palette correctly
;;;   JSR $B394
