BIN = petshop
PKG = sdl2 lua

PKGCONFIG ?= pkg-config

CFLAGS  += -flto -Wall -O3
CFLAGS  += $(shell $(PKGCONFIG) --cflags $(PKG))
LDLIBS  += $(shell $(PKGCONFIG) --libs $(PKG))
LDFLAGS += -flto

$(BIN): petshop.o

petshop.o: petshop.c luacode.h chargendata.h petscii.h pixels.h stb_image_write.h

chargendata.h: chargen.bin
	xxd -i chargen.bin > chargendata.h

luacode.h: petshop.lua
	cp petshop.lua code.lua && \
	truncate -s +1 code.lua && \
	xxd -i code.lua > luacode.h
	-rm -f code.lua

clean:
	-rm -f $(BIN) $(BIN).exe chargendata.h luacode.h *.o
