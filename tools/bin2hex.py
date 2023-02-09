#!/usr/bin/env python3

import sys
import struct
import re

from room2hex import format_tilemap

def main():
  if len(sys.argv) != 3:
    print("Usage: bin2hex.py <w>")
    sys.exit(1)

  w = int(sys.argv[1])
  b = sys.stdin.buffer.read()
  size = len(b) / 2
  fmt = '%dH' % size
  tilemap = struct.unpack(fmt, b)
  s = '; %d bytes\n' % len(b)
  s += format_tilemap(tilemap, w)
  s += '\n'
  s += '; vim:ft=roomhex'
  sys.stdout.write(s)

if __name__ == '__main__':
  main()
