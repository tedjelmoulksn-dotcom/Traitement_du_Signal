/********************************************************************************/
/*      PROGRAMME CANEVAS.C
/********************************************************************************/

/* fichier de d‚finition des registres internes et de certains de leurs champs de bits */
#include <def21060.h>
#include <21060.h>
#include <sport.h>              /* les registres et champs de bits des SPORT0 et 1 */
#include <macros.h>

/* d'autres include pour le traitement du signal ....*/
#include <signal.h>
#include <filters.h>
#include <math.h>

/* d‚finition d'un tableau de 16 Words, chacun correspondant … : */
/* -pour l'octet de poids fort :        CLOR    MCE     RREQ    Res     num‚ro d'index du registre */
/*                                 1       1        0     0     de $00 … $FF */
/* CLOR = 1 : remise … jour des bits de surcharge des CAN d'entr‚e dans le Status Word entre */
/* chaque acquisition : permet ‚ventuellement si on le gŠre d'augmenter la pr‚cision des CAN */
/* MCE est mis … 1 pour les 15 premiers Words et … 0 au dernier pour faire une autocalibration du */
/* Codec aprŠs son initialisation */
/* - pour l'octet de poids faible : valeur … ‚crire dans ce registre */
/* Ce tableau regs_1847 est en fait la liste des 16 mots de contr“le qu'il faut envoyer pour initialiser le Codec */

int     regs_1847[16]=  {

	0xC000,         /* registre d'index 0 : CAN sur entr‚e gauche de Line1 , 0 dB d'att‚nuation */
	0xC100,         /* registre d'index 1 : CAN sur entr‚e droite de Line1 , 0 dB d'att‚nuation */
	0xC280,         /* registre d'index 2 : coupe voie gauche de l'entr‚e Aux1, +12 dB si pr‚sente */
	0xC380,         /* registre d'index 3 : coupe voie droite de l'entr‚e Aux1, +12 dB si pr‚sente */
	0xC480,         /* registre d'index 4 : coupe voie gauche de l'entr‚e Aux2, +12 dB si pr‚sente */
	0xC580,         /* registre d'index 5: coupe voie droite de l'entr‚e Aux2, +12 dB si pr‚sente */
	0xC600,         /* registre d'index 6 : CNA valid‚ sur sortie gauche de Line , 0 dB d'att‚nuation */
	0xC700,         /* registre d'index 7 : CNA valid‚ sur sortie droite de Line , 0 dB d'att‚nuation */
	0xC850,         /* registre d'index 8 : format des donn‚es ‚chang‚es avec le DSP */
			/* C/L = 0 : format lin‚aire ( pas de compression ) */
			/* PCM=1 : 16 bits  sign‚s */
			/* S/M=1 : en st‚r‚o */
			/* CSF2:0 = 000 : ‚chantillonnage … 8 kHz ( voir doc AD1847 pour autres fr‚quences ) */
			/* CSL = 0 :choix de XTAL1 … 24,576 MHz */
	0xC909, /* registre d'index 9 : Interface Configuration */
			/* ACAL = 1 : autorise le lancement d'une autocalibration du Codec aprŠs son */
			/* initialisation lorsque MCE repassera … 0 ( … faire …prŠs chaque mise sous tension ) */
			/* PEN = 1 : sortie des donn‚es sur le CNA */
	0xCA00, /* registre d'index 10 : pour la gestion de l'horloge commune de la liaison */
			/* s‚rie en cas de plusieurs Codecs : ici un seul Codec en Bus Master, donc : */
			/* CLKTS = 0 et XCTL1:0 = 00 toujours */
	0xCB00, /* registre d'index 11 : pas de registre : usage futur : on envoie 00 dans rien !! */
	0xCC40, /* registre d'index 12 : pour la gestion du protocole TDM */
			/* FRS = 0 : 32 slots par trame */
			/* TSSEL = 1 : systŠme … 2 fils ( voir pages 30 … 31 de ce document ) */
			/* rappelons que la clock de la liaison DSP-Codec est … 12,288 MHz */
	0xCD00, /* registre d'index 13 : pour le mixage num‚rique entre sortie CAN et entr‚e CNA */
			/* DME = 0 : pas de mixage ici */
			/* att‚nuation de -1,5 dB si ce mixage ‚tait autoris‚ */
	0xCE00, /* registre d'index 14 : pas de registre : usage futur : on envoie 00 dans rien !! */
	0x8F00          /* registre d'index 15 : pas de registre : usage futur : on envoie 00 dans rien !! */
			/* mais force le retour de MCE … 0, donc lance l'autocalibration !! */
				};

