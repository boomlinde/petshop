#include <SDL.h>

#include "ui.h"
#include "screen.h"

char
ui_draw_pic(SDL_Surface *s, screen_t *pic, int w, int h, SDL_Surface **picsurface, SDL_Surface *font)
{
	SDL_Rect src_rect;
	SDL_Rect dst_rect;

	src_rect.x = 0;
	src_rect.y = 0;
	src_rect.w = 368;
	src_rect.h = 256;

	dst_rect.x = 0;
	dst_rect.y = 0;
	dst_rect.w = w;
	dst_rect.h = h;

	return SDL_BlitScaled(screen_redraw(pic, picsurface, font), &src_rect, s, &dst_rect);
}

char
ui_draw_palette(SDL_Surface *s)
{
	return 0;
}
