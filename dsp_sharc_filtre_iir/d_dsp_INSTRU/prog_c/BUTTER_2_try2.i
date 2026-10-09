# 1 "BUTTER_2_try2.c"
 
 


 
# 1 "C:\EZ-KIT\21k\include\def21060.h" 1
 














 
 

















 













 




























 

















 






























 






























































































































































 






















 
















# 6 "BUTTER_2_try2.c" 2

# 1 "C:\EZ-KIT\21k\include\21060.h" 1
 





void		idle(void);

int		timer_set(unsigned int tperiod, unsigned int tcount);
unsigned int	timer_on(void);
unsigned int	timer_off(void);

int		poll_flag_in(int flag, int mode);
int		set_flag(int flag, int mode);

int test_and_set_semaphore(void *semaphore, int test_value, int set_value, int timeout);
int set_semaphore(void *semaphore, int set_value, int timeout);

int fpack(float);
float funpack(int);













































 





















# 7 "BUTTER_2_try2.c" 2

# 1 "C:\EZ-KIT\21k\include\sport.h" 1
 






struct __sport_transmit_control_register
{
     
    unsigned int const volatile txs:2;   
    unsigned int const volatile tuvf:1;  
    unsigned int const volatile chnl:5;  
    
     
    unsigned int mdf:4;        
    
     
    unsigned int schen:1;      
    unsigned int sden:1;       
    
     
    unsigned int lafs:1;       
    unsigned int ltfs:1;       
    unsigned int ditfs:1;      
    unsigned int itfs:1;       
    unsigned int tfsr:1;       
    
     
    unsigned int ckre:1;       
    unsigned int gclk:1;       
    unsigned int iclk:1;       
    unsigned int pack:1;       
    unsigned int slen:5;       
    unsigned int sendn:1;      
    unsigned int dtype:2;      
    unsigned int spen:1;       
};

struct __sport_receive_control_register
{
     
    unsigned int const volatile rxs:2;   
    unsigned int const volatile ruvf:1;  
    
     
    unsigned int nch:5;        
    unsigned int mce:1;        
    
     
    unsigned int spl:1;        
    unsigned int d2dma:1;      
    
    unsigned int const __reserved_1:1;   
    
     
    unsigned int schen:1;      
    unsigned int sden:1;       
    
     
    unsigned int lafs:1;       
    unsigned int ltfs:1;       
    
    unsigned int const __reserved_2:1;   
    
    unsigned int irfs:1;       
    unsigned int rfsr:1;       
    
     
    unsigned int ckre:1;       
    unsigned int gclk:1;       
    unsigned int iclk:1;       
    unsigned int pack:1;       
    unsigned int slen:5;       
    unsigned int sendn:1;      
    unsigned int dtype:2;      
    unsigned int spen:1;       
    
};
    
struct __transmit_divisor_register_structure
{
    unsigned int tfsdiv:16;   
    unsigned int tckdiv:16;   
};

struct __receive_divisor_register_structure
{
    unsigned int rfsdiv:16;   
    unsigned int rckdiv:16;   
};

struct __sport_structure
{
    struct __sport_transmit_control_register txc;  
    struct __sport_receive_control_register rxc;   

    int volatile tx;               
    int volatile rx;               

    struct __transmit_divisor_register_structure tdiv;  

    int const volatile tcnt;      

    struct __receive_divisor_register_structure rdiv;   

    int const volatile rcnt;      

    int mtcs;         
    int mrcs;         
    int mtccs;        
    int mrccs;        
} ;





# 133 "C:\EZ-KIT\21k\include\sport.h"



    









# 8 "BUTTER_2_try2.c" 2

# 1 "C:\EZ-KIT\21k\include\macros.h" 1
 

































































 
















 














 











 


























































             

# 217 "C:\EZ-KIT\21k\include\macros.h"


 




























































































































 
















# 9 "BUTTER_2_try2.c" 2


 
# 1 "C:\EZ-KIT\21k\include\signal.h" 1
 
















































# 69 "C:\EZ-KIT\21k\include\signal.h"











 

typedef int sig_atomic_t;
 


void (*signal(int sig, void (*func)(int))) (int);
void (*signalf(int sig, void (*func)(int))) (int);
void (*signals(int sig, void (*func)(int))) (int);
void (*interrupt(int sig, void (*func)(int))) (int);
void (*interruptf(int sig, void (*func)(int))) (int);
void (*interrupts(int sig, void (*func)(int))) (int);
int raise(int);
int clear_interrupt(int sig);

 
 
































# 12 "BUTTER_2_try2.c" 2

# 1 "C:\EZ-KIT\21k\include\filters.h" 1
 





float	fir(float sample, float pm coeffs[], float dm state[],int taps);
float 	iir(float sample, float pm a_coeffs[], float pm b_coeffs[], 
            float dm state[], int taps);