/* buffer de r‚ception des donn‚es venant du Codec : taille de 3 Words : status, voie gauche, voie droite */
int     rx_buf[3];
/* buffer de transmission des donn‚es vers le Codec : taille de 3 Words : contr“le, voie gauche et voie droite */
/* ici initialis‚s pour configurer le TDM */
int     tx_buf[3]={0xCC40,      0,      0};

/* d‚finition d'une structure de TCB pour le chaŒnage des DMA de la liaison DSP-Codec */
/* voir pages 22 et 25-26 de ce document */
/* un TCB complet comprend en fait 9 ‚l‚ments et non 4 comme dans la pr‚sentation simplifi‚e page 26 */
typedef struct  {
	unsigned        ei;     /* non utilis‚ ici : multiprocessing */
	unsigned        em;     /* non utilis‚ ici : multiprocessing */
	unsigned        ec;     /* non utilis‚ ici : multiprocessing */
	unsigned        gp1;    /* registre d'usage g‚n‚ral nø1 */
	unsigned        gp2;    /* registre d'usage g‚n‚ral nø2 */
	unsigned**      cp;     /* pointe sur le TCB suivant dans la chaŒne */
	unsigned        c;      /* taille du bloc … transf‚rer … chaque DMA */
	int             im;     /* incr‚ment pour calculer l'adresse du trnsfert suivant dans le DMA en cours */
	unsigned*       ii;     /* pointeur sur le buffer : adresse de base du buffer */
		}       tcb;
/* le premier TCB de la chaŒne de r‚ception initialis‚ avec 3 mots par DMA … des adresses succ‚sives ( c = 3 et im = 1 ) */
tcb     rx_tcb = {0,    0,      0,      0,      0,      0,      3,      1,      0};
/* le premier TCB de la chaŒne d'‚mission initialis‚ avec 3 mots par DMA … des adresses succ‚sives ( c = 3 et im = 1 ) */
tcb     tx_tcb = {0,    0,      0,      0,      0,      0,      3,      1,      0};
int*    tx_ptr;
int     tx_compteur;

/********************************************************************************/
/*      interruption timer ‚x‚cut‚e ici 4 fois par seconde
/********************************************************************************/
void    it_timer        ( int sig_num )
{
/* inverse l'‚tat de la Led cƒbl‚e sur la sortie FLAG2 */
	set_flag ( SET_FLAG2, TGL_FLAG );       /* extension du C : */
						/* mettre SET_FLAG pour l'‚teindre et CLR_FLAG pour l'allumer */
}
/********************************************************************************/
/*      interruption DMA en transmission sur tx_buf vide
/********************************************************************************/
void    it_dma_transmit ( int sig_num )
{
/* v‚rifie si les 16 donn‚es d'initialisation ont ‚t‚ envoy‚es au Codec */
	if ( tx_compteur )
	{
	/* mettre le word dans tx_buf[0], pointer sur le suivant et d‚cr‚menter le comptage */
		tx_buf[0] = *tx_ptr++;  
		tx_compteur--;
	/* n'oubliez pas que ( ici en st‚r‚o ) tx_buf[1] ( voie gauche ) et tx_buf[2] ( voie droite ) peuvent contenir */
	/* des valeurs num‚riques que l'on peut envoyer */
	/* vers les CNA du Codec, tx_buf[0] contenant quant … lui le mot de contr“le ( revoir le protocole TDM ) */
	}
}
/********************************************************************************/
/*      interruption DMA en reception sur rx_buf plein 
/********************************************************************************/
void    it_dma_receive ( int sig_num )
{
/* on mettra ici le soft de traitement du signal qui re‡oit les ‚chantillons ( en st‚r‚o ) dans rx_buf[1] ( voie gauche ) et */
/* rx_buf[2] ( voie droite ) et qui peut g‚n‚rer une sortie num‚rique … envoyer dans tx_buf[1] ou tx_buf[2] */
/* ici on peut par exemple simplement renvoyer la valeur lue sur la voie Line1 gauche vers la sortie Line gauche */
	
}

