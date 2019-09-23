#include <SDL.h>

#include "ui.h"

char
ui_draw_pic(SDL_Surface *s, int w, int h, SDL_Surface *pic)
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

	return SDL_BlitScaled(pic, &src_rect, s, &dst_rect);
}
