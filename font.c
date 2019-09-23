#include "font.h"
#include "chargendata.h"

SDL_Rect *
char_rect(int c)
{
	static SDL_Rect r;
	c &= 511;
	r.w = 8;
	r.h = 8;

	r.x = (c & 15) * 8;
	r.y = (c >> 4) * 8;

	return &r;
}

static char
chargen_get(int x, int y)
{
	int index;

	index = (x & ~7) + (y & 7) + (y & ~7) * 16;
	return 0 != (chargen_bin[index] & (1 << (~x & 7)));
}

static void
set_pixel(SDL_Surface *surface, int x, int y, uint32_t pixel)
{
	uint8_t *target_pixel = (uint8_t *)surface->pixels + y * surface->pitch + x * 4;
	*(uint32_t *)target_pixel = pixel;
}

char
font_init(SDL_PixelFormat *format, SDL_Surface **font)
{
	int x, y;

	*font = SDL_CreateRGBSurface(
			0, 128, 256, 32,
			format->Rmask,
			format->Gmask,
			format->Bmask,
			~(format->Rmask | format->Gmask | format->Bmask));

	if (*font == NULL) return 1;

	for (y = 0; y < 256; y++) {
		for (x = 0; x < 128; x++) {
			if (chargen_get(x, y)) {
				set_pixel(*font, x, y, 0xffffffff);
			} else {
				set_pixel(*font, x, y, 0);
			}
		}
	}

	SDL_SetSurfaceBlendMode(*font, SDL_BLENDMODE_NONE);
	return 0;
}
