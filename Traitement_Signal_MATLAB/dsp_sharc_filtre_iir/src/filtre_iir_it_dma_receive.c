/*
 * Extrait de BUTTER.C (TP DSP, février 2025).
 *
 * Le fichier d'origine part d'un canevas fourni pour le TP (initialisation du DSP
 * ADSP-21060, du port série SPORT0, des DMA chaînées et du codec AD1847) ; ce canevas
 * n'est pas reproduit ici. Seule la routine de traitement du signal est reprise.
 *
 * Les includes, le #define et le corps de it_dma_receive sont recopiés tels quels,
 * sans correction. Seules les deux déclarations "extern" ci-dessous ont été ajoutées
 * pour indiquer d'où viennent rx_buf et tx_buf (déclarés dans le canevas).
 */

#include <signal.h>
#include <filters.h>
#include <math.h>
#define TAPS 3

/* ajouté pour la lecture : buffers déclarés dans le canevas
   rx_buf = {status, voie gauche, voie droite} reçus du codec
   tx_buf = {contrôle, voie gauche, voie droite} envoyés au codec */
extern int rx_buf[3];
extern int tx_buf[3];

/* interruption DMA en réception : appelée quand rx_buf est plein */
void    it_dma_receive ( int sig_num )
{
	int i ;
	static float pm b[TAPS+1]={1 ,-1.547 , 0.632};
	static float pm a[TAPS]={0.021 , 0.042 , 0.021};
	float in_sample = rx_buf[1];
	float output;
	float state[TAPS+1];
	for(i=0 ; i< TAPS+1 ; i++)
	{
		state[i]=0;
		output= iir(in_sample,a,b,state,TAPS);
		tx_buf[1]=output;
	}

}
