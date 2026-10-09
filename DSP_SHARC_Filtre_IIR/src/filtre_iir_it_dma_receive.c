/* Corrected DMA receive handler from BUTTER.C.
 * The instructor scaffold owns SPORT0, DMA, codec and buffer initialisation.
 * Compile this excerpt OR the full scaffold, not both (same ISR symbol).
 */
#include "biquad_filter.h"

extern int rx_buf[3];
extern int tx_buf[3];

void it_dma_receive(int sig_num)
{
    static BiquadState left_state = {0, 0, 0, 0};
    float output;
    (void)sig_num;
    output = biquad_process(&left_state, (float)rx_buf[1]);
    tx_buf[1] = biquad_pcm16(output);
}
