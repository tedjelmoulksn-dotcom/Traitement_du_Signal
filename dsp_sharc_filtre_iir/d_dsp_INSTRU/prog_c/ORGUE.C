/********************************************************************************/
/*      PROGRAMME ORGUE.C version filtr‚e                                                     */
/*      mise a  jour  de tx   par it_transmission sous DMA                             */
/********************************************************************************/

/* fichier de définition des registres internes et de certains de leurs champs de bits */
#include <def21060.h>
#include <21060.h>
#include <sport.h>
#include <macros.h>
#include <stdio.h> 
#include <conio.h> 


/* d'autres icude pour le tritement du signal ....*/
#include <signal.h>
#include <filters.h>
#include <math.h>

const float pi=3.14159265359;


/* définition d'un tableau de 16 Words, chacun correspondant : */
/* - octet de poids fort :      CLOR    MCE     RREQ    Res     numéro d'index du registre */
/*                         1       1        0     0     de $00 à $FF */
/* CLOR = 1 : remise à jour des bits de surcharge des CAN d'entrée dans le Status Word entre */
/* chaque acquisition : permet d'augmenter la précision des CAN */
/* MCE est mis à 1 pour les 15 premiersWords et à 0 au dernier pour faire une autocalibration du */
/* Codec après son initialisation */
/* - octet de poids faible : valeur à écrire dans ce registre */
/* c'est la liste des 16 mots de contrôle qu'il faut envoyer pour initialiser le Codec */

int     regs_1847[16]=  {

	0xC000, /* registre d'index 0 : CAN sur entrée gauche de Line1 , 0 dB d'atténuation */
	0xC100, /* registre d'index 1 : CAN sur entrée droite de Line1 , 0 dB d'atténuation */
	0xC280, /* registre d'index 2 : coupe voie gauche de l'entrée Aux1, +12 dB si présente */
	0xC380, /* registre d'index 3 : coupe voie droite de l'entrée Aux1, +12 dB si présente */
	0xC480, /* registre d'index 4 : coupe voie gauche de l'entrée Aux2, +12 dB si présente */
	0xC580, /* registre d'index 5: coupe voie droite de l'entrée Aux2, +12 dB si présente */
	0xC600, /* registre d'index 6 : CNA validé sur sortie gauche de Line , 0 dB d'atténuation */
	0xC700, /* registre d'index 7 : CNA validé sur sortie droite de Line , 0 dB d'atténuation */
	0xC85c, /* registre d'index 8 : format des données échangées avec le DSP */
			/* C/L = 0 : format linéaire ( pas de compression */
			/* PCM=1 : 16 bits  signé */
			/* S/M=1 : en stéréo */
			/* CSF2:0 =0 : échantillonnage à 32 kHz ( voir doc AD1847 pour autres fréq. ) */
			/* CSL = 0 :choix de XTAL1 à 24,576 MHz */
	0xC909, /* registre d'index 9 : Interface Configuration */
			/* ACAL = 1 : autorise le lancement d'une autocalibration du Codec après son */
			/* initialisation lorsque MCE repassera à 0 ( à faire àprès chaque MST */
			/* PEN = 1 : sortie des données sur le CNA */
	0xCA00, /* registre d'index 10 : pour la gestion de l'horloge commune de la liaison */
			/* série en cas de plusieurs Codec : ici un seul Codec en Bius Master, donc : */
			/* CLKTS = 0 et XCTL1:0 = 00 toujours */
	0xCB00, /* registre d'index 11 : pas de registre : usage futur : on envoie 00 dans rien !! */
	0xCC40, /* registre d'index 12 : pour la gestion du protocole TDM */
			/* FRS = 0 : 32 slots par trames */
			/* TSSEL = 1 : système à 2 fils ( voir pages 30 à 31 de ce document ) */
			/* rappelons que la clock de la liaison DSP-Codec est à 12,288 MHz */
	0xCD00, /* registre d'index 13 : pour le Mixage numérique entre sortie CAN et entrée CNA */
			/* DME = 0 : pas de mixage ici */
			/* atténuation de -1,5 dB si mixage était autorisé */
	0xCE00, /* registre d'index 14 : pas de registre : usage futur : on envoie 00 dans rien !! */
	0x8F00          /* registre d'index 15 : pas de registre : usage futur : on envoie 00 dans rien !! */
			/* mais force le retour de MCE à 0, donc lance l'autocalibration !! */
				};

