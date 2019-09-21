#ifndef FONT_H
#define FONT_H

#include <SDL.h>

SDL_Rect *char_rect(int c);
char font_init(SDL_PixelFormat *format, SDL_Surface **font);

#endif
