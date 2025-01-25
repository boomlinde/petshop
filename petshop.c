#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include <SDL.h>

#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>

#include "luacode.h"
#include "chargendata.h"
#include "petscii.h"

// API functions
static int l_setscreen(lua_State *L);
static int l_setcolor(lua_State *L);
static int l_setborder(lua_State *L);
static int l_setbg(lua_State *L);
static int l_cls(lua_State *L);
static int l_quit(lua_State *L);
static int l_setmarker(lua_State *L);
static int l_lowercase(lua_State *L);
static int l_setbordermod(lua_State *L);
static int l_getmouse(lua_State *L);
static int l_setmouse(lua_State *L);
static int l_mousevisible(lua_State *L);
static int l_screenshot(lua_State *L);
static int l_loadcharset(lua_State *L);
static int l_blockchar(lua_State *L);
static int l_emptychar(lua_State *L);

static void handle_event(lua_State *L);

static int running = 1;
static int err = 0;
static struct petscii pscreen;

static uint8_t charset_buf[2048];

int
main(int argc, char **argv)
{
	SDL_Event event;
	lua_State *L = NULL;
	int i, status, xo, yo, lastxo, lastyo, skip, xm, ym;
	char *emulated;

	lastxo = 0;
	lastyo = 0;
	xo = 0;
	yo = 0;

	if (petscii_init(&pscreen, chargen_bin)) {
		fputs("failed to initialize screen\n", stderr);
		goto exit;
	}

	pscreen.bg = 6;
	pscreen.border = 14;
	pscreen.bordermod = 0;
	for (i = 0; i < 40 * 25; i++) {
		pscreen.chars[i] = 0x20;
		pscreen.colors[i] = 0xe;
	}
	pscreen.mw = 1;
	pscreen.mh = 1;

	L = luaL_newstate();
	luaL_openlibs(L);

	// API functions
	lua_createtable(L, 0, 16);
	lua_pushstring(L, "setscreen"); lua_pushcfunction(L, l_setscreen); lua_settable(L, -3);
	lua_pushstring(L, "setcolor"); lua_pushcfunction(L, l_setcolor); lua_settable(L, -3);
	lua_pushstring(L, "setborder"); lua_pushcfunction(L, l_setborder); lua_settable(L, -3);
	lua_pushstring(L, "setbg"); lua_pushcfunction(L, l_setbg); lua_settable(L, -3);
	lua_pushstring(L, "cls"); lua_pushcfunction(L, l_cls); lua_settable(L, -3);
	lua_pushstring(L, "quit"); lua_pushcfunction(L, l_quit); lua_settable(L, -3);
	lua_pushstring(L, "setmarker"); lua_pushcfunction(L, l_setmarker); lua_settable(L, -3);
	lua_pushstring(L, "setlowercase"); lua_pushcfunction(L, l_lowercase); lua_settable(L, -3);
	lua_pushstring(L, "setbordermod"); lua_pushcfunction(L, l_setbordermod); lua_settable(L, -3);
	lua_pushstring(L, "getmouse"); lua_pushcfunction(L, l_getmouse); lua_settable(L, -3);
	lua_pushstring(L, "setmouse"); lua_pushcfunction(L, l_setmouse); lua_settable(L, -3);
	lua_pushstring(L, "mousevisible"); lua_pushcfunction(L, l_mousevisible); lua_settable(L, -3);
	lua_pushstring(L, "screenshot"); lua_pushcfunction(L, l_screenshot); lua_settable(L, -3);
	lua_pushstring(L, "loadcharset"); lua_pushcfunction(L, l_loadcharset); lua_settable(L, -3);
	lua_pushstring(L, "blockchar"); lua_pushcfunction(L, l_blockchar); lua_settable(L, -3);
	lua_pushstring(L, "emptychar"); lua_pushcfunction(L, l_emptychar); lua_settable(L, -3);
	lua_setglobal(L, "ht");

	// Colors
	lua_createtable(L, 0, 16);
	lua_pushstring(L, "black"); lua_pushnumber(L, 0); lua_settable(L, -3);
	lua_pushstring(L, "white"); lua_pushnumber(L, 1); lua_settable(L, -3);
	lua_pushstring(L, "red"); lua_pushnumber(L, 2); lua_settable(L, -3);
	lua_pushstring(L, "cyan"); lua_pushnumber(L, 3); lua_settable(L, -3);
	lua_pushstring(L, "purple"); lua_pushnumber(L, 4); lua_settable(L, -3);
	lua_pushstring(L, "green"); lua_pushnumber(L, 5); lua_settable(L, -3);
	lua_pushstring(L, "blue"); lua_pushnumber(L, 6); lua_settable(L, -3);
	lua_pushstring(L, "yellow"); lua_pushnumber(L, 7); lua_settable(L, -3);
	lua_pushstring(L, "orange"); lua_pushnumber(L, 8); lua_settable(L, -3);
	lua_pushstring(L, "brown"); lua_pushnumber(L, 9); lua_settable(L, -3);
	lua_pushstring(L, "lightred"); lua_pushnumber(L, 10); lua_settable(L, -3);
	lua_pushstring(L, "darkgrey"); lua_pushnumber(L, 11); lua_settable(L, -3);
	lua_pushstring(L, "grey"); lua_pushnumber(L, 12); lua_settable(L, -3);
	lua_pushstring(L, "lightgreen"); lua_pushnumber(L, 13); lua_settable(L, -3);
	lua_pushstring(L, "lightblue"); lua_pushnumber(L, 14); lua_settable(L, -3);
	lua_pushstring(L, "lightgrey"); lua_pushnumber(L, 15); lua_settable(L, -3);
	lua_setglobal(L, "color");

	lua_createtable(L, 0, 5);
	lua_pushstring(L, "KEYUP"); lua_pushnumber(L, SDL_KEYUP); lua_settable(L, -3);
	lua_pushstring(L, "KEYDOWN"); lua_pushnumber(L, SDL_KEYDOWN); lua_settable(L, -3);
	lua_pushstring(L, "TEXT"); lua_pushnumber(L, SDL_TEXTINPUT); lua_settable(L, -3);
	lua_pushstring(L, "QUIT"); lua_pushnumber(L, SDL_QUIT); lua_settable(L, -3);
	lua_pushstring(L, "MOUSEMOTION"); lua_pushnumber(L, SDL_MOUSEMOTION); lua_settable(L, -3);
	lua_setglobal(L, "ev");

	// Args
	lua_createtable(L, argc - 1, 0);
	for (i = 1; i < argc; i++) {
		lua_pushnumber(L, i);
		lua_pushstring(L, argv[i]);
		lua_settable(L, -3);
	}
	lua_setglobal(L, "args");

	status = luaL_dostring(L, (char *)code_lua);
	if (status) {
		fprintf(stderr, "Couldn't load script: %s\n", lua_tostring(L, -1));
		err = 1;
		goto exit;
	}

	SDL_FlushEvents(0, SDL_LASTEVENT);
	SDL_StartTextInput();
	while (running) {
		skip = 1;
		petscii_flush(&pscreen);
skipredraw:
		if (SDL_WaitEvent(&event)) {
			switch (event.type) {
			case SDL_QUIT:
				lua_getglobal(L, "handle");
				lua_createtable(L, 0, 1);
				lua_pushstring(L, "t"); lua_pushnumber(L, event.type); lua_settable(L, -3);
				handle_event(L);
				break;
			case SDL_KEYUP:
			case SDL_KEYDOWN:
				/* Only handle repeat events from cursor movement keys */
				if (event.key.repeat) {
					if (!(
						event.key.keysym.sym == SDLK_h ||
						event.key.keysym.sym == SDLK_j ||
						event.key.keysym.sym == SDLK_k ||
						event.key.keysym.sym == SDLK_l ||
						event.key.keysym.sym == SDLK_UP ||
						event.key.keysym.sym == SDLK_DOWN ||
						event.key.keysym.sym == SDLK_LEFT ||
						event.key.keysym.sym == SDLK_RIGHT ||
						event.key.keysym.sym == SDLK_BACKSPACE
					)) {
						break;
					}
				}
				lua_getglobal(L, "handle");
				lua_createtable(L, 0, 2);
				lua_pushstring(L, "t"); lua_pushnumber(L, event.type);
				lua_settable(L, -3);

				lua_pushstring(L, "key");
				lua_pushstring(L, SDL_GetKeyName(event.key.keysym.sym));
				lua_settable(L, -3);

				handle_event(L);
				break;
			case SDL_TEXTINPUT:
				lua_getglobal(L, "handle");
				lua_createtable(L, 0, 2);
				lua_pushstring(L, "t"); lua_pushnumber(L, event.type); lua_settable(L, -3);
				lua_pushstring(L, "key"); lua_pushstring(L, event.text.text); lua_settable(L, -3);
				handle_event(L);
				break;
			case SDL_WINDOWEVENT:
				skip = 0;
			case SDL_MOUSEMOTION:
				SDL_GetMouseState(&xm, &ym);
				pixels_virtpos(&pscreen.s, &xm, &ym);
				xo = xm / 8 - 3;
				yo = ym / 8 - 3;
				if (xo < 0) xo = 0;
				if (xo > 39) xo = 39;
				if (yo < 0) yo = 0;
				if (yo > 24) yo = 24;
				if (lastxo != xo || lastyo != yo) {
					lastxo = xo;
					lastyo = yo;
					lua_getglobal(L, "handle");
					lua_createtable(L, 0, 3);
					lua_pushstring(L, "t"); lua_pushnumber(L, event.type); lua_settable(L, -3);
					lua_pushstring(L, "x"); lua_pushnumber(L, xo); lua_settable(L, -3);
					lua_pushstring(L, "y"); lua_pushnumber(L, yo); lua_settable(L, -3);
					handle_event(L);
				} else if (skip) {
					goto skipredraw;
				}
				break;
			case SDL_MOUSEBUTTONUP:
			case SDL_MOUSEBUTTONDOWN:
				/* Handle mouse click like Return on keyboard */
				switch (event.button.button) {
				case SDL_BUTTON_LEFT:
					emulated = "4";
					break;
				case SDL_BUTTON_RIGHT:
					emulated = "Left Shift";
					break;
				case SDL_BUTTON_MIDDLE:
					emulated = "Y";
					break;
				default:
					goto skipredraw;
				}
				lua_getglobal(L, "handle");
				lua_createtable(L, 0, 2);
				lua_pushstring(L, "t");
				switch (event.type) {
				case SDL_MOUSEBUTTONUP:
					lua_pushnumber(L, SDL_KEYUP);
					break;
				case SDL_MOUSEBUTTONDOWN:
					lua_pushnumber(L, SDL_KEYDOWN);
					break;
				default:
					/* unreachable */
				}
				lua_settable(L, -3);
				lua_pushstring(L, "key"); lua_pushstring(L, emulated); lua_settable(L, -3);
				handle_event(L);
				break;
			default:
				goto skipredraw;
			}
		}

	}
	SDL_StopTextInput();

exit:
	petscii_destroy(&pscreen);
	SDL_Quit();
	if (L) lua_close(L);
	return err;
}

