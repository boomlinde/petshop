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

void pixels_flush(struct pixels *p)
{
	uint32_t *tpixels;
	int pitch;
	float xratio, yratio, scale;
	int wout, hout;
	SDL_Rect dst;

	if (SDL_LockTexture(p->texture, NULL, (void **)&tpixels, &pitch)) return;
	if (pitch != 4 * p->width) {
		SDL_UnlockTexture(p->texture);
		return;
	}

	memcpy(tpixels, p->pixels, p->width * p->height * sizeof (uint32_t));
	SDL_UnlockTexture(p->texture);
	
	SDL_GetRendererOutputSize(p->renderer, &wout, &hout);
	xratio = (float)wout / (float)(p->width);
	yratio = (float)hout / (float)(p->height);
	scale = xratio > yratio ? yratio : xratio;

	dst.x = (float)wout / 2.f - (float)p->width * scale / 2.f;
	dst.y = (float)hout / 2.f - (float)p->height * scale / 2.f;
	dst.w = (float)p->width * scale;
	dst.h = (float)p->height * scale;

	SDL_RenderClear(p->renderer);
	SDL_RenderCopy(p->renderer, p->texture, NULL, &dst);
	SDL_RenderPresent(p->renderer);
}

void pixels_virtpos(struct pixels *p, int *x, int *y)
{
	float xratio, yratio, scale, xf, yf;
	int wout, hout;

	SDL_GetRendererOutputSize(p->renderer, &wout, &hout);
	xratio = (float)wout / (float)(p->width);
	yratio = (float)hout / (float)(p->height);
	scale = xratio > yratio ? yratio : xratio;

	xf = *x - ((float)wout - (float)p->width * scale) / 2.f;
	yf = *y - ((float)hout - (float)p->height * scale) / 2.f;
	xf /= scale;
	yf /= scale;

	*x = xf;
	*y = yf;
}

void pixels_realpos(struct pixels *p, int *x, int *y)
{
	float xratio, yratio, scale;
	int wout, hout;
	float xv, yv;

	SDL_GetRendererOutputSize(p->renderer, &wout, &hout);
	xratio = (float)wout / (float)(p->width);
	yratio = (float)hout / (float)(p->height);
	scale = xratio > yratio ? yratio : xratio;

	xv = 0.5 + ((float)wout - (float)p->width * scale) / 2.f;
	yv = 0.5 + ((float)hout - (float)p->height * scale) / 2.f;
	printf("offs %f,%f\n", xv, yv);

	xv += ((float)*x + 0.5) * scale;
	yv += ((float)*y + 0.5) * scale;
	printf("add %f,%f\n", xv, yv);
	*x = xv;
	*y = yv;
}

void pixels_set(struct pixels *p, int x, int y, uint32_t color)
{
	p->pixels[x + y * p->width] = color;
}

void pixels_destroy(struct pixels **p)
{
	if (*p) return;

	if ((*p)->texture) SDL_DestroyTexture((*p)->texture);
	if ((*p)->renderer) SDL_DestroyRenderer((*p)->renderer);
	if ((*p)->window) SDL_DestroyWindow((*p)->window);
	free((*p)->pixels);
	free(*p);
	*p = NULL;
}


#endif /* PIXELS_IMPL */

#endif /* _PIXELS_H_ */
