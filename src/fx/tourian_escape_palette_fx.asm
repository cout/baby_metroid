namespace tourian_escape_palette_fx

I_goto = $8DC61E
I_adv_8 = $8DC5AB
I_done = $8DC595
function I_delay(x) = x

org $8DF941

org $8DF94D
{
.top:
  ; dw I_delay(2), $5294, $39CE, $2108, $1084, $0019, $0012, I_adv_8, $7FFF, I_done
  ; dw I_delay(2), $4E75, $35AF, $1CE8, $0C64, $080D, $0809, I_adv_8, $77BF, I_done
  ; dw I_delay(2), $4A55, $318F, $1CE9, $0C64, $1000, $1000, I_adv_8, $739F, I_done
  ; dw I_delay(2), $4636, $2D70, $18C9, $0844, $080D, $0809, I_adv_8, $6B5F, I_done
  ; dw I_delay(2), $3DF6, $2D70, $18CA, $0844, $0019, $0012, I_adv_8, $673F, I_done
  ; dw I_delay(2), $39D7, $2951, $14AA, $0424, $080D, $0809, I_adv_8, $5EFF, I_done
  ; dw I_delay(2), $35B7, $2531, $14AB, $0424, $1000, $1000, I_adv_8, $5ADF, I_done
  ; dw I_delay(2), $3198, $2112, $108B, $0004, $080D, $0809, I_adv_8, $529F, I_done
  ; dw I_delay(2), $35B7, $2531, $14AB, $0424, $1000, $1000, I_adv_8, $5ADF, I_done
  ; dw I_delay(2), $39D7, $2951, $14AA, $0424, $080D, $0809, I_adv_8, $5EFF, I_done
  ; dw I_delay(2), $3DF6, $2D70, $18CA, $0844, $0019, $0012, I_adv_8, $673F, I_done
  ; dw I_delay(2), $4636, $2D70, $18C9, $0844, $080D, $0809, I_adv_8, $6B5F, I_done
  ; dw I_delay(2), $4A55, $318F, $1CE9, $0C64, $1000, $1000, I_adv_8, $739F, I_done
  ; dw I_delay(2), $4E75, $35AF, $1CE8, $0C64, $080D, $0809, I_adv_8, $77BF, I_done
  dw I_delay(8), $5294, $39CE, $2108, $1084, $0019, $0012, I_adv_8, $7FFF, I_done
  dw I_delay(8), $4E75, $35AF, $1CE8, $0C64, $0019, $0012, I_adv_8, $77BF, I_done
  dw I_delay(8), $4A55, $318F, $1CE9, $0C64, $0413, $040D, I_adv_8, $739F, I_done
  dw I_delay(8), $4636, $2D70, $18C9, $0844, $080D, $0809, I_adv_8, $6B5F, I_done
  dw I_delay(8), $3DF6, $2D70, $18CA, $0844, $0C06, $0C04, I_adv_8, $673F, I_done
  dw I_delay(8), $39D7, $2951, $14AA, $0424, $1000, $1000, I_adv_8, $5EFF, I_done
  dw I_delay(8), $35B7, $2531, $14AB, $0424, $1000, $1000, I_adv_8, $5ADF, I_done
  dw I_delay(8), $3198, $2112, $108B, $0004, $1000, $1000, I_adv_8, $529F, I_done
  dw I_delay(8), $35B7, $2531, $14AB, $0424, $1000, $1000, I_adv_8, $5ADF, I_done
  dw I_delay(8), $39D7, $2951, $14AA, $0424, $1000, $1000, I_adv_8, $5EFF, I_done
  dw I_delay(8), $3DF6, $2D70, $18CA, $0844, $0C06, $0C04, I_adv_8, $673F, I_done
  dw I_delay(8), $4636, $2D70, $18C9, $0844, $080D, $0809, I_adv_8, $6B5F, I_done
  dw I_delay(8), $4A55, $318F, $1CE9, $0C64, $0413, $040D, I_adv_8, $739F, I_done
  dw I_delay(8), $4E75, $35AF, $1CE8, $0C64, $0019, $0012, I_adv_8, $77BF, I_done
  dw I_goto, .top
}

namespace off