// API functions
static int
l_setscreen(lua_State *L)
{
	int x, y, c;
	x = (int)lua_tonumber(L, 1);
	y = (int)lua_tonumber(L, 2);
	c = (int)lua_tonumber(L, 3);
	pscreen.chars[x + y * 40] = (uint8_t)c;
	return 0;
}

static int
l_setcolor(lua_State *L)
{
	int x, y, c;
	x = (int)lua_tonumber(L, 1);
	y = (int)lua_tonumber(L, 2);
	c = (int)lua_tonumber(L, 3);
	pscreen.colors[x + y * 40] = (uint8_t)c;
	return 0;
}

static int
l_setborder(lua_State *L)
{
	int c;
	c = 0xf & (int)lua_tonumber(L, 1);
	pscreen.border = c;
	return 0;
}

static int
l_setbg(lua_State *L)
{
	int c;
	c = 0xf & (int)lua_tonumber(L, 1);
	pscreen.bg = c;
	return 0;
}

static int
l_cls(lua_State *L)
{
	memset(pscreen.chars, 0x20, 1000);
	memset(pscreen.colors, 0xe, 1000);
	return 0;
}

static int
l_lowercase(lua_State *L)
{
	pscreen.lowercase = (int)lua_toboolean(L, 1);
	return 0;
}

