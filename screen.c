#include <stdlib.h>

#include "screen.h"

static const SDL_Color colors[] = {
	{0, 0, 0},
	{255, 255, 255},
	{136, 0, 0},
	{170, 255, 238},
	{204, 68, 204},
	{0, 204, 85},
	{0, 0, 170},
	{238, 238, 119},
	{221, 136, 85},
	{102, 68, 0},
	{255, 119, 119},
	{51, 51, 51},
	{119, 119, 119},
	{170, 255, 102},
	{0, 136, 255},
	{187, 187, 187}
};


SDL_Surface *
screen_redraw(screen_t *screen)
{
	static SDL_Surface *rendered = NULL;
	SDL_Rect tmp_rect;
	SDL_Color const *tmp_rgb;
	SDL_Surface *tmp_chr;
	SDL_Surface *tmp_chr2;
	int i;
	int x, y, marked, mask;
	SDL_PixelFormat *format = SDL_AllocFormat(SDL_PIXELFORMAT_RGBA8888);

	// init surface
	if (rendered == NULL) {
		rendered = SDL_CreateRGBSurface(
				0, 368, 256, format->BitsPerPixel,
				format->Rmask,
				format->Gmask,
				format->Bmask,
				format->Amask);
	}

	// draw border
	tmp_rgb = &colors[screen->border];
	SDL_FillRect(rendered,
			NULL,
			SDL_MapRGB(format,
					tmp_rgb->r,
					tmp_rgb->g,
					tmp_rgb->b));

	// draw background
	tmp_rect.x = 3*8;
	tmp_rect.y = 3*8;
	tmp_rect.w = 40*8;
	tmp_rect.h = 25*8;

	tmp_rgb = &colors[screen->background];
	SDL_FillRect(rendered,
			&tmp_rect,
			SDL_MapRGB(format,
					tmp_rgb->r,
					tmp_rgb->g,
					tmp_rgb->b));

	// temporary surface for char coloring
	tmp_chr = SDL_CreateRGBSurface(
			0, 8, 8, format->BitsPerPixel,
			format->Rmask,
			format->Gmask,
			format->Bmask,
			format->Amask);

	tmp_chr2 = SDL_CreateRGBSurface(
			0, 8, 8, format->BitsPerPixel,
			format->Rmask,
			format->Gmask,
			format->Bmask,
			format->Amask);

	SDL_SetSurfaceBlendMode(tmp_chr2, SDL_BLENDMODE_MOD);

	// draw chars
	for (i = 0; i < 1000; i++) {
		x = i % 40;
		y = i / 40;
		tmp_rect.x = x * 8 + 24;
		tmp_rect.y = y * 8 + 24;
		tmp_rect.w = 8;
		tmp_rect.h = 8;
		
		marked = x >= screen->marker_x;
		marked = marked && x < screen->marker_x + screen->marker_w;
		marked = marked && y >= screen->marker_y;
		marked = marked && y < screen->marker_y + screen->marker_h;

		if (marked) {
			tmp_rgb = &colors[screen->background];
			SDL_FillRect(rendered,
					&tmp_rect,
					SDL_MapRGB(format,
							tmp_rgb->r ^ 0xff,
							tmp_rgb->g ^ 0xff,
							tmp_rgb->b ^ 0xff));
		}

		if (marked) mask = 0xff; else mask = 0x00;
		tmp_rgb = &colors[screen->colors[i] & 15];
		SDL_FillRect(tmp_chr2,
				NULL,
				SDL_MapRGBA(tmp_chr->format,
						tmp_rgb->r ^ mask,
						tmp_rgb->g ^ mask,
						tmp_rgb->b ^ mask, 0));

		if (screen->lowercase)
			SDL_BlitSurface(font, char_rect(screen->chars[i] + 256), tmp_chr, NULL);
		else
			SDL_BlitSurface(font, char_rect(screen->chars[i]), tmp_chr, NULL);
		SDL_BlitSurface(tmp_chr2, NULL, tmp_chr, NULL);
		SDL_BlitSurface(tmp_chr, NULL, rendered, &tmp_rect);
	}

	SDL_FreeSurface(tmp_chr);
	SDL_FreeSurface(tmp_chr2);
	SDL_FreeFormat(format);

	return rendered;
}