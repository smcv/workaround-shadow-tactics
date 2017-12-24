# Copyright 2017 Simon McVittie
# Copying and distribution of this file, with or without modification, are
# permitted in any medium without royalty.
# This file is offered as-is, without any warranty.

all: 32/preload-xinitthreads.so
#all: 64/preload-xinitthreads.so

X11_CFLAGS = $(shell pkg-config --cflags x11)
X11_LIBS = $(shell pkg-config --libs x11)

32/preload-xinitthreads.so: preload-xinitthreads.c Makefile
	@mkdir -p $(dir $@)
	gcc -m32 -shared $(X11_CFLAGS) -o$@ $< $(X11_LIBS)

64/preload-xinitthreads.so: preload-xinitthreads.c Makefile
	@mkdir -p $(dir $@)
	gcc -m64 -shared $(X11_CFLAGS) -o$@ $< $(X11_LIBS)

install: all
	install -d /usr/local/lib/i386-linux-gnu/
	install -m644 32/preload-xinitthreads.so /usr/local/lib/i386-linux-gnu/
	#install -d /usr/local/lib/x86_64-linux-gnu/
	#install -m644 64/preload-xinitthreads.so /usr/local/lib/x86_64-linux-gnu/

clean:
	rm -f 32/preload-xinitthreads.so
	rm -f 64/preload-xinitthreads.so
