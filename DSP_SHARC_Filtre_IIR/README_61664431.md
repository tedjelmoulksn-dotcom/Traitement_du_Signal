# Filtre IIR temps réel sur DSP SHARC (ADSP-21060)

## Vue d'ensemble
TP de DSP (cycle ingénieur, 2e année, 2024–2025) : implantation d'un filtre numérique récursif (IIR) d'ordre 2 dans la routine d'interruption de réception d'un DSP Analog Devices SHARC ADSP-21060 relié à un codec audio AD1847.

> **Paternité du code.** Le programme `src/BUTTER.C` est construit sur le **canevas `CANEVAS.C` fourni par l'enseignant du TP** : initialisation du DSP et du timer, configuration du port série SPORT0 en TDM, DMA chaînées, initialisation et autocalibration du codec, `main()`. Ce canevas et ses commentaires sont l'œuvre de l'enseignant.
> **Ma contribution** se limite à la routine de traitement du signal `it_dma_receive` (coefficients du filtre, appel à `iir()`, écriture dans `tx_buf[1]`) et aux `#include`/`#define` associés. Elle est isolée dans `src/filtre_iir_it_dma_receive.c`.

## Objectifs
- Comprendre la chaîne d'acquisition temps réel codec → SPORT0 → DMA → interruption → DSP → codec.
- Implanter un filtre IIR avec la fonction `iir()` de la bibliothèque de traitement du signal du compilateur.

## Architecture
```mermaid
flowchart LR
 IN[Entrée audio Line1] --> ADC[CAN du codec AD1847]
 ADC -- SPORT0 / DMA --> RX[rx_buf]
 RX --> IT[it_dma_receive<br/>filtre IIR]
 IT --> TX[tx_buf]
 TX -- SPORT0 / DMA --> DAC[CNA du codec]
 DAC --> OUT[Sortie audio]
```

## Matériel
- DSP Analog Devices ADSP-21060 (SHARC), horloge 40 MHz d'après les commentaires du canevas ; référence exacte de la carte : À documenter.
- Codec AD1847, configuré par le canevas en 16 bits signés stéréo à 8 kHz.

## Logiciel
Chaîne de compilation C Analog Devices pour ADSP-21060 (`def21060.h`, `21060.h`, `sport.h`, `filters.h`). Version : À documenter.

## Implémentation
| Fichier | Contenu | Auteur |
|---|---|---|
| `src/BUTTER.C` | Programme complet tel qu'utilisé au TP (canevas + routine de filtrage) | Canevas : enseignant ; `it_dma_receive` : moi |
| `src/filtre_iir_it_dma_receive.c` | Extrait de la seule routine de filtrage, recopiée sans correction | Moi |

À chaque interruption DMA de réception, l'échantillon de la voie gauche (`rx_buf[1]`) est filtré par `iir()` puis renvoyé sur la voie gauche (`tx_buf[1]`). Un timer fait clignoter une LED (sortie FLAG2) 4 fois par seconde (canevas).

Coefficients présents dans le code :
- `a = {0.021, 0.042, 0.021}`
- `b = {1, -1.547, 0.632}`

Avec ces valeurs, `(0.021 + 0.042 + 0.021) / (1 − 1.547 + 0.632) ≈ 0,99` : le filtre a un gain statique proche de 1 et la forme d'un passe-bas d'ordre 2 (calcul fait à partir des coefficients ; méthode de calcul des coefficients et fréquence de coupure : À documenter).

## Principes d'ingénierie
- Traitement échantillon par échantillon sous interruption.
- Filtre récursif d'ordre 2 et état interne du filtre.
- Communication DSP–codec en TDM avec DMA chaînées.

## Résultats
Aucune mesure conservée : À documenter (réponse fréquentielle mesurée, captures d'oscilloscope).

## Difficultés / limites
- Dans `it_dma_receive`, le tableau `state[]` est déclaré localement et remis à zéro dans la boucle avant chaque appel à `iir()` : l'état du filtre n'est donc pas conservé d'un échantillon à l'autre. Pour un vrai filtrage récursif, `state` devrait être `static` et initialisé une seule fois. Le code est laissé tel quel.
- Plusieurs versions intermédiaires existent (`BUTTER_2`, `try1`, `try2`, `try3`, `PRIME`) ; seule `BUTTER.C` est reprise.
- L'énoncé du TP n'est pas publié.

## Structure
```
DSP_SHARC_Filtre_IIR/
├── README.md
├── .gitignore
└── src/
    ├── BUTTER.C                      (canevas de l'enseignant + ma routine)
    └── filtre_iir_it_dma_receive.c   (ma routine seule)
```

## Exécution
Nécessite la carte DSP et la chaîne Analog Devices : compiler `src/BUTTER.C`, charger le programme puis injecter un signal sur l'entrée Line1 et observer la sortie Line.

## Médias
À documenter.

## Compétences
DSP temps réel, filtrage IIR, interruptions et DMA, programmation C embarquée sur SHARC.

## Licence
Aucune licence n'a été définie. Le canevas reste la propriété de son auteur (enseignant du TP).
