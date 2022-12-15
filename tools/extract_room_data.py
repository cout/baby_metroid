#!/usr/bin/env python3

import sys

from rom import Rom
from lc_lz3 import decompress
from room2hex import room2hex
from structures import RoomHeader, RoomStateHeader, RoomEnemyPopulation

def align_comment(s, pos):
  if s[0] == ';': return s
  if s.find(';') < 0: return s

  stmt, comment = s.split(';', 2)
  stmt = stmt.rstrip()
  comment = comment.strip()
  fmt = '%%- %ds ; %%s' % pos
  return fmt % (stmt, comment)

def align_comments(s, pos=12):
  return '\n'.join(align_comment(line, pos) for line in s.splitlines())

def format_room_header(room_id, room):
  return align_comments(f'''
; Room ${room_id:04X}: Header
org $8F{room_id:04X}
db ${room.idx                       :02X} ; Index
db ${room.area                      :02X} ; Area
db ${room.x                         :02X} ; X position on map
db ${room.y                         :02X} ; Y position on map
db ${room.w                         :02X} ; Width (in screens)
db ${room.h                         :02X} ; Height (in screens)
db ${room.up_scroller               :02X} ; Up scroller
db ${room.down_scroller             :02X} ; Down scroller
db ${room.special_gfx               :02X} ; Special graphics bits
dw ${room.doorout                   :04X} ; Special graphics bits
'''.strip())

def format_room_state_function(room_id, func):
  state_id = func.state_header_addr
  if func.type == 'default':
    return align_comments(f'''
dw ${0xE5E6                         :04X} ; State ${state_id:04X} function ({func.type})
'''.lstrip())
  elif func.type == 'event':
    return align_comments(f'''
dw ${func.func                      :04X} ; State ${state_id:04X} function ({func.type})
dw ${func.state_header_addr         :04X} ; State header address
dw ${func.event                     :04X} ; Event
'''.lstrip())
  else:
    s = align_comments(f'''
dw ${func.func                      :04X} ; State ${state_id:04X} function ({func.type})
dw ${func.state_header_addr         :04X} ; State header address
'''.strip())

def format_room_state_header(room_id, state_header):
  return align_comments(f'''
; Room ${room_id:04X} state ${state_header.state_id:04X}: Header
org $8F{state_header.state_id:04X}
dl ${state_header.level_data_addr   :06X} ; Level data address
db ${state_header.tileset           :02X} ; Tileset (bank TODO)
db ${state_header.music_data_index  :02X} ; Music data index
db ${state_header.music_track_index :02X} ; Music track index
dw ${state_header.fx_addr           :04X} ; FX address (bank TODO)
dw ${state_header.enemy_pop_addr    :04X} ; Enemy population offset (bank $A1)
dw ${state_header.enemy_set_addr    :04X} ; Enemy graphics set offset (bank $B4)
dw ${state_header.layer_2_scroll    :04X} ; Layer 2 scroll
dw ${state_header.room_var          :04X} ; Room var
dw ${state_header.room_main_func    :04X} ; Room main routine (bank TODO)
dw ${state_header.plm               :04X} ; Room PLM list address (bank TODO)
dw ${state_header.library_background:04X} ; Library background (bank TODO)
dw ${state_header.room_setup_func   :04X} ; Room setup routine (bank TODO)
'''.strip())

def format_room_enemy_population_entry(enemy_pop):
  return f'''
dw ${enemy_pop.enemy_id:04X}, ${enemy_pop.x:04X}, ${enemy_pop.y:04X}, ${enemy_pop.init_param:04X}, ${enemy_pop.properties:04X}, ${enemy_pop.extra_properties:04X}, ${enemy_pop.parameter_1:04X}, ${enemy_pop.parameter_2:04X}
'''.strip()
#   return align_comments(f'''
# dw ${enemy_pop.enemy_id             :04X} ; Enemy offest (bank $A0)
# dw ${enemy_pop.x                    :04X} ; X pos in room
# dw ${enemy_pop.y                    :04X} ; Y pos in room
# dw ${enemy_pop.init_param           :04X} ; Init parameter
# dw ${enemy_pop.properties           :04X} ; Initial properties
# dw ${enemy_pop.extra_properties     :04X} ; Initial extra properties
# dw ${enemy_pop.parameter_1          :04X} ; Parameter 1
# dw ${enemy_pop.parameter_2          :04X} ; Parameter 2
# '''.strip())

def format_room_enemy_population(room_id, state_id, addr, enemy_pop):
  s = align_comments(f'''
; Room ${room_id:04X} state ${state_id:04X}: Enemy population
org $A1{addr}
;  enemy  x      y      init   props  extra  param1 param2
'''.strip())
  for entry in enemy_pop.population:
    s += "\n%s" % align_comments(format_room_enemy_population_entry(entry))
  s += "\n"
  s += align_comments(f'''
dw $FFFF                        ; end of list
dw ${enemy_pop.death_quota:02X} ; death quota
'''.strip())
  return s

# TODO: All state headers not just one
def print_full_room_data(rom, room_id, state_idx, room_header, out=sys.stdout):
  state_id = room_header.state_functions[state_idx].state_header_addr
  room_state_header = RoomStateHeader.extract(rom, state_id)
  state_functions = room_header.state_functions
  state_header_addrs = sorted(set(func.state_header_addr for func in room_header.state_functions))
  state_headers = [ RoomStateHeader.extract(rom, addr) for addr in state_header_addrs ]
  enemy_pop_addrs = sorted(set((state_header.state_id, state_header.enemy_pop_addr) for state_header in state_headers))
  enemy_pops = [ (state_id, addr, RoomEnemyPopulation.extract(rom, addr)) for (state_id, addr) in enemy_pop_addrs ]

  print(format_room_header(room_id, room_header), file=out)

  for func in room_header.state_functions:
    print(format_room_state_function(room_id, func), file=out)

  for state_header in state_headers:
    print('', file=out)
    print(format_room_state_header(room_id, state_header), file=out)

  for (state_id, addr, enemy_pop) in enemy_pops:
    print('', file=out)
    print(format_room_enemy_population(room_id, state_id, addr, enemy_pop))

def main():
  filename = sys.argv[1]
  room_id = int(sys.argv[2], 16)
  state_idx = int(sys.argv[3]) if len(sys.argv) >= 4 else 0

  rom = Rom(open(filename, 'rb'))

  room_header = RoomHeader.extract(rom, room_id)
  print_full_room_data(rom, room_id, state_idx, room_header)

if __name__ == '__main__':
  main()
