# SHARC DSP — Interrupt-Driven IIR Filtering Exercise

A C laboratory on an Analog Devices ADSP-21060 connected to an AD1847 audio codec, exploring sample-by-sample filtering in a DMA receive-interrupt handler.

## Attribution

[`src/BUTTER.C`](src/BUTTER.C) is based on the instructor's `CANEVAS.C` scaffold. DSP/timer initialisation, SPORT0/TDM configuration, chained DMA, codec setup and the main program originate from that scaffold.

The student's contribution is the filtering work in `it_dma_receive` and associated includes/definitions. It is isolated in [`src/filtre_iir_it_dma_receive.c`](src/filtre_iir_it_dma_receive.c). This attribution is part of the technical scope.

## Acquisition and processing chain

The scaffold documents a 40 MHz DSP clock and signed 16-bit stereo audio at 8 kHz. SPORT0 exchanges TDM words via chained DMA. On reception, the handler reads the left-channel sample from `rx_buf[1]`, evaluates one explicit biquad recurrence and writes the saturated signed-16-bit result to `tx_buf[1]`. The right channel is unchanged by this left-channel exercise.

At 8 kHz, the nominal sample interval is 125 µs. A successful real-time implementation must fit its processing and interrupt overhead into the available schedule.

## Filter representation

The archived coefficients are:

```c
a = {0.021, 0.042, 0.021}
b = {1.000, -1.547, 0.632}
```

The corrected implementation makes the transfer-function convention explicit:

```text
H(z) = (0.021 + 0.042 z^-1 + 0.021 z^-2)
       / (1 - 1.547 z^-1 + 0.632 z^-2)

y[n] = 0.021 x[n] + 0.042 x[n-1] + 0.021 x[n-2]
       + 1.547 y[n-1] - 0.632 y[n-2]
```

The rounded coefficients give a DC gain of `0.084/0.085`, approximately 0.9882. The portable kernel in [`biquad_filter.h`](src/biquad_filter.h) uses direct form I, retaining two input and two output history values.

## Filter State and Codec Conversion

The receive handler owns a static, zero-initialised state object. Each interrupt advances the filter exactly once for the left-channel sample. History persists between interrupts; a separate state object is required for each independently filtered channel.

The kernel replaces the former ambiguous library call with an explicit recurrence using the same coursework coefficients. Output is clamped to −32768…32767 before integer conversion, while the recursive state retains its floating-point value. Both the full scaffold and isolated ISR use this kernel.

Compile either `BUTTER.C` or the isolated handler when integrating the project; both define `it_dma_receive` and must not be linked together.

## Build requirements

The build uses device-specific Analog Devices support and headers such as `def21060.h`, `21060.h`, and `sport.h`. Match these with the selected ADSP-21060 board and compiler before integrating the scaffold.

Inspect the full scaffold and configure the original hardware before compiling, loading and measuring the audio chain.

## Validation

From this folder, run the portable software tests with a C compiler and Make:

```bash
make test
```

Tests exercise the impulse response, persistent state across actual ISR calls, independent channel states, DC response, decay to zero and PCM clipping. The host tests compile the corrected kernel and the isolated receive handler.

The original ADSP-21060 scaffold requires its device toolchain. Host numerical tests do not replace a board build or measurement of the ISR execution time against the 125 µs sample interval.

## Licence

No project-wide licence has been defined. The instructor scaffold retains its original authorship.

