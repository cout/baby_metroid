#!/usr/bin/env python3

import sys
import re

def main():
  s = sys.stdin.read()
  # s = s.replace(',', ' ')
  # s = s.replace('|', ' ')
  # s = s.replace('+', ' ')
  # s = s.replace('-', ' ')
  s = re.sub('[^A-Za-z0-9]', ' ', s)
  l = [ int(x, 16) for x in s.split() ]
  b = bytes(l)
  sys.stdout.buffer.write(bytearray(b))

if __name__ == '__main__':
  main()
