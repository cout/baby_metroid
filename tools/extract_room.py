#!/usr/bin/env python3

import sys

from rom import Rom
from lc_lz3 import decompress
from room2hex import room2hex
from structures import RoomHeader, RoomStateHeader

def main():
  filename = sys.argv[1]
  room_id = int(sys.argv[2], 16)
  state_idx = int(sys.argv[3]) if len(sys.argv) >= 4 else 0
  verbose = False

  rom = Rom(open(filename, 'rb'))

  room_header = RoomHeader.extract(rom, room_id)
  if verbose: print(room_header)

  state_id = room_header.state_functions[state_idx].state_header_addr
  if verbose: print(state_id)
  room_state_header = RoomStateHeader.extract(rom, state_id)
  if verbose: print(room_state_header)

  rom.seek(room_state_header.level_data_addr)
  room = decompress(rom.read(0x4000))
  print(room2hex(room, room_header.w * 16, room_header.h * 16))

if __name__ == '__main__':
  main()