/* buffer de réception des données venant du Codec : taille de 3 Words */
int     rx_buf[3];
/* buffer de transmission des données vers le Codec : taille de 3 Words initialisés pour configurer le TDM */
int     tx_buf[3]={0xCC40,      0,      0};

/* définition d'une structure de TCB pour le chaînage des DMA de la liaison DSP-Codec */
/* voir pages 22 et 25-26 de ce document */
/* un TCB complet comprend en fait 9 éléments et non 4 comme dans la présentation simplifiée page 26 */
typedef struct  {
	unsigned        ei;     /* non utilisé ici : multiprocessing */
	unsigned        em;     /* non utilisé ici : multiprocessing */
	unsigned        ec;     /* non utilisé ici : multiprocessing */
	unsigned        gp1;    /* registre d'usage général n°1 */
	unsigned        gp2;    /* registre d'usage général n°2 */
	unsigned**      cp;     /* pointe sur le TCB suivant dans la chaîne */
	unsigned        c;      /* taille du bloc à transférer à chaque DMA */
	int             im;     /* incrément pour calculer l'adresse du trnsfert suivant dans le DMA en cours */
	unsigned*       ii;     /* pointeur sur le buffer : adresse de base du buffer */
		}       tcb;

/* le premier TCB de la chaîne de réception initialisé avec 3 mots par DMA à des adresses succésives ( c = 3 et im = 1 */
tcb     rx_tcb = {0,    0,      0,      0,      0,      0,      3,      1,      0};
/* le premier TCB de la chaîne d'émission initialisé avec 3 mots par DMA à des adresses succésives ( c = 3 et im = 1 */
tcb     tx_tcb = {0,    0,      0,      0,      0,      0,      3,      1,      0};

int*    tx_ptr;
int     tx_compteur;

#define long_buff 1000 /* longueur du buffer */

#define sol 245  /* les notes en fr‚quences */
#define la  218
#define si  194
#define ut  183
#define re  163    

int echant [long_buff]; /* buffer d'‚chantillons */


CIRCULAR_BUFFER(int,2,note);
int     joue_note,max,fill_note;
/**********************************************************/
void new_note()
{ 
    int i,j;
    static int k=0;
    float ftmp;
    fill_note=1;
 LENGTH(note) = max;
    
   
	for (j = 0; j < max ; j++)
	{
	    ftmp = 20000.0 * sin( (pi * j) / 200.0 ); 
	    i = ftmp;
	    CIRC_WRITE(note,1,i,dm);            /* fill note buffer      */
	}   
     fill_note=0;      
}
/**********************************************************/
/*                                                        */
/*                                                        */
/*                                                        */
/**********************************************************/
void pas_de_note()
{ 
	int j;
	fill_note=1;      

    
    LENGTH(note) =long_buff;
   
	for (j = 0; j < long_buff ; j++)
	{
	    CIRC_WRITE(note,1,0,dm);            /* fill note buffer      */
	} 
	fill_note=0;     
}


/********************************************************************************/
/*      initerruption timer éxécutée ici 4 fois par seconde                     */
/********************************************************************************/

void    it_timer ( int sig_num )
{
	if (joue_note)  {new_note();joue_note=0;} 
	else 
	{
	
	pas_de_note();
	}                                       /* mettre SET_FLG pour l'éteindre et CLR_FLG pour l'allumer */
}

/********************************************************************************/
/*      initerruption DMA en transmission sur tx_buf vide                       */
/********************************************************************************/

