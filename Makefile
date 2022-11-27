ASAR = ../sm_practice_hack/tools/asar
FLIPS = ../Flips/flips
HEX2BIN = tools/hex2bin.py
COMPRESS = tools/compress.py

SOURCES = \
src/main.asm \
src/freeze_enemies.asm \
src/torizos.asm \
src/pirates.asm \
src/enemy_drops.asm \
src/ceres.asm \
rooms/pit_room.asm \
rooms/climb.asm \
rooms/climb.bin

TARGETS = \
	build/baby_metroid.sfc \
	build/baby_metroid.00.sfc \
	build/baby_metroid.ff.sfc \
	build/baby_metroid.ips \

all: build/baby_metroid.sfc

.PHONY: all

clean:
	rm -f $(TARGETS)

.PHONY: clean

build/.stamp:
	mkdir -p build
	touch build/.stamp

build/00.sfc: build/ff.sfc

build/ff.sfc: build/.stamp
	./resources/create_dummies.py ../build/00.sfc ../build/ff.sfc

build/baby_metroid.sfc: build/.stamp resources/sm_orig.sfc build/baby_metroid.ips
	$(FLIPS) --apply build/baby_metroid.ips resources/sm_orig.sfc build/baby_metroid.sfc

build/baby_metroid.00.sfc: build/.stamp build/00.sfc src/main.asm $(SOURCES)
	cp build/00.sfc build/.baby_metroid.00.sfc
	$(ASAR) --no-title-check "$$@" src/main.asm build/.baby_metroid.00.sfc
	mv build/.baby_metroid.00.sfc build/baby_metroid.00.sfc

build/baby_metroid.ff.sfc: build/.stamp build/ff.sfc src/main.asm $(SOURCES)
	cp build/ff.sfc build/.baby_metroid.ff.sfc
	$(ASAR) --no-title-check "$$@" src/main.asm build/.baby_metroid.ff.sfc
	mv build/.baby_metroid.ff.sfc build/baby_metroid.ff.sfc

build/baby_metroid.ips: build/.stamp build/baby_metroid.00.sfc build/baby_metroid.ff.sfc
	./resources/create_ips.py ../build/baby_metroid.00.sfc ../build/baby_metroid.ff.sfc ../build/baby_metroid.ips

rooms/climb.bin: rooms/climb.hex
	cat rooms/climb.hex | $(HEX2BIN) | $(COMPRESS) > rooms/climb.bin