/********************************************************************************/
/*      initialisation du DSP
/*      et exemples de routine de commande du timer
/*       et d'insertion de code assembleur dans du C : asm ( " mn‚monique assembleur " )
/********************************************************************************/
void    init_dsp        ( void )
{
	timer_off ( );                          /* extension du C ANSI inhibant le timer */
	timer_set( 10000000,    10000000 );     /* initialise TPERIOD et TCOUNT du timer */
						/* g‚n‚ration d'une IT lorsque TCOUNT=0 */
						/* ici … 40 MHz : entre chaque IT : 107/40.106 = 0,25 s */
						/* donc fr‚quence des IT du timer = 4 Hz */
	asm( " #include <def21060.h> " );
	asm ( " bit set mode1 NESTM; " );               /* imbrication d'interruption autoris‚e : ici timer, DMA */
						/* par mise … 1 du bit 11 NESTM du registre interne mode1 */
						/*  exemple d'insertion de code assembleur dans du C */

	tx_ptr          = regs_1847;            /* pointeur vers donn‚es d'initialisation du Codec */
	tx_compteur     = 0;                    /* init du comptage de mots … envoyer */

	interrupt ( SIG_TMZ,    it_timer );     /* installation de l'interruption timer sur TCOUNT = 0 */
						/* plac‚e en bas niveau de priorit‚ */
						/* pour le haut niveau utiliser SIG_TMZ0 au lieu de SIG_TMZ */
						/* toutes les 0,25 s, la routine it_timer sera ‚x‚cut‚e */
}