void    it_dma_transmit ( int sig_num )
{        static int i;

		
/* vérifie si les 16 données d'initialisation ont été envoyées au Codec */
	if ( tx_compteur )
	{
	/* mettre le word dans tx_buf[0], pointer sur le suivant et décrémenter le comptage */
		tx_buf[0] = *tx_ptr++;  
		tx_compteur--;

	/* n'oubliez pas que tx_buf[1] et tx_buf[2] peuvent contenir des valeurs numériques que l'on peut envoyer */
	/* vers les CNA du Codec, tx_buf[0] contenant quant à lui le mot de contrôle ( revoir le protocole TDM ) */
	}
     else 
	   if (fill_note);
		else
     { int oldest, oldest_plus_1, new_val;

	CIRC_READ(note,1,oldest,dm);          /* read oldest note */
	CIRC_READ(note,-1,oldest_plus_1,dm);  /* read nest note */
	new_val = (oldest + oldest_plus_1) / 2;
	/*CIRC_MODIFY(note,1);*/
	CIRC_WRITE(note,1,new_val,dm);      /* update buffer */
	tx_buf[1] = new_val ;
	
	} 
     
} 

/********************************************************************************/
/*      initerruption DMA en reception sur rx_buf plein                         */
/********************************************************************************/

void    it_dma_receive ( int sig_num )
{    
/* on mettra ici le soft de traitement du signal qui reçoit les échantillons dans rx_buf[1] et rx_buf[2] */
/* et qui peut générer une sortie numérique à envoyer dans tx_buf[1] ou tx_buf[2] */
/* ici on peut par exemple simplement renvoyer la valeur lue sur la voie Line1 gauche vers la sortie Line gauche */
	
}

/********************************************************************************/
/*      initialisation du DSP                                                   */
/* et exemples de routine de commande du timer                                  */
/* et d'insertion de code assembleur dans du C : asm ( " mnémonique assembleur "*/
/********************************************************************************/

void    init_dsp        ( void )
{
	timer_off ( ); /* extension du C ANSI inhibant le timer */
			      
      /*        timer_set(20000000,20000000); */
    
	/* initialise TPERIOD et TCOUNT du timer */
	asm ( "#include <def21060.h>");
	asm ( " bit set mode1 NESTM; " );        /* imbrication d'interruption autorisée : ici timer, DMA */
						/* pae mise à 1 du bit 11 NESTM du registre interne mode1 */

	tx_ptr          = regs_1847;            /* pointeur vers données d'initialisation du Codec */
	tx_compteur     = 0;                    /* init du comptage de mots à envoyer */
						

	interrupt ( SIG_TMZ,    it_timer );     /* installation de l'interruption timer sur TCOUNT = 0 */
						/* placée en bas niveau de priorité */
						/* pour le haut niveau utiliser SIG_TMZ0 au lieu de SIG_TMZ */
						/* toutes les 0,25 s, la routine it_timer sera éxécutée */
}

/********************************************************************************/
/*      initialisation et configuration de SPORT0 du DSP                        */
/*      autorisation et installation des vecteurs de DMA                        */
/*      initialisation des TCB et lancement de la DMA                           */
/********************************************************************************/

