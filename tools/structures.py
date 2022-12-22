from lc_lz3 import decompress

import struct
from dataclasses import dataclass

class HexValue(int):
  def __new__(cls, value):
    return super(HexValue, cls).__new__(cls, value)

  def __repr__(self):
    return '%Xh' % self

@dataclass
class RoomEventStateFunction(object):
  type: str
  func: HexValue
  state_header_addr: HexValue
  event: HexValue

  def __init__(self, type, func, event, state_header_addr):
    self.type = type
    self.func = HexValue(func)
    self.event = HexValue(event)
    self.state_header_addr = HexValue(state_header_addr)

@dataclass
class RoomStateFunction(object):
  type: str
  func: HexValue
  state_header_addr: HexValue # TODO: rename to state_header_offset

  def __init__(self, type, func, state_header_addr):
    self.type = type
    self.func = HexValue(func) if func is not None else None
    self.state_header_addr = HexValue(state_header_addr)

  @classmethod
  def read_from(cls, rom):
    func, = struct.unpack('<H', rom.read(2))
    if func == 0xE5E6: return RoomStateFunction('default', None, rom.tell() & 0xFFFF)
    elif func == 0xE5FF: return cls('main_area_boss', func, *struct.unpack('<H', rom.read(2)))
    elif func == 0xE612: return RoomEventStateFunction('event', func, *struct.unpack('<BH', rom.read(3)))
    elif func == 0xE629: return RoomEventStateFunction('boss', func, *struct.unpack('<BH', rom.read(3)))
    elif func == 0xE562: return cls('zebes_awake', func, *struct.unpack('<H', rom.read(2)))
    elif func == 0xE669: return cls('pbs', func, *struct.unpack('<H', rom.read(2)))
    else: raise RuntimeError("Unknown event state function %04Xh" % func)

@dataclass
class RoomStateFunctionList(object):
  functions: list

  def __getitem__(self, item):
    return self.functions.__getitem__(item)

  def __len__(self, item):
    return self.functions.__len__(item)

  @classmethod
  def read_from(cls, rom):
    functions = [ ]
    while True:
      func = RoomStateFunction.read_from(rom)
      functions.append(func)
      if func.type == 'default': break
    return cls(functions)

@dataclass
class RoomHeader(object):
  fmt = struct.Struct("<BBBBBBBBBH")

  idx: HexValue
  area: HexValue
  x: HexValue
  y: HexValue
  w: HexValue
  h: HexValue
  up_scroller: HexValue
  down_scroller: HexValue
  special_gfx: HexValue
  doorout: HexValue
  state_functions: list

  @classmethod
  def read_from(cls, rom):
    b = rom.read(cls.fmt.size)
    values = cls.fmt.unpack(b)
    values = [ HexValue(v) if type(v) is int else v for v in values ]
    state_functions = RoomStateFunctionList.read_from(rom)
    return cls(*values, state_functions)

  @classmethod
  def extract(cls, rom, offset, bank=0x8f):
    addr = (bank << 16) | offset
    rom.seek(addr)
    return cls.read_from(rom)

@dataclass
class RoomStateHeader(object):
  fmt = struct.Struct("<HBBBBHHHHHHHHHH")

  state_id: HexValue
  level_data_offset: HexValue
  level_data_bank: HexValue
  tileset: HexValue
  music_data_index: HexValue
  music_track_index: HexValue
  fx_addr: HexValue
  enemy_pop_addr: HexValue
  enemy_graphics_set_addr: HexValue
  layer_2_scroll: HexValue
  room_scroll: HexValue
  room_var: HexValue
  room_main_func: HexValue
  plm: HexValue
  library_background: HexValue
  room_setup_func: HexValue

  @classmethod
  def read_from(cls, rom):
    state_id = rom.tell() & 0xFFFF
    b = rom.read(cls.fmt.size)
    values = cls.fmt.unpack(b)
    values = [ HexValue(v) if type(v) is int else v for v in values ]
    return cls(state_id, *values)

  @classmethod
  def extract(cls, rom, offset, bank=0x8f):
    addr = (bank << 16) | offset
    rom.seek(addr)
    return cls.read_from(rom)

  @property
  def level_data_addr(self):
    return (self.level_data_bank << 16) | self.level_data_offset

