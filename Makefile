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

build/baby_metroid.00.sfc: build/.stamp build/00.sfc src/main.asm $(SOURCES)
	echo "build/baby_metroid.00.sfc: `$(GENERATE_DEPS) src/main.asm`" > build/baby_metroid.00.sfc.d
	cp build/00.sfc build/.baby_metroid.00.sfc
	$(ASAR) --no-title-check "$$@" src/main.asm build/.baby_metroid.00.sfc
	mv build/.baby_metroid.00.sfc build/baby_metroid.00.sfc

build/baby_metroid.ff.sfc: build/.stamp build/ff.sfc src/main.asm $(SOURCES)
	echo "build/baby_metroid.ff.sfc: `$(GENERATE_DEPS) src/main.asm`" > build/baby_metroid.ff.sfc.d
	cp build/ff.sfc build/.baby_metroid.ff.sfc
	$(ASAR) --no-title-check "$$@" src/main.asm build/.baby_metroid.ff.sfc
	mv build/.baby_metroid.ff.sfc build/baby_metroid.ff.sfc

build/baby_metroid.ips: build/.stamp build/baby_metroid.00.sfc build/baby_metroid.ff.sfc
	./resources/create_ips.py ../build/baby_metroid.00.sfc ../build/baby_metroid.ff.sfc ../build/baby_metroid.ips

rooms/%.bin: rooms/%.hex
	cat $< | $(HEX2BIN) | $(COMPRESS) > $@

-include $(DEPENDENCY_FILES)
