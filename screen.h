#ifndef SCREEN_H
#define SCREEN_H

#include <stdio.h>
#include <SDL.h>
#include "font.h"

typedef struct {
	uint8_t chars[1000];
	uint8_t colors[1000];
	uint8_t border;
	uint8_t background;
	uint8_t alternate_font;
	int marker_x;
	int marker_y;
	int marker_w;
	int marker_h;
	int lowercase;
} screen_t;

SDL_Surface *screen_redraw(screen_t *screen);

#endif