@dataclass
class RoomLevelData(object):
  size: HexValue
  tilemap: bytearray
  bts: bytearray
  layer2_tilemap: bytearray

  @classmethod
  def read_from(cls, rom):
    # TODO: read exact size instead of reading extra bytes
    level_data = decompress(rom.read(0x4000))
    size, tilemap, bts, layer2_tilemap = cls.bin2room(level_data)
    return cls(size, tilemap, bts, layer2_tilemap)

  @classmethod
  def extract(cls, rom, addr):
    rom.seek(addr)
    return cls.read_from(rom)

  @classmethod
  def bin2room(cls, b):
    size, = struct.unpack('<H', b[0:2])
    size = size // 2
    if len(b) == 2 + size * 3:
      fmt = '%dH%dB' % (size, size)
      l = struct.unpack(fmt, b[2:])
      tilemap = l[0:size]
      bts = l[size:]
      return size, tilemap, bts, None
    elif len(b) == 2 + size * 5:
      fmt = '%dH%dB%dH' % (size, size, size)
      l = struct.unpack(fmt, b[2:])
      tilemap = l[0:size]
      bts = l[size:size*2]
      layer2_tilemap = l[size*2:]
      return size, tilemap, bts, layer2_tilemap
    else:
      raise RuntimeError("Size of data (%s) did not match level data size (%s) -- expected either %s or %s" % (len(b), size, size*3+2, size*5+2)) # TODO

@dataclass
class RoomEnemyPopulationEntry(object):
  fmt = struct.Struct("<HHHHHHH")

  enemy_id: HexValue
  x: HexValue
  y: HexValue
  init_param: HexValue
  properties: HexValue
  extra_properties: HexValue
  parameter_1: HexValue
  parameter_2: HexValue

  @classmethod
  def read_from(cls, rom):
    # TODO: duplicated with RoomStateHeader
    enemy_id, = struct.unpack('<H', rom.read(2))
    if enemy_id == 0xFFFF: return None

    b = rom.read(cls.fmt.size)
    values = cls.fmt.unpack(b)
    values = [ HexValue(v) if type(v) is int else v for v in values ]
    return cls(HexValue(enemy_id), *values)

@dataclass
class RoomEnemyPopulation(object):
  population: list
  death_quota: HexValue

  @classmethod
  def read_from(cls, rom):
    population = [ ]
    while True:
      entry = RoomEnemyPopulationEntry.read_from(rom)
      if entry is None: break
      population.append(entry)
    death_quota, = struct.unpack('<B', rom.read(1))
    return cls(population, HexValue(death_quota))

  @classmethod
  def extract(cls, rom, offset, bank=0xA1):
    addr = (bank << 16) | offset
    rom.seek(addr)
    return cls.read_from(rom)
@dataclass

class RoomEnemyGraphicsSetEntry(object):
  fmt = struct.Struct("<H")

  enemy_id: HexValue
  palette_index: int

  @classmethod
  def read_from(cls, rom):
    # TODO: duplicated with RoomStateHeader
    enemy_id, = struct.unpack('<H', rom.read(2))
    if enemy_id == 0xFFFF: return None

    b = rom.read(cls.fmt.size)
    values = cls.fmt.unpack(b)
    values = [ HexValue(v) if type(v) is int else v for v in values ]
    return cls(HexValue(enemy_id), *values)

@dataclass
class RoomEnemyGraphicsSet(list):
  @classmethod
  def read_from(cls, rom):
    entries = cls()
    while True:
      entry = RoomEnemyGraphicsSetEntry.read_from(rom)
      if entry is None: break
      entries.append(entry)
    return entries

  @classmethod
  def extract(cls, rom, offset, bank=0xB4):
    addr = (bank << 16) | offset
    rom.seek(addr)
    return cls.read_from(rom)

@dataclass
class RoomFx(object):
  fmt = struct.Struct("<HHHHBBBBBBBB")

  door_id: HexValue
  base_y_position: HexValue
  target_y_position: HexValue
  y_velocity: HexValue
  timer: HexValue
  fx_type: HexValue
  fx_a: HexValue
  fx_b: HexValue
  fx_c: HexValue
  palette_fx: HexValue
  animated_tiles: HexValue
  palette_blend: HexValue

  @classmethod
  def read_from(cls, rom):
    b = rom.read(cls.fmt.size)
    values = cls.fmt.unpack(b)
    values = [ HexValue(v) if type(v) is int else v for v in values ]
    return cls(*values)

  @classmethod
  def extract(cls, rom, offset, bank=0x83):
    addr = (bank << 16) | offset
    rom.seek(addr)
    return cls.read_from(rom)

@dataclass
class RoomFxList(list):
  @classmethod
  def read_from(cls, rom):
    entries = cls()
    while True:
      entry = RoomFx.read_from(rom)
      entries.append(entry)
      if entry.door_id == 0: break
    return entries

  @classmethod
  def extract(cls, rom, offset, bank=0x83):
    addr = (bank << 16) | offset
    rom.seek(addr)
    return cls.read_from(rom)
