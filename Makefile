BIN = petshop
PKG = sdl2 luajit

SRC      = $(wildcard *.c)
HEADERS  = $(wildcard *.h)
OBJS     = $(sort $(patsubst %,%.o,$(BIN)) $(patsubst %.c,%.o,$(SRC)))
DEPS     = $(patsubst %.c,%.d,$(SRC))
CFLAGS  += -MMD -MP -Wall -O3
CFLAGS  += $(shell pkg-config --cflags $(PKG))
LDFLAGS += $(shell pkg-config --libs $(PKG))

all: chargendata.h luacode.h $(BIN)

$(BIN): $(OBJS)

chargendata.h: chargen.bin
	xxd -i chargen.bin > chargendata.h

luacode.h: petshop.lua
	cp petshop.lua code.lua && \
	truncate -s +1 code.lua && \
	xxd -i code.lua > luacode.h
	-rm -f code.lua

clean:
	-rm -f $(OBJS) $(DEPS) $(BIN) tags chargendata.h luacode.h

-include $(DEPS)
# DO NOT DELETE
