SHELL = bash -o pipefail

ASAR = ../sm_practice_hack/tools/asar -w1013
FLIPS = ../Flips/flips
HEX2BIN = tools/hex2bin.py
COMPRESS = tools/compress.py
GENERATE_DEPS = tools/generate_deps.py

SOURCES = \
src/main.asm

DEPENDENCY_FILES = \
	build/baby_metroid.00.sfc.d \
	build/baby_metroid.ff.sfc.d \

TARGETS = \
	build/baby_metroid.sfc \
	build/baby_metroid.00.sfc \
	build/baby_metroid.ff.sfc \
	build/baby_metroid.ips \

ROOMS = \
	src/rooms/climb.bin \
	src/rooms/noob_bridge.bin \
	src/rooms/early_supers.bin \
	src/rooms/speed_hallway.bin \
	src/rooms/red_tower.bin \
	src/rooms/hellway.bin \
	src/rooms/alpha_power_bombs.bin \
	src/rooms/moat.bin \
	src/rooms/west_ocean.bin \
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

all: build/baby_metroid.sfc

.PHONY: all

clean:
	rm -f $(TARGETS) $(DEPENDENCY_FILES)

.PHONY: clean

build/.stamp:
	mkdir -p build
	touch build/.stamp

build/00.sfc: build/ff.sfc

build/ff.sfc: build/.stamp
	./resources/create_dummies.py ../build/00.sfc ../build/ff.sfc

build/baby_metroid.sfc: build/.stamp resources/sm_orig.sfc build/baby_metroid.ips
	$(FLIPS) --apply build/baby_metroid.ips resources/sm_orig.sfc build/baby_metroid.sfc

build/baby_metroid.00.sfc: build/.stamp build/00.sfc src/main.asm $(SOURCES) ${ROOMS}
	echo "build/baby_metroid.00.sfc: `$(GENERATE_DEPS) src/main.asm`" > build/baby_metroid.00.sfc.d
	cp build/00.sfc build/.baby_metroid.00.sfc
	$(ASAR) --no-title-check "$$@" src/main.asm build/.baby_metroid.00.sfc
	mv build/.baby_metroid.00.sfc build/baby_metroid.00.sfc

build/baby_metroid.ff.sfc: build/.stamp build/ff.sfc src/main.asm $(SOURCES) ${ROOMS}
	echo "build/baby_metroid.ff.sfc: `$(GENERATE_DEPS) src/main.asm`" > build/baby_metroid.ff.sfc.d
	cp build/ff.sfc build/.baby_metroid.ff.sfc
	$(ASAR) --no-title-check "$$@" src/main.asm build/.baby_metroid.ff.sfc
	mv build/.baby_metroid.ff.sfc build/baby_metroid.ff.sfc

build/baby_metroid.ips: build/.stamp build/baby_metroid.00.sfc build/baby_metroid.ff.sfc
	./resources/create_ips.py ../build/baby_metroid.00.sfc ../build/baby_metroid.ff.sfc ../build/baby_metroid.ips

src/rooms/%.bin: src/rooms/%.hex
	cat $< | $(HEX2BIN) | $(COMPRESS) > $@

-include $(DEPENDENCY_FILES)
