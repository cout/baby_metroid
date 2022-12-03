#!/usr/bin/env python3

import sys
import re

def strip_comments(s):
  return re.sub('\s*;.*(?=\n|\r)', '', s, re.MULTILINE)

def replace_non_hex_with_whitespace(s):
  return re.sub('[^A-Za-z0-9]', ' ', s)

def long_to_little_endian(s):
  return re.sub('\\b([A-Za-z0-9]{2})([A-Za-z0-9]{2})([A-Za-z0-9]{2})\\b', '\\3 \\2 \\1', s)

def short_to_little_endian(s):
  return re.sub('\\b([A-Za-z0-9]{2})([A-Za-z0-9]{2})\\b', '\\2 \\1', s)

def hex2bin(s):
  s = strip_comments(s)
  s = replace_non_hex_with_whitespace(s)
  s = long_to_little_endian(s)
  s = short_to_little_endian(s)
  l = [ int(x, 16) for x in s.split() ]
  b = bytes(l)
  return bytearray(b)

def main():
  s = sys.stdin.read()
  b = hex2bin(s)
  sys.stdout.buffer.write(b)

if __name__ == '__main__':
  main()
