Commands used to extract title graphics:

```
$TOOLS/extract_data.py \
  super_metroid.sfc 9580D8 95A5E1 \
  | ./tools/decompress.py \
  > title_tiles.chr

$TOOLS/extract_data.py \
  super_metroid.sfc 8CE2E9 8CE309 \
  > title_palette_8ce2e9.pal

$TOOLS/chrgfx/build/chr2png/chr2png \
  -G $TOOLS/chrgfx/gfxdef/gfxdefs \
  -P nintendo_sfc \
  -c title_tiles.chr \
  -o title_tiles.png \
  -p title_palette_8ce2e9.pal
```