/********************************************************************************/
/*      initialisation et configuration de SPORT0 du DSP
/*      autorisation et installation des vecteurs de DMA
/*      initialisation des TCB et lancement des DMA en ‚mission et en r‚ception
/********************************************************************************/
void    init_sport0 ( void )
{

/* affectation et configuration des slots */
	sport0_iop.mtcs =       0x00070007;     /* transmission sur slots 0,1,2,16,17,18 */
	sport0_iop.mrcs =       0x00070007;     /* r‚ception sur slots 0,1,2,16,17,18 */
	sport0_iop.mtccs        =       0x00000000;     /* pas de compression en ‚mission sur tous les slots */
	sport0_iop.mrccs        =       0x00000000;     /* pas de compression en r‚ception sur tous les slots */

/* ‚criture dans le STCTL0 : le Transmit Control Register */
/* les champs de bits sont d‚finis dans sport.h */
	sport0_iop.txc.mdf      = 1;    /* d‚lai entre chaque trame du TDM en multi-channel */
	sport0_iop.txc.schen    = 1;    /* autorisation du chaŒnage de DMA sur ‚mission */
	sport0_iop.txc.sden     = 1;    /* autorisation de la DMA sur ‚mission */
	sport0_iop.txc.lafs     = 0;    /* … 0 en multi-channel */
	sport0_iop.txc.ltfs     = 0;    /* synchro trame active au niveau haut */
	sport0_iop.txc.ditfs    = 0;    /* synchro trame … chaque chargement du transmit register */
	sport0_iop.txc.itfs     = 0;    /* … 0 en multi-channel */
	sport0_iop.txc.tfsr     = 0;    /* … 0 en multi-channel */
	sport0_iop.txc.ckre     = 0;    /* ‚chantillonnage des bits sur front descendant de la clock */
	sport0_iop.txc.gclk     = 0;    /* clock g‚n‚r‚e en transmission seulement */
	sport0_iop.txc.iclk     = 0;    /* clock g‚n‚r‚e en externe utilis‚e */
	sport0_iop.txc.pack     = 0;    /* transmission de 32 bits en 2 fois 16 bits */
	sport0_iop.txc.slen     = 15;   /* longueur d'un mot ( ici 16 bits ) -1 */
	sport0_iop.txc.sendn    = 0;    /* format Endian ( = 0 : MSB en premier, = 1 : LSB en premier */
	sport0_iop.txc.dtype    = 1;    /* justification … droite avec extension de signe aux MSB */
	sport0_iop.txc.spen     = 0;    /* … 0 en multi-channel */

/* ‚criture dans le SRCTL0 : le Receive Control Register */
/* les champs de bits sont d‚finis dans sport.h */
	sport0_iop.rxc.nch      = 31;   /* en TDM, nombre de slots -1 */
	sport0_iop.rxc.mce      = 1;    /* autorisation du TDM ou multi-channel */
	sport0_iop.rxc.spl      = 0;    /* … 0 en multi-channel */
	sport0_iop.rxc.d2dma    = 0;    /* non validation de la DMA en D2 : … 0 en multi-channel */
	sport0_iop.rxc.schen    = 1;    /* autorisation du chaŒnage de DMA en r‚ception */
	sport0_iop.rxc.sden     = 1;    /* autorisation de la DMA en r‚ception */
	sport0_iop.rxc.lafs     = 0;    /* … 0 en multi-channel */
	sport0_iop.rxc.ltfs     = 0;    /* synchro trame active au niveau haut */
	sport0_iop.rxc.irfs     = 0;    /* synchro trame g‚n‚r‚e en externe */
	sport0_iop.rxc.rfsr     = 0;    /* … 0 en multi-channel */
	sport0_iop.rxc.ckre     = 0;    /* ‚chantillonnage des bits sur front descendant de la clock */
	sport0_iop.rxc.gclk     = 0;    /* clock g‚n‚r‚e en transmission seulement */
	sport0_iop.rxc.iclk     = 0;    /* clock g‚n‚r‚e en externe utilis‚e */
	sport0_iop.rxc.pack     = 0;    /* transmission de 32 bits en 2 fois 16 bits */
	sport0_iop.rxc.slen     = 15;   /* longueur d'un mot ( ici 16 bits ) -1 */
	sport0_iop.rxc.sendn    = 0;    /* format Endian ( = 0 : MSB en premier, = 1 : LSB en premier */
	sport0_iop.rxc.dtype    = 1;    /* justification … droite avec extension de signe aux MSB */
	sport0_iop.rxc.spen     = 0;    /* … 0 en multi-channel */

/* autorisation des interruptions DMA sur SPORT0 en r‚ception et en ‚mission */
	interrupt ( SIG_SPR0I,  it_dma_receive );       /* installation de l'interruption DMA en r‚ception */
							/* cette it sera ‚x‚cut‚e chaque fois que le buffer de */
							/* r‚ception de 3 mots rx_buf sera plein */
	interrupt ( SIG_SPT0I,  it_dma_transmit );      /* installation de l'interruption DMA en ‚mission */
							/* cette it sera ‚x‚cut‚e chaque fois que le buffer de */
							/* transmission de 3 mots tx_buf sera vide */
/* initialisation du TCB de transmission pour le chaŒnage des DMA */

	tx_tcb.ii =  tx_buf;            /* pointe sur le buffer de transmission */
	tx_tcb.cp = &tx_tcb.ii;         /* pointe sur lui-mˆme donc paramŠtrage identique pour toutes les DMA */
					/* qui vont s'enchaŒner */
	*(int*)CP2 = ( (int)&tx_tcb.ii | 0x30000 );     /* initialise le registre CP2 du DSP */
					/* ( canal 2 de DMA en transmission ) */
					/* force le  bit 17 ( bit PCI autorisant  l'IT DMA ) */
					/* et le bit 16 ( MSB de l'adresse du premier TCB ) … 1 */
					/* initialise le premier paramŠtrage et lance la DMA en transmission */
					/* les 3 words de tx_buf vont ˆtre ‚mis puis une IT DMA ‚mission aura lieu */
					/* entraŒnant l'‚x‚cution de la routine it_dma_transmit et un param‚trage */
					/* automatique de la prochaŒne DMA avec les mˆmes tx_tcb et tx_buf */
					/* ( ce n'est pas … l'utilisateur de lancer la prochaine DMA ) */

/* initialisation du TCB de r‚ception pour le chaŒnage des DMA */

	rx_tcb.ii =  rx_buf;            /* pointe sur le buffer de r‚ception */
	rx_tcb.cp = &rx_tcb.ii;         /* pointe sur lui-mˆme donc paramŠtrage identique pour toutes les DMA */
					/* qui vont s'enchaŒner */
	*(int*)CP0 = ( (int)&rx_tcb.ii | 0x30000 );     /* initialise le registre CP0 du DSP */
					/* ( canal 0 de DMA en r‚ception ) */
					/* force le  bit 17 ( bit PCI autorisant l'IT DMA ) */
					/* et le bit 16 ( MSB de l'adresse du premier TCB ) … 1 */
					/* initialise le premier paramŠtrage et lance la DMA en r‚ception */
					/* les 3 premier words re‡us seront stock‚s dans rx_buf */
					/* puis une IT DMA r‚ception aura lieu */
					/* entraŒnant l'‚x‚cution de la routine it_dma_receive et un param‚trage */
					/* automatique de la prochaŒne DMA avec les mˆmes rx_tcb et rx_buf */
					/* ( ce n'est pas … l'utilisateur de lancer la prochaine DMA ) */

}

