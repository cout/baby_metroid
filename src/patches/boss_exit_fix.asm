org !FREESPACE_8F

boss_exit_fix:
{
  STZ $0E1E
  RTS
}

phantoon_boss_exit_fix:
{
  JSR boss_exit_fix
  JMP $E1FE
}

boss_exit_fix_end_freespace_8f:
!FREESPACE_8F := boss_exit_fix_end_freespace_8f

org $83A2C4 ; door header for phantoon to basement
skip 10     ; custom door asm
dw phantoon_boss_exit_fix
