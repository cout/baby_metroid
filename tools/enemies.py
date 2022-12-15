import json

class Enemy(object):
  def __init__(self, enemy_id, name):
    self.enemy_id = enemy_id
    self.name = name

  def __repr__(self):
    return self.name

NullEnemy = Enemy(0, 'None')

class Enemies(object):
  def __init__(self, raw_enemies):
    self.enemies = [ Enemy(enemy_id=int(enemy_id, 16), name=enemy['name'])
        for enemy_id, enemy in raw_enemies.items() ]

    self.by_id = { enemy.enemy_id : enemy for enemy in self.enemies }
    self.by_name = { enemy.name : enemy for enemy in self.enemies }

    self.add_enemy(NullEnemy)

    self.check_invariants()

  def from_id(self, enemy_id):
    if type(enemy_id) is not int:
      raise TypeError("enemy id should be an int (got %s)" % type(enemy_id))
    enemy = self.by_id.get(enemy_id)
    if enemy is None:
      enemy = Enemy(enemy_id, hex(enemy_id))
      self.add_enemy(enemy)
    return enemy

  def from_name(self, name):
    if name[0:2] == '0x':
      enemy_id = int(name, 0)
      enemy = self.from_id(enemy_id)
    else:
      enemy = self.by_name.get(name, None)
      if enemy is None:
        raise RuntimeError("Could not find enemy with name `%s'" % name)
    return enemy

  def add_enemy(self, enemy):
    self.by_id[enemy.enemy_id] = enemy
    self.by_name[enemy.name] = enemy
    self.check_invariants()

  def check_invariants(self):
    for enemy in self.by_name.values():
      enemy2 = self.by_id[enemy.enemy_id]
      if enemy is not enemy2:
        raise RuntimeError("%s != %s" % (enemy, enemy2))
    for enemy in self.by_id.values():
      enemy2 = self.by_name[enemy.name]
      # TODO: disabled duplicate name check for now
      # if enemy is not enemy2:
      #   raise RuntimeError("%s != %s" % (enemy, enemy2))

  @staticmethod
  def read(filename):
    return Enemies(json.load(open(filename)))
