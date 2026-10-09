# Traitement du signal

Travaux de traitement du signal réalisés pendant le cycle ingénieur Instrumentation (Sup Galilée, 2023–2026) : simulation sous MATLAB et Simulink, puis implantation temps réel sur DSP.

| Dossier | Contenu | Outils |
|---|---|---|
| [`scripts_matlab/`](scripts_matlab/) | 9 scripts : autocorrélation, DSP, filtrage fréquentiel, détection radar par intercorrélation, interpolation et filtres RIF, filtre RC, modulation AM ; compte rendu du TP 1 | MATLAB |
| [`echantillonnage_quantification_simulink/`](echantillonnage_quantification_simulink/) | Échantillonnage, condition de Shannon, repliement, quantification d'un signal sonore | Simulink |
| [`dsp_sharc_filtre_iir/`](dsp_sharc_filtre_iir/) | Filtre IIR d'ordre 2 en temps réel sur DSP ADSP-21060 + codec AD1847 (canevas de l'enseignant + routine de filtrage) ; compte rendu du TP DSP dans `docs/` | C, DSP SHARC |

Chaque dossier contient son propre README détaillé.

## Compétences
FFT, densité spectrale, corrélation, détection en présence de bruit, filtrage RIF et IIR, échantillonnage et quantification, traitement temps réel sous interruption.

## Remarques
- Le compte rendu de `dsp_sharc_filtre_iir/docs/` est un Google Doc : l'exporter en PDF avant `git add`.
- Aucune licence n'a été définie.
