# MATLAB Signal Processing

Spectral analysis, correlation, radar detection, convolution, interpolation, FIR filtering, RC response and amplitude modulation.

## Getting started

Run scripts from `src/` in MATLAB. The recovered `signalbase.mat` input is alongside the scripts; reports are in `docs/`. Original variants and screenshots are under the repository-level `archive/`.

## Laboratory reports

| Document | Content | Related script |
| --- | --- | --- |
| [Numerical signal-processing report](docs/tp1_traitement_numerique_du_signal_compte_rendu.docx) | Existing numerical signal-processing laboratory record | Scripts in `src/` |
| [RC low-pass report](docs/rc_low_pass_report.pdf) | First-order transfer magnitude and a Simulink electrical-circuit model; example cutoff approximately 10.613 Hz | [RC response](src/filtre_rc_passe_bas.m) |
| [Amplitude-modulation report](docs/amplitude_modulation_report.pdf) | MATLAB carrier/message waveforms, modulation indices 0.5, 1 and 1.5, and carrier-suppressed comparisons | [Amplitude modulation](src/modulation_amplitude.m) |

## RC response

For output across the capacitor, `H(jω) = 1 / (1 + jωRC)`, `fc = 1 / (2πRC)` and `|H| = 1 / sqrt(1 + (f/fc)^2)`. The cutoff is the -3 dB point, not a boundary above which output disappears.

The current script uses `R = 1000 ohms` and `C = 100 nF`, giving `fc` approximately **1591.55 Hz**; these parameters differ from the PDF's 10.613 Hz example. The script evaluates an analytical magnitude over a frequency vector. Its `fe` parameter controls that vector and does not simulate a physical ADC. For an actually sampled signal, the sampling rate must satisfy the Nyquist condition for the signal bandwidth; the report's statement that sampling frequency must be below the cutoff is not a valid general sampling rule.

## Amplitude modulation

The current script implements `s(t) = A * (1 + m*cos(2πfb*t)) * cos(2πfp*t)`, with a 10 kHz carrier, a 1 kHz message and `m = 1.5`. Change `m` to 0.5 or 1 to reproduce the other full-carrier cases discussed in the report. For `m > 1`, the signed envelope crosses zero and phase reversals cause overmodulation; its negative values are not negative envelope-detector magnitudes.

The PDF also shows carrier-suppressed comparisons. Those figures are retained in the original report; the current script implements the full-carrier case. The reports preserve the original French text and group authorship.
