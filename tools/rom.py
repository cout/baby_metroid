snes2offset = lambda address: address >> 1 & 0x3F8000 | address & 0x7FFF
offset2snes = lambda address: address << 1 & 0xFF0000 | address & 0xFFFF | 0x808000

class Rom(object):
  def __init__(self, stream):
    self.stream = stream

  def seek(self, snes):
    offset = snes2offset(snes)
    self.stream.seek(offset)

  def read(self, size):
    return self.stream.read(size)

  def read_until(self, end):
    end_offset = snes2offset(end)
    size = end_offset - self.stream.tell()
    return self.read(size)
