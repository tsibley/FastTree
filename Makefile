SHELL = /bin/bash

CC      = gcc
CFLAGS  = -O3 -finline-functions -funroll-loops -Wall
LDFLAGS = -lm
prefix  = /usr/local

all: FastTree FastTreeDbl FastTreeMP FastTreeDblMP

install:
	@for exe in FastTree{,Dbl{,MP},MP}; do \
		if [[ -s $$exe ]]; then \
			install -v $$exe $(prefix)/bin; \
		fi; \
	done

clean:
	rm -fv FastTree{,Dbl{,MP},MP}

FastTree FastTreeDbl FastTreeMP FastTreeDblMP: FastTree.c
	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS)

FastTreeDbl FastTreeDblMP: CFLAGS += -DUSE_DOUBLE
FastTreeMP  FastTreeDblMP: CFLAGS += -DOPENMP -fopenmp

FastTree.c:
	curl -fsSL http://www.microbesonline.org/fasttree/$@ -o $@
