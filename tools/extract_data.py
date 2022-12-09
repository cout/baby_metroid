#!/usr/bin/env python3

import sys

from rom import Rom

def main():
  filename = sys.argv[1]
  start = sys.argv[2].replace(':', '')
  end = sys.argv[3].replace(':', '')

  rom = Rom(open(filename, 'rb'))
  rom.seek(int(start, 16))
  b = rom.read_until(int(end, 16))
  sys.stdout.buffer.write(b)

if __name__ == '__main__':
  main()
