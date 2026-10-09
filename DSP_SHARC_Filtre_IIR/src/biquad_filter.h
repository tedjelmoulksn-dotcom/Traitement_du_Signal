#ifndef BIQUAD_FILTER_H
#define BIQUAD_FILTER_H

/* Coursework coefficients, explicit direct-form I recurrence:
 * H(z) = (0.021 + 0.042 z^-1 + 0.021 z^-2)
 *        / (1 - 1.547 z^-1 + 0.632 z^-2).
 * Keep one state object per audio channel; zero it once before processing.
 */
typedef struct {
    float x1, x2;
    float y1, y2;
} BiquadState;

static float biquad_process(BiquadState *state, float input)
{
    float output = 0.021f * input + 0.042f * state->x1
                 + 0.021f * state->x2 + 1.547f * state->y1
                 - 0.632f * state->y2;
    state->x2 = state->x1;
    state->x1 = input;
    state->y2 = state->y1;
    state->y1 = output;
    return output;
}

/* Clamp before converting to the signed 16-bit codec range. */
static int biquad_pcm16(float output)
{
    if (output > 32767.0f) return 32767;
    if (output < -32768.0f) return -32768;
    return (int)output;
}

#endif
