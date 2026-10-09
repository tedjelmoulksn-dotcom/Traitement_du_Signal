#include <assert.h>
#include <math.h>
#include <stdio.h>
#include "../src/biquad_filter.h"

int rx_buf[3];
int tx_buf[3];
void it_dma_receive(int sig_num);

int main(void)
{
    BiquadState impulse = {0, 0, 0, 0};
    BiquadState step = {0, 0, 0, 0};
    BiquadState silent_channel = {0, 0, 0, 0};
    float response;
    int i;
    assert(fabsf(biquad_process(&impulse, 1.0f) - 0.021f) < 1e-6f);
    assert(fabsf(biquad_process(&impulse, 0.0f) - 0.074487f) < 1e-6f);
    /* A second channel must not inherit the first channel's history. */
    assert(biquad_process(&silent_channel, 0.0f) == 0.0f);
    for (i = 0; i < 1000; ++i) {
        response = biquad_process(&step, 1.0f);
        assert(isfinite(response));
    }
    assert(fabsf(response - (0.084f / 0.085f)) < 2e-5f);
    for (i = 0; i < 1000; ++i) response = biquad_process(&step, 0.0f);
    assert(fabsf(response) < 1e-6f);
    assert(biquad_pcm16(40000.0f) == 32767);
    assert(biquad_pcm16(-40000.0f) == -32768);
    assert(biquad_pcm16(12.75f) == 12);
    rx_buf[1] = 1000;
    it_dma_receive(0);
    assert(tx_buf[1] == 21);
    rx_buf[1] = 0;
    it_dma_receive(0);
    assert(tx_buf[1] == 74);
    puts("Biquad impulse, DMA history, DC response and PCM clipping: PASS");
    return 0;
}
