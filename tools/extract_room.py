#!/usr/bin/env python3

import sys

from rom import Rom
from lc_lz3 import decompress
from room2hex import room2hex
from structures import RoomHeader, RoomStateHeader, RoomLevelData

# TODO: A tilemap _may_ be used by multiple states
header = \
'''
; Room ID: {room:X}
; Map position: ({x}, {y})
;
; State: {state:X}
; Tilemap: {tilemap:X} .. {end_tilemap:X}
; Tileset: {tileset:X}
; Enemy population: {enemy_pop:X}
; Enemy graphics set: {enemy_gfx_set:X}
; Setup routine: {setup_routine:X}
; Main routine: {main_routine:X}
'''

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

  level_data = RoomLevelData.extract(rom, room_state_header.level_data_addr)

  tilemap = room_state_header.level_data_addr
  tilemap_size = len(level_data.tilemap) + len(level_data.bts)
  if level_data.layer2_tilemap is not None: tilemap_size += len(level_data.layer2_tilemap)
  end_tilemap = tilemap + tilemap_size

  print(header.format(
    room=room_id,
    x=int(room_header.x),
    y=int(room_header.y),
    state=state_id,
    tilemap=tilemap,
    end_tilemap=end_tilemap,
    tileset=room_state_header.tileset,
    enemy_pop=room_state_header.enemy_pop_addr,
    enemy_gfx_set=room_state_header.enemy_graphics_set_addr,
    setup_routine=room_state_header.room_setup_func,
    main_routine=room_state_header.room_main_func,
  ).lstrip())
  print(room2hex(level_data, room_header.w * 16, room_header.h * 16))

if __name__ == '__main__':
  main()
