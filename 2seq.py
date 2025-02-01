#!/usr/bin/env python2

import sys

OFFSET = 3

def load(fname):
    with open(fname, 'rb+') as f:
        data = f.read()
        chars = data[OFFSET:OFFSET+1000]
        colors = data[OFFSET+1000:OFFSET+2000]
        return (chars, colors)

def char2pet(c):
    c &= 0x7f
    if c >= 0 and c < 32: return c + 64
    elif c >= 32 and c < 64: return c
    elif c >= 64 and c < 96: return c + 128
    elif c >= 96 and c < 128: return c + 64

def col2pet(c):
    return (
        0x90, 0x05, 0x1c, 0x9f, 0x9c, 0x1e, 0x1f, 0x9e,
        0x81, 0x95, 0x96, 0x97, 0x98, 0x99, 0x9a, 0x9b,
    )[c]

def convert(chars, cols):
    inverted = False
    color = -1
    out = [0x93, 0x8e]
    for i in range(1000):
        c = ord(chars[i])
        current_col = ord(cols[i]) & 0xf
        if current_col != color:
            color = current_col
            out.append(col2pet(color))

        if c >= 128 and not inverted:
            inverted = not inverted
            out.append(0x12)
        elif c <= 128 and inverted:
            inverted = not inverted
            out.append(0x92)
        out.append(char2pet(c))

    return ''.join([chr(x) for x in out])

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print >> sys.stderr, "Usage: %s <petshop file>" % sys.argv[0]
        sys.exit(1)
    fname = sys.argv[1]
    chars, cols = load(fname)
    sys.stdout.write(convert(chars, cols))
    sys.stdout.flush()
