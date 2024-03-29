SHELL = bash -o pipefail

ASAR_DIR = tools/asar
ASAR = $(ASAR_DIR)/build/asar/bin/asar
FLIPS = ../Flips/flips
HEX2BIN = tools/hex2bin.py
COMPRESS = tools/compress.py
GENERATE_DEPS = tools/generate_deps.py

ASAR_FLAGS = -w1013 --no-title-check --symbols=wla

SOURCES = \
src/main.asm

DEPENDENCY_FILES = \
	build/baby_metroid.asar.ips.d \

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
	src/rooms/bat_cave.bin \
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
	src/rooms/below_landing_site.bin \
	src/rooms/red_brinstar_fireflea.bin \
	src/rooms/dead_scientist_room.bin \

GRAPHICS = \
	src/cinematic/intro_bg1_tilemap.bin \
	src/title/title_tiles.bin \
	src/title/title_bg_tilemap.bin \

all: build/baby_metroid.sfc build/baby_metroid.ips

.PHONY: all

clean:
	rm -f $(TARGETS) $(DEPENDENCY_FILES)

.PHONY: clean

build/.stamp:
	mkdir -p build
	touch build/.stamp

build/baby_metroid.sfc: build/.stamp resources/sm_orig.sfc build/baby_metroid.asar.ips
	$(FLIPS) --apply build/baby_metroid.asar.ips resources/sm_orig.sfc build/baby_metroid.sfc

build/baby_metroid.asar.ips: $(ASAR) $(SOURCES) $(ROOMS) $(GRAPHICS)
	echo "build/baby_metroid.asar.ips: `$(GENERATE_DEPS) src/main.asm`" > build/baby_metroid.asar.ips.d
	$(ASAR) $(ASAR_FLAGS) --symbols-path=build/baby_metroid.sym --ips build/baby_metroid.asar.ips "$$@" src/main.asm build/scratch.sfc

build/baby_metroid.ips: build/baby_metroid.sfc
	$(FLIPS) --create resources/sm_orig.sfc build/baby_metroid.sfc build/baby_metroid.ips

src/rooms/%.bin: src/rooms/%.hex
	cat $< | $(HEX2BIN) | $(COMPRESS) > $@

src/cinematic/intro_bg1_tilemap.bin: src/cinematic/intro_bg1_tilemap.hex
	cat $< | $(HEX2BIN) | $(COMPRESS) > $@

src/title/title_tiles.bin: src/title/title_tiles.chr
	cat $< | $(COMPRESS) > $@

src/title/title_bg_tilemap.bin: src/title/title_bg_tilemap.hex
	cat $< | $(HEX2BIN) | $(COMPRESS) > $@

$(ASAR):
	mkdir -p $(ASAR_DIR)/build && cd $(ASAR_DIR)/build && cmake ../src && make

-include $(DEPENDENCY_FILES)
