#!/usr/bin/env python3

import sys

def bgr555(x):
  rr = (x & 0xff0000) >> 16
  gg = (x & 0x00ff00) >> 8
  bb = (x & 0x0000ff)
  r = rr >> 3
  g = gg >> 3
  b = bb >> 3
  bgr555 = (b << 10) | (g << 5) | r
  return bgr555

def main():
  for arg in sys.argv[1:]:
    x = int(arg, 16)
    print('%06x -> %04x' % (x, bgr555(x)))

if __name__ == '__main__':
  main()