/********************************************************************************/
/*      envoi des initialisations vers le Codec 
/********************************************************************************/
void    init_codec ( void )
{
	tx_ptr          = regs_1847;            /* pointeur vers donn‚es d'initialisation du Codec */
	tx_compteur     = 16;                   /* init du comptage de mots … envoyer */

/* puis on attend l'‚mission complŠte des 16 mots sous IT DMA par la routine it_dma_transmit */
	while ( tx_compteur )
		idle ();                /* attente jusqu'… tx_compteur = 0 */

/* on a vu qu'aprŠs le dernier mot de contr“le envoy‚ par le DSP, le Codec se met en autocalibration */
/* on vient lire le Status Word ‚mis par le Codec et re‡u sous IT DMA r‚ception dans rx_buf[ 0 ] */
/* le bit 1 ( bit ACI ) du Status Word est … 1 pendant l'autocalibration ( 384 p‚riodes d'‚chantillonnage ) et … 0 sinon */
/* il faut d'abord attendre que le bit ACI soit … 1 : d‚marrage de l'autocalibration */
/* sinon on risque de trouver 0 tout de suite et de penser que l'autocalibration est finie alors qu'elle n'a pas commenc‚ */
/* on fait pour cela une scrutation de l'‚tat haut de ACI */
	while ( !( rx_buf[ 0 ] & 0x0002 ))
		idle ( );               /* attente jusqu'… bit ACI = 1 : d‚but autocalibration */
/* puis on attend la fin de l'autocalibration en scrutant le passage … 0 du bit ACI */
	while ( rx_buf[ 0 ] & 0x0002 )
		idle ( );               /* attente jusqu'… bit ACI = 0 : fin d' autocalibration */
}



/********************************************************************************/
/*      Le main
/********************************************************************************/
void    main    ( void )
{
	int i ;
/* initialisation du DSP */
	init_dsp ( );

/* reset du Codec : mise … 0 de la sortie FLAG0 reli‚ … la broche /Reset du Codec */
	set_flag ( SET_FLAG0,CLR_FLAG);
	for ( i=0 ; i<0xFFFF ; i++ );           /* et attendre suffisamment longtemps */
	set_flag ( SET_FLAG0,SET_FLAG); /* avant de remonter le reset */

/* configuration du SPORT0 du DSP */
	init_sport0 ( );

/* envoi des commandes d'initialisation vers le Codec : ces commandes sont envoy‚es sous DMA */

	init_codec ( );

/* valide le timer et ses interruptions p‚riodiques */
	timer_on ( );

/* attente infinie, d‚rang‚e par des IT du timer et des DMA */
	while ( 1 )
		idle;

}

/********************************************************************************/