float	biquad(float sample, float pm coeffs[], float dm state[], int sections);



# 13 "BUTTER_2_try2.c" 2

# 1 "C:\EZ-KIT\21k\include\math.h" 1
 









double	acos(double);
double	asin(double);
double	atan(double);
double	atan2(double, double);
double	cos(double);
double	sin(double);
double	tan(double);
double 	cot(double);
double	cosh(double);
double	sinh(double);
double	tanh(double);
double	exp(double);
double	frexp(double, int *);
double	ldexp(double, int);
double	log(double);
double	log10(double);
double	modf(double, double *);
double	pow(double, double);
double	sqrt(double);
double	rsqrt(double);
double	ceil(double);
double	fabs(double);
double	floor(double);
double	fmod(double, double);

float	acosf(float);
float	asinf(float);
float	atanf(float);
float	atan2f(float, float);
float	cosf(float);
float	sinf(float);
float	tanf(float);
float   cotf(float);
float	coshf(float);
float	sinhf(float);
float	tanhf(float);
float	expf(float);
float	frexpf(float, int *);
float	ldexpf(float, int);
float	logf(float);
float	log10f(float);
float	modff(float, float *);
float	powf(float, float);
float	sqrtf(float);
float	rsqrtf(float);
float	ceilf(float);
float	fabsf(float);
float	floorf(float);
float	fmodf(float, float);

# 87 "C:\EZ-KIT\21k\include\math.h"







# 14 "BUTTER_2_try2.c" 2


 
 
 
 
 
 
 
 
 

int     regs_1847[16]=  {

	0xC000,          
	0xC100,          
	0xC280,          
	0xC380,          
	0xC480,          
	0xC580,          
	0xC600,          
	0xC700,          
	0xC850,          
			 
			 
			 
			 
			 
	0xC909,  
			 
			 
			 
	0xCA00,  
			 
			 
	0xCB00,  
	0xCC40,  
			 
			 
			 
	0xCD00,  
			 
			 
	0xCE00,  
	0x8F00           
			 
				};

 
int     rx_buf[3];
 
 
int     tx_buf[3]={0xCC40,      0,      0};

 
 
 
typedef struct  {
	unsigned        ei;      
	unsigned        em;      
	unsigned        ec;      
	unsigned        gp1;     
	unsigned        gp2;     
	unsigned**      cp;      
	unsigned        c;       
	int             im;      
	unsigned*       ii;      
		}       tcb;
 
tcb     rx_tcb = {0,    0,      0,      0,      0,      0,      3,      1,      0};
 
tcb     tx_tcb = {0,    0,      0,      0,      0,      0,      3,      1,      0};
int*    tx_ptr;
int     tx_compteur;

 
 

void    it_timer        ( int sig_num )
{
 
	set_flag ( 2 , 2  );        
						 
}
 
 

void    it_dma_transmit ( int sig_num )
{
 
	if ( tx_compteur )
	{
	 
		tx_buf[0] = *tx_ptr++;  
		tx_compteur--;
	 
	 
	 
	}
}
 
 

void    it_dma_receive ( int sig_num )
{
 
 
 
	int i ;
	static float pm b[3 +1]={1 ,-1.547 , 0.632};
	static float pm a[3 ]={0.021 , 0.042 , 0.021};
	float in_sample = rx_buf[1];
	float output;
	float state[3 +1];
	for(i=0 ; i< 3 +1 ; i++)
	{
		state[i]=0;
		output= iir(in_sample,a,b,state,3 );
		
	}
}

 
 



void    init_dsp        ( void )
{
	({ int __temp_ret; asm volatile ("\n\tBIT CLR MODE2 32;\n" "\t%0=TCOUNT;" : "=d" (__temp_ret)); __temp_ret;}) ;                           
	({ int __temp_ret; asm volatile ("\n\tTPERIOD=%1;\n" "\tTCOUNT=%2;\n" "\t%0=MODE2;\n" "\t%0=FEXT %0 by 5:1;": "=&d" (__temp_ret): "d" ( 10000000), "d" (    10000000 ):"TPERIOD", "TCOUNT"); __temp_ret;}) ;      
						 
						 
						 
	asm( " #include <def21060.h> " );
	asm ( " bit set mode1 NESTM; " );                
						 
						 

	tx_ptr          = regs_1847;             
	tx_compteur     = 0;                     

	interrupt ( 	23 ,    it_timer );      
						 
						 
						 
}


 
 



