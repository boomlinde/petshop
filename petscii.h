#ifndef _PETSCII_H_
#define _PETSCII_H_

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

#define PIXELS_INTEGERSCALE
#define PIXELS_WINDOWSCALE 3
#define PIXELS_RENDERERFLAGS (SDL_RENDERER_ACCELERATED)
#include "pixels.h"

struct petscii {
	uint8_t *chars;
	uint8_t *colors;
	uint16_t *cmp;

	uint8_t bg, bgcmp;
	uint8_t border, bordercmp;
	uint8_t bordermod, bordermodcmp;
	uint8_t lowercase, lowercasecmp;

	uint8_t mx, my, mw, mh;

	uint8_t *chargen;

	struct pixels s;
};

static const uint32_t petscii_colors[] = {
	0x000000,
	0xffffff,
	0x68372b,
	0x70a4b2,
	0x6f3d86,
	0x588d43,
	0x352879,
	0xb8c76f,
	0x6f4f25,
	0x433900,
	0x9a6759,
	0x444444,
	0x6c6c6c,
	0x9ad284,
	0x6c5eb5,
	0x959595,
};

void petscii_destroy(struct petscii *p);

int petscii_init(struct petscii *p, uint8_t *chargen)
{
	if (!p) return 1;
	memset(p, 0, sizeof(*p));
	if (pixels_init(&p->s, "petshop", (40 + 3 + 3) * 8 , (25 + 3 + 3) * 8)) {
		return 1;
	}
	p->chars = calloc(1000, sizeof (uint8_t));
	p->colors = calloc(1000, sizeof (uint8_t));
	p->cmp = calloc(1000, sizeof (uint16_t));
	if (!p->chars || !p->colors || !p->cmp) {
		petscii_destroy(p);
		return 1;
	}
	memset(p->cmp, 0xff, 1000 * sizeof (uint16_t));

	p->chargen = chargen;
	p->bg = 0;
	p->bgcmp = 0xff;

	p->border = 0;
	p->bordercmp = 0xff;

	p->bordermod = 0;
	p->bordermodcmp = 0xff;

	p->lowercase = 0;
	p->lowercasecmp = 0xff;

	p->mx = 0;
	p->my = 0;
	p->mw = 0;
	p->mh = 0;

	return 0;
}

void petscii_destroy(struct petscii *p)
{
	pixels_destroy(&p->s);
	free(p->chars);
	p->chars = 0;
	free(p->colors);
	p->colors = 0;
	free(p->cmp);
	p->cmp = 0;
}

static int
petscii_drawborder(struct petscii *p)
{
	int x, y;
	uint32_t color;

	if (p->border == p->bordercmp && p->bordermod == p->bordermodcmp) return 0;
	p->bordercmp = p->border;
	p->bordermodcmp = p->bordermod;

	color = petscii_colors[p->border & 0xf];
	color ^= p->bordermod;
	color ^= p->bordermod << 8;
	color ^= p->bordermod << 16;

	/* top+bottom border */
	for (y = 0; y < 3*8; y++) {
		for (x = 0; x < (6 + 40)*8 ; x++) {
			pixels_set(&p->s, x, y, color);
			pixels_set(&p->s, x, y + (3 + 25)*8, color);
		}
	}

	/* sides */
	for (y = 3*8; y < (3 + 25)*8; y++) {
		for (x = 0; x < 3*8 ; x++) {
			pixels_set(&p->s, x, y, color);
			pixels_set(&p->s, x + (3 + 40)*8, y, color);
		}
	}

	return 1;
}

static void
petscii_drawchar(struct petscii *p, int x, int y, uint8_t ch, uint8_t fg, int marked)
{
	int ox, oy, iy, ix;
	uint8_t *chargen;
	uint32_t c, fgc, bgc;

	fgc = petscii_colors[fg & 0xf];
	bgc = petscii_colors[p->bg & 0xf];
	if (marked) {
		bgc ^= 0xffffff;
		fgc ^= 0xffffff;
	}

	chargen = p->chargen + (ch << 3);
	if (p->lowercase) {
		chargen += 2048;
	}

	ox = (3 + x)*8;
	oy = (3 + y)*8;

	for (iy = 0; iy < 8; iy++) {
		for (ix = 0; ix < 8; ix++) {
			if (*chargen & (1 << (7 - ix))) {
				c = fgc;
			} else {
				c = bgc;
			}
			pixels_set(&p->s, ox + ix, oy + iy, c);
		}
		++chargen;
	}
}

static void
petscii_evalchar(struct petscii *p, int x, int y, int forced)
{
	int i, marked;
	uint8_t col, ch;
	uint16_t cmp;

	i = y * 40 + x;
	ch = p->chars[i];
	col = p->colors[i];
	marked = x >= p->mx && x < p->mx + p->mw && y >= p->my && y < p->my + p->mh;

	cmp = ((col & 0xf) << 8) | ch | (marked << 12);
	if (forced || cmp != p->cmp[i]) {
		p->cmp[i] = cmp;
		petscii_drawchar(p, x, y, ch, col, marked);
	}
}

static void
petscii_flush(struct petscii *p)
{
	int x, y, forced, changed;

	changed = petscii_drawborder(p);
	forced = 0;
	if (p->lowercase != p->lowercasecmp || p->bg != p->bgcmp) {
		p->lowercasecmp = p->lowercase;
		p->bgcmp = p->bg;
		forced = 1;
	}

	for (y = 0; y < 25; y++) {
		for (x = 0; x < 40; x++) {
			petscii_evalchar(p, x, y, forced);
			changed = 1;
		}
	}
	if (changed) pixels_flush(&p->s);
}

#endif /* _PETSCII_H_ */
