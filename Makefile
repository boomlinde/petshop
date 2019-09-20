BIN = petshop
PKG = sdl2 lua5.1

CC       = gcc
SRC      = $(wildcard *.c)
HEADERS  = $(wildcard *.h)
OBJS     = $(sort $(patsubst %,%.o,$(BIN)) $(patsubst %.c,%.o,$(SRC)))
DEPS     = $(patsubst %.c,%.d,$(SRC))
CFLAGS  += -MMD -MP -Wall
CFLAGS  += $(shell pkg-config --cflags $(PKG))
LDFLAGS += $(shell pkg-config --libs $(PKG))

all: chargendata.h luacode.h $(BIN)

$(BIN): $(OBJS)

run: chargendata.h luacode.h $(BIN)
	./$(BIN)

edit: tags
	vim -c "let &path.=system('make -s vim-path |tr -d \" \t\n\"').','" \
		-c "set tags=./tags;" \
		$(SRC) $(HEADERS)

vim-path:
	@pkg-config --cflags-only-I $(PKG) |sed "s/-I//g" |sed "s/ /,/g"

tags: $(SRC) $(HEADERS)
	ctags -R

chargendata.h: chargen.bin
	xxd -i chargen.bin \
	|sed 's/unsigned char/uint8_t/g' \
	|head -n -1 > chargendata.h

luacode.h: petshop.lua
	cp petshop.lua code.lua && \
	truncate -s +1 code.lua && \
	xxd -i code.lua \
	|sed 's/unsigned char/char/g' \
	|head -n -1 > luacode.h
	-rm -f code.lua

clean:
	-rm -f $(OBJS) $(DEPS) $(BIN) tags chargendata.h luacode.h

-include $(DEPS)
# DO NOT DELETE
