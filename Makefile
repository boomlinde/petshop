BIN = petshop
PKG = sdl2 luajit

SRC      = $(wildcard *.c)
OBJS     = $(sort $(patsubst %,%.o,$(BIN)) $(patsubst %.c,%.o,$(SRC)))
CFLAGS  += -flto -Wall -O3
CFLAGS  += $(shell pkg-config --cflags $(PKG))
LDFLAGS += $(shell pkg-config --libs $(PKG))

$(BIN): $(OBJS)

petshop.o: petshop.c luacode.h chargendata.h petscii.h pixels.h

chargendata.h: chargen.bin
	xxd -i chargen.bin > chargendata.h

luacode.h: petshop.lua
	cp petshop.lua code.lua && \
	truncate -s +1 code.lua && \
	xxd -i code.lua > luacode.h
	-rm -f code.lua

clean:
	-rm -f $(OBJS) $(DEPS) $(BIN) chargendata.h luacode.h
