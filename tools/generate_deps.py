#!/usr/bin/env python3

import sys
import re
import os.path

def deps(input, rel_path):
  result = [ ]
  for line in input:
    m = re.match('^\s*incsrc\s+"([^"]+)"$', line)
    if m:
      filename = find_file(m.group(1), rel_path)
      result.append(filename)
      result.extend(filedeps(filename))
      continue

    m = re.match('^\s*incsrc\s+(\S+)$', line)
    if m:
      filename = find_file(m.group(1), rel_path)
      result.append(filename)
      result.extend(filedeps(filename))
      continue

    m = re.match('^\s*incbin\s+"([^"]+)"$', line)
    if m:
      filename = find_file(m.group(1), rel_path)
      result.append(filename)
      continue

    m = re.match('^\s*incbin\s+(\S+)$', line)
    if m:
      filename = find_file(m.group(1), rel_path)
      result.append(filename)
      continue

  return result

def find_file(filename, rel_path):
  rel_filename = os.path.join(rel_path, filename)
  if os.path.exists(rel_filename):
    return rel_filename

  if os.path.exists(filename):
    return filename

  raise RuntimeError("Could not find %s in %s or %s" % (filename,
    rel_path, os.path.abspath('.')))

def filedeps(filename):
  with open(filename) as infile:
    rel_path = os.path.dirname(os.path.abspath(filename))
    return deps(infile, rel_path)

def main():
  for filename in sys.argv[1:]:
    filename = find_file(filename, '.')
    print(filename, ' '.join(filedeps(filename)))

if __name__ == '__main__':
  main()