void    init_sport0 ( void )
{

/* affectation et configuration des slots */
	sport0_iop.mtcs =       0x00070007;     /* transmission sur slots 0,1,2,16,17,18 */
	sport0_iop.mrcs =       0x00070007;     /* réception sur slots 0,1,2,16,17,18 */
	sport0_iop.mtccs=       0x00000000;     /* pas de compression en émission sur tous les slots */
	sport0_iop.mrccs=       0x00000000;     /* pas de compression en réceptionsur tous les slots */

/* écriture dans le STCTL0 : le Transmit Control Register */
/* les champs de bits sont définis dans sport.h */
	sport0_iop.txc.mdf      = 1;    /* délai entre chaque trame du TDM en multi-channel */
	sport0_iop.txc.schen    = 1;    /* autorisation du chaînage de DMA sur émission */
	sport0_iop.txc.sden     = 1;    /* autorisation de la DMA sur émission */
	sport0_iop.txc.lafs     = 0;    /* à 0 en multi-channel */
	sport0_iop.txc.ltfs     = 0;    /* synchro trame active au niveau haut */
	sport0_iop.txc.ditfs    = 0;    /* synchro trame à chaque chargement du transmit register */
	sport0_iop.txc.itfs     = 0;    /* à 0 en multi-channel */
	sport0_iop.txc.tfsr     = 0;    /* à 0 en multi-channel */
	sport0_iop.txc.ckre     = 0;    /* échantillonnage des bits sur front descendant de la clock */
	sport0_iop.txc.gclk     = 0;    /* clock générée en transmission seulement */
	sport0_iop.txc.iclk     = 0;    /* clock générée en externe utilisée */
	sport0_iop.txc.pack     = 0;    /* transmission de 32 bits en 2 fois 16 bits */
	sport0_iop.txc.slen     = 15;   /* longueur d'un mot ( ici 16 bits ) -1 */
	sport0_iop.txc.sendn    = 0;    /* format Endian ( = 0 : MSB en premier, = 1 : LSB en premier */
	sport0_iop.txc.dtype    = 1;    /* justification à droite avec extension de signe aux MSB */
	sport0_iop.txc.spen     = 0;    /* à 0 en multi-channel */

/* écriture dans le SRCTL0 : le Receive Control Register */
/* les champs de bits sont définis dans sport.h */
	sport0_iop.rxc.nch      = 31;   /* en TDM, nombre de slots -1 */
	sport0_iop.rxc.mce      = 1;    /* autorisation du TDM ou multi-channel */
	sport0_iop.rxc.spl      = 0;    /* à 0 en multi-channel */
	sport0_iop.rxc.d2dma    = 0;    /* non validation de la DMA en D2 : à 0 en multi-channel */
	sport0_iop.rxc.schen    = 1;    /* autorisation du chaînage de DMA en réception */
	sport0_iop.rxc.sden     = 1;    /* autorisation de la DMA en réception */
	sport0_iop.rxc.lafs     = 0;    /* à 0 en multi-channel */
	sport0_iop.rxc.ltfs     = 0;    /* synchro trame active au niveau haut */
	sport0_iop.rxc.irfs     = 0;    /* synchro trame générée en externe */
	sport0_iop.rxc.rfsr     = 0;    /* à 0 en multi-channel */
	sport0_iop.rxc.ckre     = 0;    /* échantillonnage des bits sur front descendant de la clock */
	sport0_iop.rxc.gclk     = 0;    /* clock générée en transmission seulement */
	sport0_iop.rxc.iclk     = 0;    /* clock générée en externe utilisée */
	sport0_iop.rxc.pack     = 0;    /* transmission de 32 bits en 2 fois 16 bits */
	sport0_iop.rxc.slen     = 15;   /* longueur d'un mot ( ici 16 bits ) -1 */
	sport0_iop.rxc.sendn    = 0;    /* format Endian ( = 0 : MSB en premier, = 1 : LSB en premier */
	sport0_iop.rxc.dtype    = 1;    /* justification à droite avec extension de signe aux MSB */
	sport0_iop.rxc.spen     = 0;    /* à 0 en multi-channel */

/* autorisation des interruptions DMA sur SPORT0 en réception et en émission */
	interrupt ( SIG_SPR0I,  it_dma_receive );       /* installation de l'interruption DMA en réception */
							/* cette it sera éxécutée chaque fois que le buffer de */
							/* réception de 3 mots rx_buf sera plein */
	interrupt ( SIG_SPT0I,  it_dma_transmit );      /* installation de l'interruption DMA en émission */
							/* cette it sera éxécutée chaque fois que le buffer de */
							/* transmission de 3 mots tx_buf sera vide */

/* initialisation du TCB de transmission pour le chaînage des DMA */
	tx_tcb.ii =  tx_buf;            /* pointe sur le buffer de transmission */
	tx_tcb.cp = &tx_tcb.ii;         /* pointe sur lui-même donc paramètrage identique pour toutes les DMA */
					/* qui vont s'enchaîner */
	*(int*)CP2 = ( (int)&tx_tcb.ii | 0x30000 );        /* initialise le registre CP2 du DSP */
					/* ( canal 2 de DMA en transmission ) */
					/* force le  bit 17 ( bit PCI autorisant  l'IT DMA ) */
					/* et le bit 16 ( MSB de l'adresse du premier TCB ) à 1 */
					/* initialise le premier paramètrage et lance la DMA en transmission */
					/* les 3 words de tx_buf vont être émis puis une IT DMA émission aura lieu */
					/* entraînant l'éxécution de la routine it_dma_transmit et un paramétrage */
					/* automatique de la prochaîne DMA avec les mêmes tx_tcb et tx_buf */

/* initialisation du TCB de réception pour le chaînage des DMA */
	rx_tcb.ii =  rx_buf;            /* pointe sur le buffer de réception */
	rx_tcb.cp = &rx_tcb.ii;         /* pointe sur lui-même donc paramètrage identique pour toutes les DMA */
					/* qui vont s'enchaîner */
	*(int*)CP0 = ( (int)&rx_tcb.ii | 0x30000 );        /* initialise le registre CP0 du DSP */
					/* ( canal 0 de DMA en réception ) */
					/* force le  bit 17 ( bit PCI autorisant l'IT DMA ) */
					/* et le bit 16 ( MSB de l'adresse du premier TCB ) à 1 */
					/* initialise le premier paramètrage et lance la DMA en réception */
					/* les 3 premier words reçus seront stocckés dans rx_buf */
					/* puis une IT DMA réception aura lieu */
					/* entraînant l'éxécution de la routine it_dma_receive et un paramétrage */
					/* automatique de la prochaîne DMA avec les mêmes rx_tcb et rx_buf */
}

