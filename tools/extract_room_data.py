#!/usr/bin/env python3

import sys
import os
from itertools import groupby

from rom import Rom
from lc_lz3 import decompress
from room2hex import room2hex
from structures import RoomHeader, RoomStateHeader, RoomEnemyPopulation, RoomEnemyGraphicsSet, RoomFxList, RoomPlmList
from enemies import Enemies

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
dw ${room.doorout                   :04X} ; Door out
'''.strip())

def format_room_state_function(room_id, func):
  state_id = func.state_header_addr
  if func.type == 'default':
    return align_comments(f'''
dw ${0xE5E6                               :04X} ; State ${state_id:04X} function ({func.type})
'''.lstrip())
  elif func.type == 'event':
    return align_comments(f'''
dw ${func.func                            :04X} ; State ${state_id:04X} function ({func.type})
db ${func.event                           :02X} ; Event
dw ${func.state_header_addr               :04X} ; State header address
'''.lstrip())
  elif func.type == 'boss':
    return align_comments(f'''
dw ${func.func                            :04X} ; State ${state_id:04X} function ({func.type})
db ${func.boss                            :02X} ; Boss
dw ${func.state_header_addr               :04X} ; State header address
'''.lstrip())
  else:
    return align_comments(f'''
dw ${func.func                            :04X} ; State ${state_id:04X} function ({func.type})
dw ${func.state_header_addr               :04X} ; State header address
'''.strip())

def format_room_state_header(room_id, func, state_header):
  return align_comments(f'''
; Room ${room_id:04X} state ${state_header.state_id:04X}: Header
; ({func.description})
org $8F{state_header.state_id:04X}
dl ${state_header.level_data_addr         :06X} ; Level data address
db ${state_header.tileset                 :02X} ; Tileset
db ${state_header.music_data_index        :02X} ; Music data index
db ${state_header.music_track_index       :02X} ; Music track index
dw ${state_header.fx_addr                 :04X} ; FX address (bank $83)
dw ${state_header.enemy_pop_addr          :04X} ; Enemy population offset (bank $A1)
dw ${state_header.enemy_graphics_set_addr :04X} ; Enemy graphics set offset (bank $B4)
dw ${state_header.layer_2_scroll          :04X} ; Layer 2 scroll
dw ${state_header.room_scroll             :04X} ; Room scroll data (bank $8F)
dw ${state_header.room_var                :04X} ; Room var
dw ${state_header.room_main_func          :04X} ; Room main routine (bank $8F)
dw ${state_header.plm_list_addr           :04X} ; Room PLM list address (bank $8F)
dw ${state_header.library_background      :04X} ; Library background (bank $8F)
dw ${state_header.room_setup_func         :04X} ; Room setup routine (bank $8F)
'''.strip())

def format_room_enemy_population_entry(enemy_pop, enemies):
  enemy_name = enemies.from_id(int(enemy_pop.enemy_id))
  return f'''
dw ${enemy_pop.enemy_id:04X}, ${enemy_pop.x:04X}, ${enemy_pop.y:04X}, ${enemy_pop.init_param:04X}, ${enemy_pop.properties:04X}, ${enemy_pop.extra_properties:04X}, ${enemy_pop.parameter_1:04X}, ${enemy_pop.parameter_2:04X} ; {enemy_name}
'''.strip()

def format_room_enemy_population(room_id, state_ids, addr, enemy_pop, enemies):
  s = ''
  for state_id in state_ids:
    s += f'; Room ${room_id:04X} state ${state_id:04X}: Enemy population\n'
  s += align_comments(f'''
org $A1{addr:04X}
;  enemy  x      y      init   props  extra  param1 param2
'''.strip())
  for entry in enemy_pop.population:
    s += "\n%s" % align_comments(format_room_enemy_population_entry(entry, enemies))
  s += "\n"
  s += align_comments(f'''
dw $FFFF                        ; end of list
db ${enemy_pop.death_quota:02X} ; death quota
'''.strip())
  return s

def format_room_enemy_graphics_set_entry(entry, enemies):
  enemy_name = enemies.from_id(int(entry.enemy_id))
  return f'''
dw ${entry.enemy_id:04X}, ${entry.palette_index:04X} ; {enemy_name}
'''.strip()

def format_room_enemy_graphics_set(room_id, state_ids, addr, enemy_graphics_set, enemies):
  s = ''
  for state_id in state_ids:
    s += f'; Room ${room_id:04X} state ${state_id:04X}: Enemy graphics set\n'
  s += align_comments(f'''
org $B4{addr:04X}
;  enemy  palette
'''.strip())
  for entry in enemy_graphics_set:
    s += "\n%s" % align_comments(format_room_enemy_graphics_set_entry(entry, enemies))
  s += "\n"
  s += align_comments(f'''
dw $FFFF                        ; end of list
'''.strip())
  return s

def format_room_fx_long(room_id, state_ids, addr, fx):
  s = ''
  for state_id in state_ids:
    s += f'; Room ${room_id:04X} state ${state_id:04X}: FX\n'
  return s + align_comments(f'''
org $B4{addr:04X}
dw ${fx.door_id:04X}            ; Door ID
dw ${fx.base_y_position:04X}    ; Base Y position
dw ${fx.target_y_position:04X}  ; Target Y position
db ${fx.timer:04X}              ; Timer
db ${fx.fx_type:04X}            ; FX Type
db ${fx.fx_a:04X}               ; FX A (default layer blending configuration)
db ${fx.fx_b:04X}               ; FX B (layer 3 blending configuration)
db ${fx.fx_c:04X}               ; FX C (liquid options)
db ${fx.palette_fx:04X}         ; Palette FX bitset
db ${fx.animated_tiles:04X}     ; Animated tiles bitset
db ${fx.palette_blend:04X}      ; Palette blend
'''.strip())
  return s

def format_room_fx_short(fx):
  return f'''
