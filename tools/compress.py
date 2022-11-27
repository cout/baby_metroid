#!/usr/bin/env python3

import sys
from lc_lz3 import compress

def main():
  decompressed = bytearray(sys.stdin.buffer.read())
  compressed = compress(decompressed)
  sys.stdout.buffer.write(compressed)

if __name__ == '__main__':
  main()


