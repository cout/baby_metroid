; Disallow toggling of text language (force English)
org $82EDDA
STZ $09E2
JMP $EDED

; Force English when loading a save file
org $8180E8
JSR load_map

org !FREESPACE_81

load_map:
{
  STZ $09E2
  JMP $82E4
}

end_english_only_freespace_81:
!FREESPACE_81 := end_english_only_freespace_81