dw ${fx.door_id:04X}, ${fx.base_y_position:04X}, ${fx.target_y_position:04X}, ${fx.y_velocity:04X} : db ${fx.timer:02X}, ${fx.fx_type:02X}, ${fx.fx_a:02X}, ${fx.fx_b:02X}, ${fx.fx_c:02X}, ${fx.palette_fx:02X}, ${fx.animated_tiles:02X}, ${fx.palette_blend:02X}
'''.strip()

def format_room_fx_list(room_id, state_ids, addr, fx_list):
  s = ''
  for state_id in state_ids:
    s += f'; Room ${room_id:04X} state ${state_id:04X}: FX\n'
  s += align_comments(f'''
org $83{addr:04X}
;  door   base   target veloc     time  type  A    B    C   pal  anim blend
'''.strip())
  for fx in fx_list:
    s += "\n%s" % align_comments(format_room_fx_short(fx))
  return s

def format_room_plm(entry):
  return f'''
dw ${entry.plm_id:04X}, ${entry.y:02X}{entry.x:02X}, ${entry.param:04X}
'''.strip()

def format_room_plm_list(room_id, state_ids, addr, fx_list):
  s = ''
  for state_id in state_ids:
    s += f'; Room ${room_id:04X} state ${state_id:04X}: PLM\n'
  s += align_comments(f'''
org $8F{addr:04X}
;  plm_id y/x    param
'''.strip())
  for fx in fx_list:
    s += "\n%s" % align_comments(format_room_plm(fx))
  s += "\n"
  s += align_comments(f'''
dw $0000                        ; end of list
'''.strip())
  return s

def get_state_headers(room_header, rom):
  state_functions = room_header.state_functions
  addrs = sorted(func.state_header_addr for func in state_functions)
  addr_to_func = { func.state_header_addr : func for func in state_functions }
  state_headers = [ (addr_to_func[addr], RoomStateHeader.extract(rom, addr)) for addr in addrs ]
  return state_headers

def get_enemy_pops(state_headers, rom):
  d = { hdr.state_id: hdr.enemy_pop_addr for (func, hdr) in state_headers }
  l = groupby(d.keys(), lambda state_id: d[state_id])
  return [ ((addr, RoomEnemyPopulation.extract(rom, addr)), list(ids)) for (addr, ids) in l ]

def get_enemy_graphics_sets(state_headers, rom):
  d = { hdr.state_id: hdr.enemy_graphics_set_addr for (func, hdr) in state_headers }
  l = groupby(d.keys(), lambda state_id: d[state_id])
  return [ ((addr, RoomEnemyGraphicsSet.extract(rom, addr)), list(ids)) for (addr, ids) in l ]

def get_fx_lists(state_headers, rom):
  d = { hdr.state_id: hdr.fx_addr for (func, hdr) in state_headers }
  l = groupby(d.keys(), lambda state_id: d[state_id])
  return [ ((addr, RoomFxList.extract(rom, addr)), list(ids)) for (addr, ids) in l ]

def get_plm_lists(state_headers, rom):
  d = { hdr.state_id: hdr.plm_list_addr for (func, hdr) in state_headers }
  l = groupby(d.keys(), lambda state_id: d[state_id])
  return [ ((addr, RoomPlmList.extract(rom, addr)), list(ids)) for (addr, ids) in l ]

def print_full_room_data(rom, room_id, room_header, enemies, out=sys.stdout):
  state_headers = get_state_headers(room_header, rom)
  enemy_pops = get_enemy_pops(state_headers, rom)
  enemy_graphics_sets = get_enemy_graphics_sets(state_headers, rom)
  fx_lists = get_fx_lists(state_headers, rom)
  plm_lists = get_plm_lists(state_headers, rom)

  print(format_room_header(room_id, room_header), file=out)

  for func in room_header.state_functions:
    print(format_room_state_function(room_id, func), file=out)

  for func, state_header in state_headers:
    print('', file=out)
    print(format_room_state_header(room_id, func, state_header), file=out)

  for ((addr, enemy_pop), state_ids) in enemy_pops:
    print('', file=out)
    print(format_room_enemy_population(room_id, state_ids, addr, enemy_pop, enemies))

  for ((addr, enemy_graphics_set), state_ids) in enemy_graphics_sets:
    print('', file=out)
    print(format_room_enemy_graphics_set(room_id, state_ids, addr, enemy_graphics_set, enemies))

  for ((addr, fx_list), state_ids) in fx_lists:
    print('', file=out)
    print(format_room_fx_list(room_id, state_ids, addr, fx_list))

  for ((addr, plm_list), state_ids) in plm_lists:
    print('', file=out)
    print(format_room_plm_list(room_id, state_ids, addr, plm_list))

def main():
  filename = sys.argv[1]
  room_id = int(sys.argv[2], 16)

  path = os.path.dirname(os.path.realpath(__file__))
  enemies_filename = os.path.join(path, 'enemies.json')
  enemies = Enemies.read(enemies_filename)

  rom = Rom(open(filename, 'rb'))

  room_header = RoomHeader.extract(rom, room_id)
  print_full_room_data(rom, room_id, room_header, enemies)

if __name__ == '__main__':
  main()
