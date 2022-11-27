class CompressionOp(object):
  def __init__(self, cmd, size, operands):
    self.cmd = cmd
    self.size = size
    self.operands = operands

  def __repr__(self):
    return repr((self.cmd, self.size, list(self.operands)))

  def encode(self):
    o = bytearray()
    sz = self.size - 1
    if sz >= 32:
      o.append(0xe0 | (self.cmd << 2) | (sz >> 8))
      o.append(sz & 0xff)
    else:
      o.append((self.cmd << 5) | sz)
    o.extend(self.operands)
    return o

DIRECT_COPY_CMD = 0
BYTE_FILL_CMD = 1
WORD_FILL_CMD = 2
SIGMA_FILL_CMD = 3
LIBRARY_COPY_CMD = 4
EOR_COPY_CMD = 5
MINUS_COPY_CMD = 6
EXTENDED_CMD = 7

class CompressionStats(object):
  def __init__(self):
    self.cmds = [ 0, 0, 0, 0, 0, 0, 0, 0 ]
    self.ops = 0

  def tally(self, cmd):
    self.cmds[cmd] += 1
    self.ops += 1

  def __str__(self):
    return str(self.cmds)

class CompressionSettings(object):
  # A word fill takes minimum 2 bytes to encode, so there is no point in
  # encoding a word fill less than 3 bytes.  Setting this to a larger
  # number encourages use of the dictionary.
  min_run_size = 4

  min_match_size = 4

  # This is the maximum possible size; using 32 or less disables extended
  # commands.
  max_size = 1024

  # This controls the size of the dictionary; using 255 or less prevents
  # use of absolute offset copy.
  # dictionary_size = 255
  dictionary_size = 65535

def decompress(d, stats=None):
  o = bytearray()
  i = 0
  stats = stats or CompressionStats()

  while i < len(d):
    b = d[i]; i += 1
    cmd = (b & 0xe0) >> 5
    arg = (b & 0x1f)

    if cmd == EXTENDED_CMD:
      if arg == 0x1f: break

      b2 = d[i]; i += 1
      cmd = (b & 0x1c) >> 2
      size = (((b & 0x3) << 8) | (b2)) + 1

    else:
      size = arg + 1

    stats.tally(cmd)

    if cmd == DIRECT_COPY_CMD:
      for j in range(0, size):
        o.append(d[i]); i += 1

    elif cmd == BYTE_FILL_CMD:
      b = d[i]; i += 1
      for j in range(0, size): o.append(b)

    elif cmd == WORD_FILL_CMD:
      istart = i
      a = (d[i], d[i+1]); i += 2
      for j in range(0, size):
        o.append(a[j%2])

    elif cmd == SIGMA_FILL_CMD:
      b = d[i]; i += 1
      for j in range(0, size): o.append(b); b = (b + 1) & 0xff

    elif cmd == LIBRARY_COPY_CMD:
      a = (d[i], d[i+1]); i += 2
      offset = a[0] | (a[1] << 8)
      for j in range(offset, offset + size): o.append(o[j])

    elif cmd == EOR_COPY_CMD:
      a = (d[i], d[i+1]); i += 2
      offset = a[0] | (a[1] << 8)
      for j in range(offset, offset + size): o.append(o[j] ^ 0xff)

    elif cmd == MINUS_COPY_CMD:
      b = d[i]; i += 1
      offset = len(o) - b
      for j in range(offset, offset + size): o.append(o[j])

    else:
      raise RuntimeError("unimplemented command %x" % cmd)

  return o

invalid_op = CompressionOp(99, -100, [ ])

def direct_copy_op(d, i, end, settings):
  size = 0
  end = end or len(d)
  data = [ ]
  while i < end and size < settings.max_size:
    data.append(d[i])
    i += 1
    size += 1
  return CompressionOp(0, size, data)

def word_fill_op(size, a):
  return CompressionOp(WORD_FILL_CMD, size, a)

def copy_op(size, idx, offset, settings):
  rel_offset = idx - offset
  if rel_offset <= 0:
    raise RuntimeError("Cannot copy from the future (offset %d is before %d)" % (offset, idx))
  elif rel_offset < 256:
    return CompressionOp(MINUS_COPY_CMD, size, [ rel_offset ])
  elif rel_offset < 65536:
    if settings.dictionary_size < 256:
      raise RuntimeError("matcher produced a reference beyond the dictionary (offset %d is before %d)" % (offset, idx - dictionary_size))
    return CompressionOp(LIBRARY_COPY_CMD, size, [ offset & 0xff, offset >> 8 ])
  else:
    raise RuntimeError("Too much to copy")

def try_word_fill(d, idx, settings):
  end = len(d)
  if idx >= end - 1: return invalid_op
  a = (d[idx], d[idx+1])
  size = 0
  while idx + size < end and size < settings.max_size:
    if d[idx + size] != a[size%2]: break
    size += 1
  if size < settings.min_run_size: return invalid_op
  return word_fill_op(size, a)

def try_dict_copy(d, idx, settings):
  end = len(d)
  dictionary_start = max(0, idx - settings.dictionary_size + 1)
  dictionary_end = idx
  longest = invalid_op
  for size in range(settings.min_match_size, settings.max_size):
    if idx + size >= end: break
    offset = d.find(d[idx:idx+size], dictionary_start, dictionary_end)
    if offset < 0: break
    longest = copy_op(size, idx, offset, settings)

  return longest

def generate_ops(d, settings):
  ops = [ ]
  i = 0
  end = len(d)
  dc_start = 0
  while i < end:
    word_fill = try_word_fill(d, i, settings)
    dict_copy = try_dict_copy(d, i, settings)
    longest = max(word_fill, dict_copy, key=lambda c: c.size)
    if longest.size > 0:
      if i > dc_start:
        ops.append(direct_copy_op(d, dc_start, i, settings))
      ops.append(longest)
      i += longest.size
      dc_start = i
    else:
      if i - dc_start >= settings.max_size:
        ops.append(direct_copy_op(d, dc_start, i, settings))
        dc_start = i
      i += 1
  if i > dc_start:
    ops.append(direct_copy_op(d, dc_start, i, settings))

  return ops

def encode_ops(ops, stats):
  print("Compressing %d ops" % len(ops))
  o = bytearray()
  for op in ops:
    stats.tally(op.cmd)
    o.extend(op.encode())
  o.append(0xFF)
  return o

def compress(d, stats=None, settings=CompressionSettings()):
  stats = stats or CompressionStats()
  ops = generate_ops(d, settings)
  return encode_ops(ops, stats)
