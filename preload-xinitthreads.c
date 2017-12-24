/*
 * Copyright 2017 Simon McVittie
 * Copying and distribution of this file, with or without modification, are
 * permitted in any medium without royalty.
 * This file is offered as-is, without any warranty.
 */

#include <stdlib.h>

#include <X11/Xlib.h>

__attribute__((__constructor__))
void _early_XInitThreads (void)
{
  if (!XInitThreads ())
    abort ();
}
