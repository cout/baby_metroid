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

def bin2room(b):
  size, = struct.unpack('<H', b[0:2])
  size = size // 2
  fmt = '%dH%dB' % (size, size)
  l = struct.unpack(fmt, b[2:])
  tilemap = l[0:size]
  bts = l[size:]
  return size, tilemap, bts

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
  rows = split_into_rows(tilemap, w, h)
  return format_grid(rows, '%04X')

def format_bts(bts, w, h):
  rows = split_into_rows(bts, w, h)
  return format_grid(rows, ' %02X ')

def room2hex(b, w, h):
  size, tilemap, bts = bin2room(b)
  tilemap_bytes = size * 2
  hex_size = '%02X %02X' % (tilemap_bytes & 0xff, tilemap_bytes >> 8)
  hex_tilemap = format_tilemap(tilemap, w, h)
  hex_bts = format_bts(bts, w, h)
  return final_format.format(
      width_s=w//16,
      height_s=h//16,
      width_t=w,
      height_t=h,
      bytes=w*h*2,
      size=hex_size,
      tilemap=hex_tilemap,
      bts=hex_bts,
  ).lstrip()

def main():
  ws = int(sys.argv[1])
  hs = int(sys.argv[2])
  w = ws * 16
  h = hs * 16
  b = sys.stdin.buffer.read()
  s = room2hex(b, w, h)
  sys.stdout.write(s)

if __name__ == '__main__':
  main()
