pushtable

%use_intro_text_table()

org !intro_text_page_1
{
  dw !intro_text_begin
  dw $0401, "THIS IS A TEST"
  dw $0601, "LINE TWO..."
  dw !intro_text_end
  dw !intro_text_page_1_wait
  dw !intro_text_delete
}

pulltable
