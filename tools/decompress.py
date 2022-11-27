#!/usr/bin/env python3

import sys
from lc_lz3 import decompress

def main():
  compressed = bytearray(sys.stdin.buffer.read())
  decompressed = decompress(compressed)
  sys.stdout.buffer.write(decompressed)

if __name__ == '__main__':
  main()
