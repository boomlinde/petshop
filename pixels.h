#ifndef _PIXELS_H_
#define _PIXELS_H_

#include <SDL.h>
#include <stdint.h>
#include <stddef.h>
#include <string.h>
#include <stdlib.h>

#ifndef PIXELS_WINDOWFLAGS
#define PIXELS_WINDOWFLAGS (SDL_WINDOW_RESIZABLE)
#endif

#ifndef PIXELS_RENDERERFLAGS
#define PIXELS_RENDERERFLAGS (SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC)
#endif

struct pixels {
	SDL_Texture *texture;
	SDL_Window *window;
	SDL_Renderer *renderer;

	int width;
	int height;
	int scale;
	uint32_t *pixels;
};

int pixels_init(struct pixels **p, const char *title, int width, int height, int scale);
void pixels_destroy(struct pixels **p);
void pixels_flush(struct pixels *p);
void pixels_set(struct pixels *p, int x, int y, uint32_t color);
void pixels_virtpos(struct pixels *p, int *x, int *y);
void pixels_realpos(struct pixels *p, int *x, int *y);

#ifdef PIXELS_IMPL

int pixels_init(struct pixels **p, const char *title, int width, int height, int scale)
{
	if (*p) return 1;
	if (!(*p = calloc(1, sizeof **p))) goto err;
	(*p)->width = width;
	(*p)->height = height;
	(*p)->scale = scale;
	if (!((*p)->pixels = calloc(width * height, sizeof (uint32_t)))) goto err;

	(*p)->window = SDL_CreateWindow(
			title,
			SDL_WINDOWPOS_UNDEFINED,
			SDL_WINDOWPOS_UNDEFINED,
			width * scale,
			height * scale,
			PIXELS_WINDOWFLAGS);
	if (!(*p)->window) goto err;

	(*p)->renderer = SDL_CreateRenderer(
			(*p)->window,
			-1,
			PIXELS_RENDERERFLAGS);
	if (!(*p)->renderer) goto err;

	(*p)->texture = SDL_CreateTexture(
			(*p)->renderer,
			SDL_PIXELFORMAT_BGRA32,
			SDL_TEXTUREACCESS_STREAMING, width, height);
	if (!(*p)->texture) goto err;

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

void pixels_destroy(struct pixels **p)
{
	if (!*p) return;

	if ((*p)->texture) SDL_DestroyTexture((*p)->texture);
	if ((*p)->renderer) SDL_DestroyRenderer((*p)->renderer);
	if ((*p)->window) SDL_DestroyWindow((*p)->window);
	free((*p)->pixels);
	free(*p);
	*p = NULL;
}


#endif /* PIXELS_IMPL */

#endif /* _PIXELS_H_ */
