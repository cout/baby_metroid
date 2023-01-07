SHELL = bash -o pipefail

ASAR_DIR = tools/asar
ASAR = $(ASAR_DIR)/build/asar/bin/asar
FLIPS = ../Flips/flips
HEX2BIN = tools/hex2bin.py
COMPRESS = tools/compress.py
GENERATE_DEPS = tools/generate_deps.py

ASAR_FLAGS = -w1013 --no-title-check

SOURCES = \
src/main.asm

DEPENDENCY_FILES = \
	build/baby_metroid.ips.d \

TARGETS = \
	build/baby_metroid.sfc \
	build/baby_metroid.ips \

ROOMS = \
	src/rooms/climb.bin \
	src/rooms/bomb_torizo.bin \
	src/rooms/green_brinstar_firefleas.bin \
	src/rooms/spore_spawn.bin \
	src/rooms/noob_bridge.bin \
	src/rooms/bat_room.bin \
	src/rooms/early_supers.bin \
	src/rooms/hi_jump_boots.bin \
	src/rooms/kraid_eye_door.bin \
	src/rooms/kraid.bin \
	src/rooms/speed_hallway.bin \
	src/rooms/red_tower.bin \
	src/rooms/hellway.bin \
	src/rooms/alpha_power_bombs.bin \
	src/rooms/moat.bin \
	src/rooms/west_ocean.bin \
	src/rooms/phantoon.bin \
	src/rooms/bowling.bin \
	src/rooms/spiky_room.bin \
	src/rooms/wrecked_ship_etank.bin \
	src/rooms/east_ocean.bin \
	src/rooms/crab_maze.bin \
	src/rooms/east_sand_hall.bin \
	src/rooms/west_sand_hall.bin \
	src/rooms/pants_room_a.bin \
	src/rooms/pants_room_b.bin \
	src/rooms/crocomire_speedway.bin \
	src/rooms/crocomire.bin \
	src/rooms/double_chamber.bin \
	src/rooms/spiky_acid_snakes.bin \
	src/rooms/botwoon.bin \
	src/rooms/botwoon_etank.bin \
	src/rooms/halfie_climb.bin \
	src/rooms/colosseum.bin \
	src/rooms/east_cactus_alley.bin \
	src/rooms/butterfly_room.bin \
	src/rooms/acid_statue.bin \
	src/rooms/wasteland.bin \
	src/rooms/firefleas.bin \
	src/rooms/spring_ball_maze.bin \
	src/rooms/escape_parlor.bin \
	src/rooms/escape_landing_site.bin \

all: build/baby_metroid.sfc

.PHONY: all

clean:
	rm -f $(TARGETS) $(DEPENDENCY_FILES)

.PHONY: clean

build/.stamp:
	mkdir -p build
	touch build/.stamp

build/baby_metroid.sfc: build/.stamp resources/sm_orig.sfc build/baby_metroid.ips
	$(FLIPS) --apply build/baby_metroid.ips resources/sm_orig.sfc build/baby_metroid.sfc

build/baby_metroid.ips: $(ASAR) $(SOURCES) $(ROOMS)
	echo "build/baby_metroid.ips: `$(GENERATE_DEPS) src/main.asm`" > build/baby_metroid.ips.d
	$(ASAR) $(ASAR_FLAGS) --ips build/baby_metroid.ips "$$@" src/main.asm

src/rooms/%.bin: src/rooms/%.hex
	cat $< | $(HEX2BIN) | $(COMPRESS) > $@

$(ASAR):
	mkdir -p $(ASAR_DIR)/build && cd $(ASAR_DIR)/build && cmake ../src && make

-include $(DEPENDENCY_FILES)