/********************************************************************************/
/*      envoi des initialisations vers le Codec                                 */
/********************************************************************************/

void    init_codec ( void )
{
	tx_ptr          = regs_1847;            /* pointeur vers données d'initialisation du Codec */
	tx_compteur     = 16;                   /* init du comptage de mots à envoyer */

/* puis on attend l'émission complète des 16 mots sous IT DMA par la */ 
/* routine it_dma_transmit */
	while ( tx_compteur )
		idle ();                /* attente jusqu'à tx_compteur = 0 */

/* on a vu qu'après le dernier mot envoyé le Codec se met en autocalibration */
/* on vient lire le status word émis par le Codec et reçu sous IT DMA réception dans rx_buf[ 0 ] */
/* le bit 1 ( bit ACI ) du status word est à 1 pendant l'autocalibration ( 384 périodes d'échantillonnage ) et à 0 sinon */
/* il faut d'abord attendre que le bit ACI soit à 1 : démarrage de l'autocalibration */
/* sinon on risque de trouver 0 tout de suite et de penser que l'autocalibration est finie alors qu'elle n'a pas commencé */
/* on fait pour cela une scrutation de l'état haut de ACI */
	while ( !( rx_buf[ 0 ] & 0x0002 ))
		idle ( );               /* attente jusqu'à bit ACI = 1 : début autocalibration */
/* puis on attend la fin de l'autocalibration en scrutant le passageà 0 du bit ACI */
	while ( rx_buf[ 0 ] & 0x0002 )
		idle ( );               /* attente jusqu'à bit ACI = 0 : fin d' autocalibration */
}



/********************************************************************************/
/*      Le main                                                                 */
/********************************************************************************/

void    main    ( void )
{
int *dms2;
    int msize;
    int data;
    int x,i;
    char ch;
    joue_note=0;
    

    printf( "Clavier musical, jouez...\n" ); 

    BASE(note) = echant;         /* Setup note as a cicular pointer into the */
    LENGTH(note) = long_buff;      /* buffer.                                  */

/* initialisation du DSP */
	init_dsp ( );

/* reset du Codec : mise à 0 de la sortie FLAG0 relié au /Reset du Codec */
	set_flag ( SET_FLAG0,CLR_FLAG);
	for ( i=0 ; i<0xFFFF ; i++ );           /* et attendre suffisamment longtemps */
	set_flag ( SET_FLAG0,SET_FLAG);  /* avant de remonter le reset */

/* configuration du SPORT0 du DSP */
	init_sport0 ( );

/* envoi des commandes d'initialisation vers le Codec : ces commandes sont envoyées sous DMA */

	init_codec ( );
/* valide le timer et ses interruptions périodiques */
	timer_set(20000000,20000000);
	timer_on ( );

do 
    
    
   { 
 
    ch=getch();
 
   switch (ch) 
	{
	case 'a': joue_note=1; max=sol; break;
	case 'z': joue_note=1; max=la; break;
	case 'e': joue_note=1; max=si; break;
	case 'r': joue_note=1; max=ut; break;
      
	} 
	} while (ch != 'q');

}


