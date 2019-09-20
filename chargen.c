#include <SDL.h>
#include <stdlib.h>

#include "chargen.h"
#include "chargendata.h"

char
chargen_get(int x, int y)
{
	int index;

	index = (x & ~7) + (y & 7) + (y & ~7) * 16;
	return 0 != (chargen_bin[index] & (1 << (~x & 7)));
}
