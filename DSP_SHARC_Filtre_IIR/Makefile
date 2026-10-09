CC ?= cc
CFLAGS ?= -std=c11 -Wall -Wextra -Wpedantic -Werror -O2

.PHONY: test clean
test: build/test_biquad
	./build/test_biquad

build/test_biquad: tests/test_biquad.c src/biquad_filter.h src/filtre_iir_it_dma_receive.c
	mkdir -p build
	$(CC) $(CFLAGS) tests/test_biquad.c src/filtre_iir_it_dma_receive.c -lm -o $@

clean:
	rm -rf build
