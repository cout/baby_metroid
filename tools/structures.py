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
  state_header_addr: HexValue

  def __init__(self, type, func, state_header_addr):
    self.type = type
    self.func = HexValue(func)
    self.state_header_addr = HexValue(state_header_addr)

  @classmethod
  def read_from(cls, rom):
    func, = struct.unpack('<H', rom.read(2))
    if func == 0xE5E6: return None
    elif func == 0xE5FF: return cls('boss', func, *struct.unpack('<H', rom.read(2)))
    elif func == 0xE612: return RoomEventStateFunction('event', func, *struct.unpack('<BH', rom.read(3)))
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
      if func is None: break
      functions.append(func)
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
  fmt = struct.Struct("<HBBBHHHHHHHHHH")

  level_data_offset: HexValue
  level_data_bank: HexValue
  tileset: HexValue
  music_data_index: HexValue
  music_track_index: HexValue
  fx_addr: HexValue
  enemy_pop_addr: HexValue
  enemy_set_addr: HexValue
  layer_2_scroll: HexValue
  room_var: HexValue
  room_main_func: HexValue
  plm: HexValue
  library_background: HexValue
  room_setup_func: HexValue

  @classmethod
  def read_from(cls, rom):
    b = rom.read(cls.fmt.size)
    values = cls.fmt.unpack(b)
    values = [ HexValue(v) if type(v) is int else v for v in values ]
    return cls(*values)

  @classmethod
  def extract(cls, rom, offset, bank=0x8f):
    addr = (bank << 16) | offset
    rom.seek(addr)
    return cls.read_from(rom)

  @property
  def level_data_addr(self):
    return (self.level_data_bank << 16) | self.level_data_offset
