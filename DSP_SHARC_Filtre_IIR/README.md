# SHARC DSP — Interrupt-Driven IIR Filtering Exercise

A C laboratory on an Analog Devices ADSP-21060 connected to an AD1847 audio codec, exploring sample-by-sample filtering in a DMA receive-interrupt handler.

## Attribution

[`src/BUTTER.C`](src/BUTTER.C) is based on the instructor's `CANEVAS.C` scaffold. DSP/timer initialisation, SPORT0/TDM configuration, chained DMA, codec setup and the main program originate from that scaffold.

The student's contribution is the filtering work in `it_dma_receive` and associated includes/definitions. It is isolated in [`src/filtre_iir_it_dma_receive.c`](src/filtre_iir_it_dma_receive.c). This attribution is part of the technical scope.

## Acquisition and processing chain

The scaffold documents a 40 MHz DSP clock and signed 16-bit stereo audio at 8 kHz. SPORT0 exchanges TDM words via chained DMA. On reception, the handler reads the left-channel sample from `rx_buf[1]`, calls `iir()` and writes `tx_buf[1]`.

At 8 kHz, the nominal sample interval is 125 µs. A successful real-time implementation must fit its processing and interrupt overhead into the available schedule.

## Filter representation

The archived coefficients are:

```c
a = {0.021, 0.042, 0.021}
b = {1.000, -1.547, 0.632}
```

They suggest a second-order low-pass form with near-unit DC gain under the corresponding transfer-function convention. Verify the library's coefficient layout, signs and state-buffer requirements before assigning a precise response or cutoff.

## Critical state-lifetime issue

The handler declares a local state buffer, clears it inside a loop and calls the filter repeatedly during that same loop. Recursive history is therefore not retained correctly across incoming samples, and the buffer is only partially initialised at the first calls.

For a proper IIR implementation, initialise the complete state once, preserve it between interrupts and invoke the sample-processing operation once per intended sample. Review conversion/scaling between floating-point output and signed codec words.

The archived source is preserved; this README does not claim that it currently implements the intended filter correctly.

## Build requirements

A compatible Analog Devices toolchain, board support and headers such as `def21060.h`, `21060.h`, `sport.h` and `filters.h` are required. The exact board revision/toolchain version still needs documentation.

Inspect the full scaffold and configure the original hardware before compiling, loading and measuring the audio chain.

## Validation

No measured frequency response, execution time or oscilloscope evidence is newly available. The program was not rebuilt or tested for this documentation update.

## Licence

No project-wide licence has been defined. The instructor scaffold retains its original authorship.
