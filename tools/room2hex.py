#!/usr/bin/env python3

import sys
import struct
import re

final_format = \
'''
; Size:
; {width_s} screens x {height_s} screens
; ({width_t} tiles x {height_t} tiles, {bytes} bytes)
{size}

; Tilemap:
{tilemap}

; BTS:
{bts}
'''

layer2_format = \
'''
; Layer 2 Tilemap:
{layer2_tilemap}
'''

def split_into_rows(l, w, h):
  return [ l[i:i+w] for i in range(0, h*w, w) ]

def format_row(row, fmt):
  return ' '.join(fmt % x for x in row)

def format_rows(rows, fmt):
  return [ format_row(row, fmt) for row in rows ]

def add_seps(rows):
  srows = [ ]

  for i in range(0, len(rows)):
    row = rows[i]
    row = re.sub('(([A-Za-z0-9]+ ){15}[A-Za-z0-9]+) ', '\\1|', row)
    srows.append(row)

    if i % 16 == 15:
      sep = re.sub('[A-Za-z0-9 .]', '-', row)
      sep = re.sub('[|]', '+', sep)
      srows.append(sep)

  return srows

def format_grid(rows, fmt):
  rows = format_rows(rows, fmt)
  rows = add_seps(rows)
  return '\n'.join(rows)

def format_tilemap(tilemap, w, h):
  rows = split_into_rows(tilemap, w, len(tilemap)//w)
  return format_grid(rows, '%04X')

def format_bts(bts, w, h):
  rows = split_into_rows(bts, w, len(bts)//w)
  return format_grid(rows, ' %02X ')

def room2hex(level_data, w, h):
  tilemap_bytes = level_data.size * 2
  hex_size = '%02X %02X' % (tilemap_bytes & 0xff, tilemap_bytes >> 8)
  hex_tilemap = format_tilemap(level_data.tilemap, w, h)
  hex_bts = format_bts(level_data.bts, w, h)
  s = final_format.format(
      width_s=w//16,
      height_s=h//16,
      width_t=w,
      height_t=h,
      bytes=w*h*2,
      size=hex_size,
      tilemap=hex_tilemap,
      bts=hex_bts,
  ).lstrip()
  if level_data.layer2_tilemap is not None:
    hex_layer2_tilemap = format_tilemap(level_data.layer2_tilemap, w, h)
    s += layer2_format.format(layer2_tilemap=hex_layer2_tilemap)
  return s

def main():
  from structures import RoomLevelData

  ws = int(sys.argv[1])
  hs = int(sys.argv[2])
  w = ws * 16
  h = hs * 16
  b = sys.stdin.buffer.read()
  size, tilemap, bts, layer2_tilemap = RoomLevelData.bin2room(b)
  level_data = RoomLevelData(size, tilemap, bts, layer2_tilemap)
  s = room2hex(level_data, w, h)
  sys.stdout.write(s)

if __name__ == '__main__':
  main()
