;;;;;;
;
; Easier cinematic intro text
;
;
; Example:
;
; pushtable
; %use_intro_text_table
; org !intro_text_page_1
; {
;   dw !intro_text_begin
;   dw $0401, "LINE ONE"
;   dw $0601, "LINE TWO..."
;   dw !intro_text_end
;   dw !intro_text_page_1_wait
;   dw !intro_text_delete
; }
; pulltable
;
;;;;;;

!intro_text_page_1 = $8CC383
!intro_text_page_2 = $8CC797
!intro_text_page_3 = $8CCB45
!intro_text_page_4 = $8CCE33
!intro_text_page_5 = $8CD15D
!intro_text_page_6 = $8CD511

macro use_intro_text_table()
{
  ' ' = $D67D  ; 
  'o' = $D683  ; nothing
  'A' = $D685  ; 
  'B' = $D68B  ; 
  'C' = $D691  ; 
  'D' = $D697  ; 
  'E' = $D69D  ; 
  'F' = $D6A3  ; 
  'G' = $D6A9  ; 
  'H' = $D6AF  ; 
  'I' = $D6B5  ; 
  'J' = $D6BB  ; 
  'K' = $D6C1  ; 
  'L' = $D6C7  ; 
  'M' = $D6CD  ; 
  'N' = $D6D3  ; 
  'O' = $D6D9  ; 
  'P' = $D6DF  ; 
  'Q' = $D6E5  ; 
  'R' = $D6EB  ; 
  'S' = $D6F1  ; 
  'T' = $D6F7  ; 
  'U' = $D6FD  ; 
  'V' = $D703  ; 
  'W' = $D709  ; 
  'X' = $D70F  ; 
  'Y' = $D715  ; 
  'Z' = $D71B  ; 
  '0' = $D721  ; 
  '1' = $D727  ; 
  '2' = $D72D  ; 
  '3' = $D733  ; 
  '4' = $D739  ; 
  '5' = $D73F  ; 
  '6' = $D745  ; 
  '7' = $D74B  ; 
  '8' = $D751  ; 
  '9' = $D757  ; 
  '.' = $D75D  ;  (full stop)
  ',' = $D763  ; 
  '*' = $D769  ;  (decimal point)
  ''' = $D76F  ; 
  ':' = $D775  ; 
  '!' = $D77B  ; 
}
endmacro

!intro_text_page_1_wait = $AE5B
!intro_text_page_2_wait = $AE91
!intro_text_page_3_wait = $B08C
!intro_text_page_4_wait = $B0CB
!intro_text_page_5_wait = $B1B3
!intro_text_page_6_end = $B240
!intro_text_pause = $0080,$0101,$D683
!intro_text_blinking_cursor = $ADD4
!intro_text_delete = $9698
!intro_text_begin = intro_text_begin
!intro_text_end = intro_text_end

org !FREEMEM_7F

intro_text_pointer:
print "Variable intro_text_pointer: ", pc
skip 8

intro_text_position:
print "Variable intro_text_position: ", pc
skip 8

end_intro_text_freemem_7f:
!FREEMEM_7F := end_intro_text_freemem_7f

%BEGIN_FREESPACE(8B)

intro_text_begin:
{
  TYA
  STA intro_text_pointer,x

  ; Advance the instruction pointer to the end of the text
.loop:
  INY
  INY
  LDA $0000,y
  CMP.w #intro_text_end
  BNE .loop

  ; Set the timer
  LDA #$0005
  STA $19DD,x

  RTS
}

intro_text_end:
  ; Get next character
  LDA intro_text_pointer,x
  PHY
  TAY
  LDA $0000,y
  PLY

  ; Test if we are at the end
  CMP.w #intro_text_end
  BEQ .return

  ; If this is cursor coordinates then move the cursor
  CMP #$0000
  BMI .draw
  STA intro_text_position,x
  LDA intro_text_pointer,x
  INC
  INC
  STA intro_text_pointer,x
  PHY
  TAY
  LDA $0000,y
  PLY

.draw:
  ; Character to draw
  STA $19B5,x

  ; Set position and advance screen cursor
  LDA intro_text_position,x
  STA $12
  INC
  STA intro_text_position,x

  ; Spawn glow text for the next character
  JSR $8839

  ; Move the cursor
  PHY
  LDY #$001E
  LDA intro_text_position,x
  AND #$00FF
  ASL A
  ASL A
  ASL A
  STA $1A7D,y
  LDA intro_text_position+$01,x
  AND #$00FF
  ASL A
  ASL A
  ASL A
  SEC
  SBC #$0008
  STA $1A9D,y
  PLY

  ; Advance pointer
  LDA intro_text_pointer,x
  INC
  INC
  STA intro_text_pointer,x

  ; Ensure this instruction is executed again next time
  DEY
  DEY

.return:
  ; Reset timer
  LDA #$0005
  STA $19DD,x

  ; Update instruction list pointer
  TYA
  STA $19CD,x

  ; Pop return address that would have ensured execution of the next
  ; indirect instruction
  PLA
  PLB

  ; Pop B that was pushed at the top of the calling routine
  RTS
}

%END_FREESPACE(8B)