static int
l_quit(lua_State *L)
{
	running = 0;
	err = lua_tonumber(L, 1);
	return 0;
}

static int
l_setmarker(lua_State *L)
{
	int x, y, w, h, x2, y2;
	x = (int)lua_tonumber(L, 1);
	y = (int)lua_tonumber(L, 2);
	w = (int)lua_tonumber(L, 3);
	h = (int)lua_tonumber(L, 4);

	x2 = x + w;
	y2 = y + h;
	if (x2 > 40) x2 = 40;
	if (x2 < 0) x2 = 0;
	if (x > 40) x = 40;
	if (x < 0) x = 0;
	if (y2 > 25) y2 = 25;
	if (y2 < 0) y2 = 0;
	if (y > 25) y = 25;
	if (y < 0) y = 0;

	pscreen.mx = x;
	pscreen.my = y;
	pscreen.mw = w;
	pscreen.mh = h;

	return 0;
}

static int
l_setbordermod(lua_State *L)
{
	pscreen.bordermod = (int)lua_tonumber(L, 1);
	return 0;
}

static int
l_getmouse(lua_State *L)
{
	int x, y;

	SDL_GetMouseState(&x, &y);
	pixels_virtpos(&pscreen.s, &x, &y);
	lua_pushnumber(L, x);
	lua_pushnumber(L, y);

	return 2;
}

