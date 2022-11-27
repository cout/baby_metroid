;;
; Increase required health for ridley to fly away
org $A6A6F4
CMP #$0777

;;
; Disable ceres escape timer
;
; TODO - now Samus can't get out!

org $A6C0BB

;; ; Spawn save station electricity enemy projectile
;; ; TODO - this does not work
;; LDX $1C27 ; what is this for?
;; LDY #$E6D2
;; JSL $868097 ; room graphics
;; ; JSL $868097 ; enemy graphics

; Made it to Ceres elevator
; TODO - I would like this to be "beam out" sequence instead of immediately
; fading to black
LDA #$0020
STA $0998

RTS