void    init_sport0 ( void )
{

 
	(*(volatile struct __sport_structure *)0x00e0) .mtcs =       0x00070007;      
	(*(volatile struct __sport_structure *)0x00e0) .mrcs =       0x00070007;      
	(*(volatile struct __sport_structure *)0x00e0) .mtccs        =       0x00000000;      
	(*(volatile struct __sport_structure *)0x00e0) .mrccs        =       0x00000000;      

 
 
	(*(volatile struct __sport_structure *)0x00e0) .txc.mdf      = 1;     
	(*(volatile struct __sport_structure *)0x00e0) .txc.schen    = 1;     
	(*(volatile struct __sport_structure *)0x00e0) .txc.sden     = 1;     
	(*(volatile struct __sport_structure *)0x00e0) .txc.lafs     = 0;     
	(*(volatile struct __sport_structure *)0x00e0) .txc.ltfs     = 0;     
	(*(volatile struct __sport_structure *)0x00e0) .txc.ditfs    = 0;     
	(*(volatile struct __sport_structure *)0x00e0) .txc.itfs     = 0;     
	(*(volatile struct __sport_structure *)0x00e0) .txc.tfsr     = 0;     
	(*(volatile struct __sport_structure *)0x00e0) .txc.ckre     = 0;     
	(*(volatile struct __sport_structure *)0x00e0) .txc.gclk     = 0;     
	(*(volatile struct __sport_structure *)0x00e0) .txc.iclk     = 0;     
	(*(volatile struct __sport_structure *)0x00e0) .txc.pack     = 0;     
	(*(volatile struct __sport_structure *)0x00e0) .txc.slen     = 15;    
	(*(volatile struct __sport_structure *)0x00e0) .txc.sendn    = 0;     
	(*(volatile struct __sport_structure *)0x00e0) .txc.dtype    = 1;     
	(*(volatile struct __sport_structure *)0x00e0) .txc.spen     = 0;     

 
 
	(*(volatile struct __sport_structure *)0x00e0) .rxc.nch      = 31;    
	(*(volatile struct __sport_structure *)0x00e0) .rxc.mce      = 1;     
	(*(volatile struct __sport_structure *)0x00e0) .rxc.spl      = 0;     
	(*(volatile struct __sport_structure *)0x00e0) .rxc.d2dma    = 0;     
	(*(volatile struct __sport_structure *)0x00e0) .rxc.schen    = 1;     
	(*(volatile struct __sport_structure *)0x00e0) .rxc.sden     = 1;     
	(*(volatile struct __sport_structure *)0x00e0) .rxc.lafs     = 0;     
	(*(volatile struct __sport_structure *)0x00e0) .rxc.ltfs     = 0;     
	(*(volatile struct __sport_structure *)0x00e0) .rxc.irfs     = 0;     
	(*(volatile struct __sport_structure *)0x00e0) .rxc.rfsr     = 0;     
	(*(volatile struct __sport_structure *)0x00e0) .rxc.ckre     = 0;     
	(*(volatile struct __sport_structure *)0x00e0) .rxc.gclk     = 0;     
	(*(volatile struct __sport_structure *)0x00e0) .rxc.iclk     = 0;     
	(*(volatile struct __sport_structure *)0x00e0) .rxc.pack     = 0;     
	(*(volatile struct __sport_structure *)0x00e0) .rxc.slen     = 15;    
	(*(volatile struct __sport_structure *)0x00e0) .rxc.sendn    = 0;     
	(*(volatile struct __sport_structure *)0x00e0) .rxc.dtype    = 1;     
	(*(volatile struct __sport_structure *)0x00e0) .rxc.spen     = 0;     

 
	interrupt (       10 ,  it_dma_receive );        
							 
							 
	interrupt (       12 ,  it_dma_transmit );       
							 
							 
 

	tx_tcb.ii =  tx_buf;             
	tx_tcb.cp = &tx_tcb.ii;          
					 
	*(int*)   0x73	    = ( (int)&tx_tcb.ii | 0x30000 );      
					 
					 
					 
					 
					 
					 
					 
					 

 

	rx_tcb.ii =  rx_buf;             
	rx_tcb.cp = &rx_tcb.ii;          
					 
	*(int*)   0x63	    = ( (int)&rx_tcb.ii | 0x30000 );      
					 
					 
					 
					 
					 
					 
					 
					 
					 

}

 
 

void    init_codec ( void )
{
	tx_ptr          = regs_1847;             
	tx_compteur     = 16;                    

 
	while ( tx_compteur )
		idle ();                 

 
 
 
 
 
 
	while ( !( rx_buf[ 0 ] & 0x0002 ))
		idle ( );                
 
	while ( rx_buf[ 0 ] & 0x0002 )
		idle ( );                
}



 
 

void    main    ( void )
{
	int i ;
 
	init_dsp ( );

 
	set_flag ( 0 ,1 );
	for ( i=0 ; i<0xFFFF ; i++ );            
	set_flag ( 0 ,0 );  

 
	init_sport0 ( );

 

	init_codec ( );

 
	({ int __temp_ret; asm volatile ("\n\tBIT SET MODE2 32;\n" "\t%0=TCOUNT;" : "=d" (__temp_ret)); __temp_ret;}) ;

 
	while ( 1 )
		idle;

}

 