static int
l_setmouse(lua_State *L)
{
	int x, y;
	x = (int)lua_tonumber(L, 1);
	y = (int)lua_tonumber(L, 2);
	pixels_realpos(&pscreen.s, &x, &y);
	SDL_WarpMouseInWindow(pscreen.s.window, x, y);
	return 0;
}

static int
l_mousevisible(lua_State *L)
{
	SDL_ShowCursor((int)lua_tonumber(L, 1));
	return 0;
}

static int
l_screenshot(lua_State *L)
{
	const char *filename = lua_tostring(L, 1);
	if (!strlen(filename)) return 0;
	petscii_flush(&pscreen);
	pixels_screenshot(&pscreen.s, filename);
	return 0;
}

static int
l_loadcharset(lua_State *L)
{
	FILE *f = NULL;
	const char *filename = lua_tostring(L, 1);
	if (!strlen(filename)) return 0;
	f = fopen(filename, "r");
	if (f == NULL) return 0;
	size_t nread = fread(charset_buf, 1, 2048, f);
	if (nread == 2048) pscreen.chargen = charset_buf;
	fclose(f);
	return 0;
}

static int
l_blockchar(lua_State *L)
{
	lua_pushnumber(L, petscii_getblock(&pscreen));
	return 1;
}

static int
l_emptychar(lua_State *L)
{
	lua_pushnumber(L, petscii_getempty(&pscreen));
	return 1;
}

static void
handle_event(lua_State *L)
{
	int status;
	status = lua_pcall(L, 1, 0, 0);
	if (status) {
		fprintf(stderr, "Event: %s\n", lua_tostring(L, -1));
		err = 1;
		running = 0;
	}
}

