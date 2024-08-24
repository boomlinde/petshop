#include <SDL.h>
#include <stdint.h>
#include <stddef.h>
#include <string.h>
#include <stdlib.h>

#ifndef PIXELS_WINDOWFLAGS
#define PIXELS_WINDOWFLAGS (SDL_WINDOW_RESIZABLE)
#endif

#ifndef PIXELS_WINDOWSCALE
#define PIXELS_WINDOWSCALE 1
#endif

#ifndef PIXELS_RENDERERFLAGS
#define PIXELS_RENDERERFLAGS (SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC)
#endif

#ifdef PIXELS_SCREENSHOT
#include "stb_image_write.h"
#endif

#ifndef _PIXELS_H_
#define _PIXELS_H_

struct pixels {
	SDL_Texture *texture;
	SDL_Window *window;
	SDL_Renderer *renderer;

	int width;
	int height;
	uint32_t *pixels;
};

int pixels_init(struct pixels *p, const char *title, int width, int height);
void pixels_destroy(struct pixels *p);

void pixels_set(struct pixels *p, int x, int y, uint32_t color);
void pixels_flush(struct pixels *p);

float pixels_getrect(struct pixels *p, SDL_Rect *r);
void pixels_virtpos(struct pixels *p, int *x, int *y);
void pixels_realpos(struct pixels *p, int *x, int *y);

#endif /* _PIXELS_H_ */

#ifndef PIXELS_HEADER

#ifdef PIXELS_SCREENSHOT
#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "stb_image_write.h"

int pixels_screenshot(struct pixels *p, const char *filename);
#endif /* PIXELS_SCREENSHOT */

int pixels_init(struct pixels *p, const char *title, int width, int height)
{
	if (!p) return 1;
	memset(p, 0, sizeof (*p));
	p->width = width;
	p->height = height;
	if (!(p->pixels = calloc(width * height, sizeof (uint32_t)))) goto err;

	p->window = SDL_CreateWindow(
			title,
			SDL_WINDOWPOS_UNDEFINED,
			SDL_WINDOWPOS_UNDEFINED,
			width * PIXELS_WINDOWSCALE,
			height * PIXELS_WINDOWSCALE,
			PIXELS_WINDOWFLAGS);
	if (!p->window) goto err;

	p->renderer = SDL_CreateRenderer(
			p->window,
			-1,
			PIXELS_RENDERERFLAGS);
	if (!p->renderer) goto err;

	p->texture = SDL_CreateTexture(
			p->renderer,
			SDL_PIXELFORMAT_BGRA32,
			SDL_TEXTUREACCESS_STREAMING, width, height);
	if (!p->texture) goto err;

	SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, "linear");

	return 0;
err:
	pixels_destroy(p);
	return 1;
}

float pixels_getrect(struct pixels *p, SDL_Rect *r)
{
	float xratio, yratio, scale;
	int ww, wh;


	SDL_GetRendererOutputSize(p->renderer, &ww, &wh);

	xratio = (float)ww / (float)p->width;
	yratio = (float)wh / (float)p->height;
	scale = xratio < yratio ? xratio : yratio;

#ifdef PIXELS_INTEGERSCALE
	scale = SDL_floor(scale);
	if (scale == 0) scale = 1;
#endif

	if (!r) return scale;

	r->w = (float)p->width * scale;
	r->h = (float)p->height * scale;
	r->x = ww / 2 - r->w / 2;
	r->y = wh / 2 - r->h / 2;

	return scale;
}

void pixels_flush(struct pixels *p)
{
	uint32_t *tpixels;
	int pitch;
	SDL_Rect r;

	if (SDL_LockTexture(p->texture, NULL, (void **)&tpixels, &pitch)) return;
	if (pitch != 4 * p->width) {
		SDL_UnlockTexture(p->texture);
		return;
	}

	memcpy(tpixels, p->pixels, p->width * p->height * sizeof (uint32_t));
	SDL_UnlockTexture(p->texture);

	pixels_getrect(p, &r);
	SDL_RenderClear(p->renderer);
	SDL_RenderCopy(p->renderer, p->texture, NULL, &r);
	SDL_RenderPresent(p->renderer);
}

void pixels_virtpos(struct pixels *p, int *x, int *y)
{
	SDL_Rect r;
	float scale;

	scale = pixels_getrect(p, &r);
	*x = (float)(*x - r.x) / scale;
	*y = (float)(*y - r.y) / scale;
}

void pixels_realpos(struct pixels *p, int *x, int *y)
{
	SDL_Rect r;
	float scale;

	scale = pixels_getrect(p, &r);
	*x = (float)r.x + (float)*x * scale;
	*y = (float)r.y + (float)*y * scale;
}

void pixels_set(struct pixels *p, int x, int y, uint32_t color)
{
	p->pixels[x + y * p->width] = color;
}

void pixels_destroy(struct pixels *p)
{
	if (p->texture) SDL_DestroyTexture(p->texture);
	if (p->renderer) SDL_DestroyRenderer(p->renderer);
	if (p->window) SDL_DestroyWindow(p->window);
	free(p->pixels);
	memset(p, 0, sizeof (*p));
}

#ifdef PIXELS_SCREENSHOT
int pixels_screenshot(struct pixels *p, const char *filename)
{
	int i;
	char *const bitmap = calloc(3 * p->width * p->height, sizeof (uint8_t));
	char *bp = bitmap;

	if (!bitmap) return 0;


	for (i = 0; i < p->width * p->height; i++) {
		*bp++ = (p->pixels[i] >> 16) & 0xff;
		*bp++ = (p->pixels[i] >> 8) & 0xff;
		*bp++ = (p->pixels[i] >> 0) & 0xff;
	}

	int err = stbi_write_png(filename, p->width, p->height, 3, bitmap, 3 * p->width);
	free(bitmap);

	return err == 0;
}
#endif /* PIXELS_SCREENSHOT */

#endif /* ifndef PIXELS_HEADER */
