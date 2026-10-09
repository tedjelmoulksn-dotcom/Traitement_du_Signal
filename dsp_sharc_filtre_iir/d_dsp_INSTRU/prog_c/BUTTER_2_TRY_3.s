	!! GNU CC rel3.3 21k/SHARC 3.3.0.1
	!!  -fdefer-pop -fpeephole -fforce-mem -ffunction-cse -fcaller-saves -fcommon
	!!  -fgnu-linker -mxrtrts -mxregparm -mxdmstack -mADSP21060

!		Analog Devices ADSP210x0
.segment /pm seg_pmco; .file "BUTTER_2_TRY_3.c"; .endseg;
.segment /dm seg_dmda;
.gcc_compiled;
.endseg;
.segment /pm seg_pmco;

	.def	___sport_transmit_control_register;	.scl	10;	.type	010;	.size	1;	.endef;
	.def	_txs;	.val	0;	.scl	18;	.type	016;	.size	2;	.endef;
	.def	_tuvf;	.val	2;	.scl	18;	.type	016;	.size	1;	.endef;
	.def	_chnl;	.val	3;	.scl	18;	.type	016;	.size	5;	.endef;
	.def	_mdf;	.val	8;	.scl	18;	.type	016;	.size	4;	.endef;
	.def	_schen;	.val	12;	.scl	18;	.type	016;	.size	1;	.endef;
	.def	_sden;	.val	13;	.scl	18;	.type	016;	.size	1;	.endef;
	.def	_lafs;	.val	14;	.scl	18;	.type	016;	.size	1;	.endef;
	.def	_ltfs;	.val	15;	.scl	18;	.type	016;	.size	1;	.endef;
	.def	_ditfs;	.val	16;	.scl	18;	.type	016;	.size	1;	.endef;
	.def	_itfs;	.val	17;	.scl	18;	.type	016;	.size	1;	.endef;
	.def	_tfsr;	.val	18;	.scl	18;	.type	016;	.size	1;	.endef;
	.def	_ckre;	.val	19;	.scl	18;	.type	016;	.size	1;	.endef;
	.def	_gclk;	.val	20;	.scl	18;	.type	016;	.size	1;	.endef;
	.def	_iclk;	.val	21;	.scl	18;	.type	016;	.size	1;	.endef;
	.def	_pack;	.val	22;	.scl	18;	.type	016;	.size	1;	.endef;
	.def	_slen;	.val	23;	.scl	18;	.type	016;	.size	5;	.endef;
	.def	_sendn;	.val	28;	.scl	18;	.type	016;	.size	1;	.endef;
	.def	_dtype;	.val	29;	.scl	18;	.type	016;	.size	2;	.endef;
	.def	_spen;	.val	31;	.scl	18;	.type	016;	.size	1;	.endef;
	.def	.eos;	.val	1;	.scl	102;	.tag	___sport_transmit_control_register;	.size	1;	.endef;
	.def	___sport_receive_control_register;	.scl	10;	.type	010;	.size	1;	.endef;
	.def	_rxs;	.val	0;	.scl	18;	.type	016;	.size	2;	.endef;
	.def	_ruvf;	.val	2;	.scl	18;	.type	016;	.size	1;	.endef;
	.def	_nch;	.val	3;	.scl	18;	.type	016;	.size	5;	.endef;
	.def	_mce;	.val	8;	.scl	18;	.type	016;	.size	1;	.endef;
	.def	_spl;	.val	9;	.scl	18;	.type	016;	.size	1;	.endef;
	.def	_d2dma;	.val	10;	.scl	18;	.type	016;	.size	1;	.endef;
	.def	___reserved_1;	.val	11;	.scl	18;	.type	016;	.size	1;	.endef;
	.def	_schen;	.val	12;	.scl	18;	.type	016;	.size	1;	.endef;
	.def	_sden;	.val	13;	.scl	18;	.type	016;	.size	1;	.endef;
	.def	_lafs;	.val	14;	.scl	18;	.type	016;	.size	1;	.endef;
	.def	_ltfs;	.val	15;	.scl	18;	.type	016;	.size	1;	.endef;
	.def	___reserved_2;	.val	16;	.scl	18;	.type	016;	.size	1;	.endef;
	.def	_irfs;	.val	17;	.scl	18;	.type	016;	.size	1;	.endef;
	.def	_rfsr;	.val	18;	.scl	18;	.type	016;	.size	1;	.endef;
	.def	_ckre;	.val	19;	.scl	18;	.type	016;	.size	1;	.endef;
	.def	_gclk;	.val	20;	.scl	18;	.type	016;	.size	1;	.endef;
	.def	_iclk;	.val	21;	.scl	18;	.type	016;	.size	1;	.endef;
	.def	_pack;	.val	22;	.scl	18;	.type	016;	.size	1;	.endef;
	.def	_slen;	.val	23;	.scl	18;	.type	016;	.size	5;	.endef;
	.def	_sendn;	.val	28;	.scl	18;	.type	016;	.size	1;	.endef;
	.def	_dtype;	.val	29;	.scl	18;	.type	016;	.size	2;	.endef;
	.def	_spen;	.val	31;	.scl	18;	.type	016;	.size	1;	.endef;
	.def	.eos;	.val	1;	.scl	102;	.tag	___sport_receive_control_register;	.size	1;	.endef;
	.def	___transmit_divisor_register_structure;	.scl	10;	.type	010;	.size	1;	.endef;
	.def	_tfsdiv;	.val	0;	.scl	18;	.type	016;	.size	16;	.endef;
	.def	_tckdiv;	.val	16;	.scl	18;	.type	016;	.size	16;	.endef;
	.def	.eos;	.val	1;	.scl	102;	.tag	___transmit_divisor_register_structure;	.size	1;	.endef;
	.def	___receive_divisor_register_structure;	.scl	10;	.type	010;	.size	1;	.endef;
	.def	_rfsdiv;	.val	0;	.scl	18;	.type	016;	.size	16;	.endef;
	.def	_rckdiv;	.val	16;	.scl	18;	.type	016;	.size	16;	.endef;
	.def	.eos;	.val	1;	.scl	102;	.tag	___receive_divisor_register_structure;	.size	1;	.endef;
	.def	___sport_structure;	.scl	10;	.type	010;	.size	12;	.endef;
	.def	_txc;	.val	0;	.scl	8;	.tag	___sport_transmit_control_register;	.size	1;	.type	010;	.endef;
	.def	_rxc;	.val	1;	.scl	8;	.tag	___sport_receive_control_register;	.size	1;	.type	010;	.endef;
	.def	_tx;	.val	2;	.scl	8;	.type	04;	.endef;
	.def	_rx;	.val	3;	.scl	8;	.type	04;	.endef;
	.def	_tdiv;	.val	4;	.scl	8;	.tag	___transmit_divisor_register_structure;	.size	1;	.type	010;	.endef;
	.def	_tcnt;	.val	5;	.scl	8;	.type	04;	.endef;
	.def	_rdiv;	.val	6;	.scl	8;	.tag	___receive_divisor_register_structure;	.size	1;	.type	010;	.endef;
	.def	_rcnt;	.val	7;	.scl	8;	.type	04;	.endef;
	.def	_mtcs;	.val	8;	.scl	8;	.type	04;	.endef;
	.def	_mrcs;	.val	9;	.scl	8;	.type	04;	.endef;
	.def	_mtccs;	.val	10;	.scl	8;	.type	04;	.endef;
	.def	_mrccs;	.val	11;	.scl	8;	.type	04;	.endef;
	.def	.eos;	.val	12;	.scl	102;	.tag	___sport_structure;	.size	12;	.endef;
	.def	_sig_atomic_t;	.scl	13;	.type	04;	.endef;
.endseg;
.segment /dm seg_dmda;

.global	_regs_1847;
.var	_regs_1847[16]  = 49152,49408,49792,50048,50304,50560,50688,50944,51280,51465,51712,51968,52288,52480,52736,36608;
.global	_tx_buf;
.var	_tx_buf[3]  = 52288,0,0;
.endseg;
.segment /pm seg_pmco;

	.def	__0fake;	.scl	10;	.type	010;	.size	9;	.endef;
	.def	_ei;	.val	0;	.scl	8;	.type	016;	.endef;
	.def	_em;	.val	1;	.scl	8;	.type	016;	.endef;
	.def	_ec;	.val	2;	.scl	8;	.type	016;	.endef;
	.def	_gp1;	.val	3;	.scl	8;	.type	016;	.endef;
	.def	_gp2;	.val	4;	.scl	8;	.type	016;	.endef;
	.def	_cp;	.val	5;	.scl	8;	.type	0136;	.endef;
	.def	_c;	.val	6;	.scl	8;	.type	016;	.endef;
	.def	_im;	.val	7;	.scl	8;	.type	04;	.endef;
	.def	_ii;	.val	8;	.scl	8;	.type	036;	.endef;
	.def	.eos;	.val	9;	.scl	102;	.tag	__0fake;	.size	9;	.endef;
	.def	_tcb;	.scl	13;	.tag	__0fake;	.size	9;	.type	010;	.endef;
.endseg;
.segment /dm seg_dmda;

.global	_rx_tcb;
.var	_rx_tcb[9]  = 0,0,0,0,0,0,3,1,0;
.global	_tx_tcb;
.var	_tx_tcb[9]  = 0,0,0,0,0,0,3,1,0;
.extern	_set_flag;
.endseg;
.segment /pm seg_pmco;

	.def	_it_timer;	.val	_it_timer;	.scl	2;	.type	041;	.endef;
.global	_it_timer;
_it_timer:
!	FUNCTION PROLOGUE: it_timer
!	rtrts protocol, params in registers, DM stack, doubles are floats
	modify(i7,-1);
!	saving registers: 
	.def end_prologue;	.val	.;	.scl	109;	.endef;
	dm(-2,i6)=r4;
	.def	.bf;	.val	.;	.scl	101;	.line	93;	.endef;
	.def	_sig_num;	.val	4;	.scl	17;	.type	04;	.endef;
	.def	_sig_num;	.val	-2;	.scl	9;	.type	04;	.endef;
	.ln	95;
	r8=2;
	r4=2;
	cjump (pc, _set_flag) (DB);!.call
	dm(i7,m7)=r2;
	dm(i7,m7)=pc;
	.ln	97;
_L$1:
	.def	.ef;	.val	.;	.scl	101;	.line	97;	.endef;
!	FUNCTION EPILOGUE: 
	i12=dm(-1,i6);
	jump (m14,i12) (DB);!.return
	nop;
	RFRAME;
	.def	_it_timer;	.val	.;	.scl	-1;	.endef;
	.def	_it_dma_transmit;	.val	_it_dma_transmit;	.scl	2;	.type	041;	.endef;
.global	_it_dma_transmit;
_it_dma_transmit:
!	FUNCTION PROLOGUE: it_dma_transmit
!	rtrts protocol, params in registers, DM stack, doubles are floats
	modify(i7,-2);
!	saving registers: 
	r2=i0;
	dm(-3,i6)=r2;
	.def end_prologue;	.val	.;	.scl	109;	.endef;
	dm(-2,i6)=r4;
	.def	.bf;	.val	.;	.scl	101;	.line	102;	.endef;
	.def	_sig_num;	.val	4;	.scl	17;	.type	04;	.endef;
	.def	_sig_num;	.val	-2;	.scl	9;	.type	04;	.endef;
	.ln	104;
	r2=dm(_tx_compteur);
	r2=pass r2;
	if eq jump (pc, _L$4) ;
	.ln	107;
	i4=dm(_tx_ptr);
	i0=i4;
	modify(i0,m6);
	dm(_tx_ptr)=i0;
	r2=dm(i4,m5);
	dm(_tx_buf)=r2;
	.ln	108;
	r2=dm(_tx_compteur);
	r4=r2-1;
	r2=r4;
	dm(_tx_compteur)=r2;
_L$4:
	.ln	113;
_L$3:
	.def	.ef;	.val	.;	.scl	101;	.line	113;	.endef;
!	FUNCTION EPILOGUE: 
	i12=dm(-1,i6);
	i0=dm(-3,i6);
	jump (m14,i12) (DB);!.return
	nop;
	RFRAME;
	.def	_it_dma_transmit;	.val	.;	.scl	-1;	.endef;
.endseg;
.segment /pm seg_pmda;
.var	_b_6[4]  =  0x3f800000, 0xbfc60419, 0x3f21cac1,0;
.var	_a_7[3]  =  0x3cac0831, 0x3d2c0831, 0x3cac0831;
.extern	_iir;
.endseg;
.segment /pm seg_pmco;

	.def	_it_dma_receive;	.val	_it_dma_receive;	.scl	2;	.type	041;	.endef;
.global	_it_dma_receive;
_it_dma_receive:
!	FUNCTION PROLOGUE: it_dma_receive
!	rtrts protocol, params in registers, DM stack, doubles are floats
	modify(i7,-9);
!	saving registers: 
	r2=i0;
	dm(-10,i6)=r2;
	.def end_prologue;	.val	.;	.scl	109;	.endef;
	dm(-2,i6)=r4;
	.def	.bf;	.val	.;	.scl	101;	.line	118;	.endef;
	.def	_sig_num;	.val	4;	.scl	17;	.type	04;	.endef;
	.def	_sig_num;	.val	-2;	.scl	9;	.type	04;	.endef;
	.ln	122;
	.def	.bb;	.val	.;	.scl	100;	.line	5;	.endef;
	.def	_i;	.val	-3;	.scl	1;	.type	04;	.endef;
	.def	_b_6;	.val	_b_6;	.scl	3;	.dim	4;	.size	4;	.type	066;	.endef;
	.def	_a_7;	.val	_a_7;	.scl	3;	.dim	3;	.size	3;	.type	066;	.endef;
	.def	_in_sample;	.val	-4;	.scl	1;	.type	06;	.endef;
	.def	_output;	.val	-5;	.scl	1;	.type	06;	.endef;
	.def	_state;	.val	-9;	.scl	1;	.dim	4;	.size	4;	.type	066;	.endef;
	.ln	125;
	r2=dm(_rx_buf+1);
	f4=float r2;
	dm(-4,i6)=f4;
	.ln	128;
	r2=0;
	dm(-3,i6)=r2;
_L$6:
	r2=dm(-3,i6);
	r4=3;
	comp(r2,r4);
	if gt jump (pc, _L$7) ;
	.ln	130;
	i0=i6;
	modify(i0,-9);
	r2=i0;
	r4=dm(-3,i6);
	r1=r2+r4;
	i4=r1;
	dm(i4,m5)= 0x00000000;
	.ln	131;
	r2=3;
	dm(i7,m7)=r2;
	i0=i6;
	modify(i0,-9);
	r2=i0;
	dm(i7,m7)=r2;
	r12=_b_6;
	r8=_a_7;
	f4=dm(-4,i6);
	cjump (pc, _iir) (DB);!.call
	dm(i7,m7)=r2;
	dm(i7,m7)=pc;
	modify(i7,2);
	dm(-5,i6)=f0;
	.ln	128;
_L$8:
	r2=dm(-3,i6);
	r4=r2+1;
	r2=r4;
	dm(-3,i6)=r2;
	jump (pc, _L$6) ;
_L$7:
	.ln	134;
	.def	.eb;	.val	.;	.scl	100;	.line	17;	.endef;
_L$5:
	.def	.ef;	.val	.;	.scl	101;	.line	134;	.endef;
!	FUNCTION EPILOGUE: 
	i12=dm(-1,i6);
	i0=dm(-10,i6);
	jump (m14,i12) (DB);!.return
	nop;
	RFRAME;
	.def	_it_dma_receive;	.val	.;	.scl	-1;	.endef;
.extern	_interrupt;
	.def	_init_dsp;	.val	_init_dsp;	.scl	2;	.type	041;	.endef;
.global	_init_dsp;
_init_dsp:
!	FUNCTION PROLOGUE: init_dsp
!	rtrts protocol, params in registers, DM stack, doubles are floats
	modify(i7,-2);
!	saving registers: 
	.def end_prologue;	.val	.;	.scl	109;	.endef;
	.def	.bf;	.val	.;	.scl	101;	.line	142;	.endef;
	.ln	143;
	.def	.bb;	.val	.;	.scl	100;	.line	2;	.endef;
	.def	.bb;	.val	.;	.scl	100;	.line	2;	.endef;
	.def	___temp_ret;	.val	-2;	.scl	1;	.type	04;	.endef;
	
	BIT CLR MODE2 32;
	r1=TCOUNT;
	dm(-2,i6)=r1;
	.def	.eb;	.val	.;	.scl	100;	.line	2;	.endef;
	.ln	144;
	.def	.bb;	.val	.;	.scl	100;	.line	3;	.endef;
	.def	___temp_ret;	.val	-3;	.scl	1;	.type	04;	.endef;
	r1=10000000;
	
	TPERIOD=r1;
	TCOUNT=r1;
	r12=MODE2;
	r12=FEXT r12 by 5:1;
	dm(-3,i6)=r12;
	.def	.eb;	.val	.;	.scl	100;	.line	3;	.endef;
	.ln	148;
	 #include <def21060.h> 
	.ln	149;
	 bit set mode1 NESTM; 
	.ln	153;
	r2=_regs_1847;
	dm(_tx_ptr)=r2;
	.ln	154;
	r2=0;
	dm(_tx_compteur)=r2;
	.ln	156;
	r8=_it_timer;
	r4=23;
	cjump (pc, _interrupt) (DB);!.call
	dm(i7,m7)=r2;
	dm(i7,m7)=pc;
	.ln	160;
	.def	.eb;	.val	.;	.scl	100;	.line	19;	.endef;
_L$10:
	.def	.ef;	.val	.;	.scl	101;	.line	160;	.endef;
!	FUNCTION EPILOGUE: 
	i12=dm(-1,i6);
	jump (m14,i12) (DB);!.return
	nop;
	RFRAME;
	.def	_init_dsp;	.val	.;	.scl	-1;	.endef;
	.def	_init_sport0;	.val	_init_sport0;	.scl	2;	.type	041;	.endef;
.global	_init_sport0;
_init_sport0:
!	FUNCTION PROLOGUE: init_sport0
!	rtrts protocol, params in registers, DM stack, doubles are floats
	.def end_prologue;	.val	.;	.scl	109;	.endef;
	.def	.bf;	.val	.;	.scl	101;	.line	169;	.endef;
	.ln	172;
	i4=224;
	r2=458759;
	dm(8,i4)=r2;
	.ln	173;
	i4=224;
	r2=458759;
	dm(9,i4)=r2;
	.ln	174;
	i4=224;
	r2=0;
	dm(10,i4)=r2;
	.ln	175;
	i4=224;
	r2=0;
	dm(11,i4)=r2;
	.ln	179;
	i4=224;
	r2=dm(i4,m5);
	r4=m6;
	r8=-15728641;
	r8=r2 and r8;
	r8=r8 or fdep r4 by 20:4;
	r2=r8;
	dm(i4,m5)=r2;
	.ln	180;
	i4=224;
	r2=dm(i4,m5);
	r4=524288;
	r2=r2 or r4;
	dm(i4,m5)=r2;
	.ln	181;
	i4=224;
	r2=dm(i4,m5);
	r4=262144;
	r2=r2 or r4;
	dm(i4,m5)=r2;
	.ln	182;
	i4=224;
	r2=dm(i4,m5);
	r4=-131073;
	r2=r2 and r4;
	dm(i4,m5)=r2;
	.ln	183;
	i4=224;
	r2=dm(i4,m5);
	r4=-65537;
	r2=r2 and r4;
	dm(i4,m5)=r2;
	.ln	184;
	i4=224;
	r2=dm(i4,m5);
	r4=-32769;
	r2=r2 and r4;
	dm(i4,m5)=r2;
	.ln	185;
	i4=224;
	r2=dm(i4,m5);
	r4=-16385;
	r2=r2 and r4;
	dm(i4,m5)=r2;
	.ln	186;
	i4=224;
	r2=dm(i4,m5);
	r4=-8193;
	r2=r2 and r4;
	dm(i4,m5)=r2;
	.ln	187;
	i4=224;
	r2=dm(i4,m5);
	r4=-4097;
	r2=r2 and r4;
	dm(i4,m5)=r2;
	.ln	188;
	i4=224;
	r2=dm(i4,m5);
	r4=-2049;
	r2=r2 and r4;
	dm(i4,m5)=r2;
	.ln	189;
	i4=224;
	r2=dm(i4,m5);
	r4=-1025;
	r2=r2 and r4;
	dm(i4,m5)=r2;
	.ln	190;
	i4=224;
	r2=dm(i4,m5);
	r4=-513;
	r2=r2 and r4;
	dm(i4,m5)=r2;
	.ln	191;
	i4=224;
	r2=dm(i4,m5);
	r4=15;
	r8=-497;
	r8=r2 and r8;
	r8=r8 or fdep r4 by 4:5;
	r2=r8;
	dm(i4,m5)=r2;
	.ln	192;
	i4=224;
	r2=dm(i4,m5);
	r4=-9;
	r2=r2 and r4;
	dm(i4,m5)=r2;
	.ln	193;
	i4=224;
	r2=dm(i4,m5);
	r4=m6;
	r8=-7;
	r8=r2 and r8;
	r8=r8 or fdep r4 by 1:2;
	r2=r8;
	dm(i4,m5)=r2;
	.ln	194;
	i4=224;
	r2=dm(i4,m5);
	r4=-2;
	r2=r2 and r4;
	dm(i4,m5)=r2;
	.ln	198;
	i4=224;
	r2=dm(1,i4);
	r4=31;
	r8=-520093697;
	r8=r2 and r8;
	r8=r8 or fdep r4 by 24:5;
	r2=r8;
	dm(1,i4)=r2;
	.ln	199;
	i4=224;
	r2=dm(1,i4);
	r4=8388608;
	r2=r2 or r4;
	dm(1,i4)=r2;
	.ln	200;
	i4=224;
	r2=dm(1,i4);
	r4=-4194305;
	r2=r2 and r4;
	dm(1,i4)=r2;
	.ln	201;
	i4=224;
	r2=dm(1,i4);
	r4=-2097153;
	r2=r2 and r4;
	dm(1,i4)=r2;
	.ln	202;
	i4=224;
	r2=dm(1,i4);
	r4=524288;
	r2=r2 or r4;
	dm(1,i4)=r2;
	.ln	203;
	i4=224;
	r2=dm(1,i4);
	r4=262144;
	r2=r2 or r4;
	dm(1,i4)=r2;
	.ln	204;
	i4=224;
	r2=dm(1,i4);
	r4=-131073;
	r2=r2 and r4;
	dm(1,i4)=r2;
	.ln	205;
	i4=224;
	r2=dm(1,i4);
	r4=-65537;
	r2=r2 and r4;
	dm(1,i4)=r2;
	.ln	206;
	i4=224;
	r2=dm(1,i4);
	r4=-16385;
	r2=r2 and r4;
	dm(1,i4)=r2;
	.ln	207;
	i4=224;
	r2=dm(1,i4);
	r4=-8193;
	r2=r2 and r4;
	dm(1,i4)=r2;
	.ln	208;
	i4=224;
	r2=dm(1,i4);
	r4=-4097;
	r2=r2 and r4;
	dm(1,i4)=r2;
	.ln	209;
	i4=224;
	r2=dm(1,i4);
	r4=-2049;
	r2=r2 and r4;
	dm(1,i4)=r2;
	.ln	210;
	i4=224;
	r2=dm(1,i4);
	r4=-1025;
	r2=r2 and r4;
	dm(1,i4)=r2;
	.ln	211;
	i4=224;
	r2=dm(1,i4);
	r4=-513;
	r2=r2 and r4;
	dm(1,i4)=r2;
	.ln	212;
	i4=224;
	r2=dm(1,i4);
	r4=15;
	r8=-497;
	r8=r2 and r8;
	r8=r8 or fdep r4 by 4:5;
	r2=r8;
	dm(1,i4)=r2;
	.ln	213;
	i4=224;
	r2=dm(1,i4);
	r4=-9;
	r2=r2 and r4;
	dm(1,i4)=r2;
	.ln	214;
	i4=224;
	r2=dm(1,i4);
	r4=m6;
	r8=-7;
	r8=r2 and r8;
	r8=r8 or fdep r4 by 1:2;
	r2=r8;
	dm(1,i4)=r2;
	.ln	215;
	i4=224;
	r2=dm(1,i4);
	r4=-2;
	r2=r2 and r4;
	dm(1,i4)=r2;
	.ln	218;
	r8=_it_dma_receive;
	r4=10;
	cjump (pc, _interrupt) (DB);!.call
	dm(i7,m7)=r2;
	dm(i7,m7)=pc;
	.ln	221;
	r8=_it_dma_transmit;
	r4=12;
	cjump (pc, _interrupt) (DB);!.call
	dm(i7,m7)=r2;
	dm(i7,m7)=pc;
	.ln	226;
	r2=_tx_buf;
	dm(_tx_tcb+8)=r2;
	.ln	227;
	r2=_tx_tcb+8;
	dm(_tx_tcb+5)=r2;
	.ln	229;
	r2=_tx_tcb+8;
	r4=r2;
	r2=r4;
	r4=196608;
	r2=r2 or r4;
	dm(115)=r2;
	.ln	241;
	r2=_rx_buf;
	dm(_rx_tcb+8)=r2;
	.ln	242;
	r2=_rx_tcb+8;
	dm(_rx_tcb+5)=r2;
	.ln	244;
	r2=_rx_tcb+8;
	r4=r2;
	r2=r4;
	r4=196608;
	r2=r2 or r4;
	dm(99)=r2;
	.ln	255;
_L$12:
	.def	.ef;	.val	.;	.scl	101;	.line	255;	.endef;
!	FUNCTION EPILOGUE: 
	i12=dm(-1,i6);
	jump (m14,i12) (DB);!.return
	nop;
	RFRAME;
	.def	_init_sport0;	.val	.;	.scl	-1;	.endef;
.extern	_idle;
	.def	_init_codec;	.val	_init_codec;	.scl	2;	.type	041;	.endef;
.global	_init_codec;
_init_codec:
!	FUNCTION PROLOGUE: init_codec
!	rtrts protocol, params in registers, DM stack, doubles are floats
	.def end_prologue;	.val	.;	.scl	109;	.endef;
	.def	.bf;	.val	.;	.scl	101;	.line	261;	.endef;
	.ln	262;
	r2=_regs_1847;
	dm(_tx_ptr)=r2;
	.ln	263;
	r2=16;
	dm(_tx_compteur)=r2;
	.ln	266;
_L$16:
	r2=dm(_tx_compteur);
	r2=pass r2;
	if eq jump (pc, _L$17) ;
	.ln	267;
	cjump (pc, _idle) (DB);!.call
	dm(i7,m7)=r2;
	dm(i7,m7)=pc;
	jump (pc, _L$16) ;
_L$17:
	.ln	275;
_L$18:
	r2=dm(_rx_buf);
	r4=2;
	r2=r2 and r4;
	r2=pass r2;
	if ne jump (pc, _L$19) ;
	.ln	276;
	cjump (pc, _idle) (DB);!.call
	dm(i7,m7)=r2;
	dm(i7,m7)=pc;
	jump (pc, _L$18) ;
_L$19:
	.ln	278;
_L$20:
	r2=dm(_rx_buf);
	r4=2;
	r2=r2 and r4;
	r2=pass r2;
	if eq jump (pc, _L$21) ;
	.ln	279;
	cjump (pc, _idle) (DB);!.call
	dm(i7,m7)=r2;
	dm(i7,m7)=pc;
	jump (pc, _L$20) ;
_L$21:
	.ln	280;
_L$15:
	.def	.ef;	.val	.;	.scl	101;	.line	280;	.endef;
!	FUNCTION EPILOGUE: 
	i12=dm(-1,i6);
	jump (m14,i12) (DB);!.return
	nop;
	RFRAME;
	.def	_init_codec;	.val	.;	.scl	-1;	.endef;
	.def	_main;	.val	_main;	.scl	2;	.type	041;	.endef;
.global	_main;
_main:
!	FUNCTION PROLOGUE: main
!	rtrts protocol, params in registers, DM stack, doubles are floats
.extern	_exit;
	modify(i7,-2);
!	saving registers: 
	.def end_prologue;	.val	.;	.scl	109;	.endef;
	.def	.bf;	.val	.;	.scl	101;	.line	288;	.endef;
	.ln	289;
	.def	.bb;	.val	.;	.scl	100;	.line	2;	.endef;
	.def	_i;	.val	-2;	.scl	1;	.type	04;	.endef;
	.ln	291;
	cjump (pc, _init_dsp) (DB);!.call
	dm(i7,m7)=r2;
	dm(i7,m7)=pc;
	.ln	294;
	r8=m6;
	r4=0;
	cjump (pc, _set_flag) (DB);!.call
	dm(i7,m7)=r2;
	dm(i7,m7)=pc;
	.ln	295;
	r2=0;
	dm(-2,i6)=r2;
_L$26:
	r2=dm(-2,i6);
	r4=65534;
	comp(r2,r4);
	if gt jump (pc, _L$27) ;
_L$28:
	r2=dm(-2,i6);
	r4=r2+1;
	r2=r4;
	dm(-2,i6)=r2;
	jump (pc, _L$26) ;
_L$27:
	.ln	296;
	r8=0;
	r4=0;
	cjump (pc, _set_flag) (DB);!.call
	dm(i7,m7)=r2;
	dm(i7,m7)=pc;
	.ln	299;
	cjump (pc, _init_sport0) (DB);!.call
	dm(i7,m7)=r2;
	dm(i7,m7)=pc;
	.ln	303;
	cjump (pc, _init_codec) (DB);!.call
	dm(i7,m7)=r2;
	dm(i7,m7)=pc;
	.ln	306;
	.def	.bb;	.val	.;	.scl	100;	.line	19;	.endef;
	.def	___temp_ret;	.val	-3;	.scl	1;	.type	04;	.endef;
	
	BIT SET MODE2 32;
	r12=TCOUNT;
	dm(-3,i6)=r12;
	.def	.eb;	.val	.;	.scl	100;	.line	19;	.endef;
_L$29:
	.ln	310;
	jump (pc, _L$29) ;
_L$30:
	.ln	312;
	.def	.eb;	.val	.;	.scl	100;	.line	25;	.endef;
_L$25:
	.def	.ef;	.val	.;	.scl	101;	.line	312;	.endef;
!	FUNCTION EPILOGUE: 
	i12=dm(-1,i6);
	jump (PC, _exit) (DB);!.return_main
	i7=i6;
	i6=dm(0,i6);
	.def	_main;	.val	.;	.scl	-1;	.endef;
	.def	_regs_1847;	.val	_regs_1847;	.scl	2;	.dim	16;	.size	16;	.type	064;	.endef;
	.def	_rx_buf;	.val	_rx_buf;	.scl	2;	.dim	3;	.size	3;	.type	064;	.endef;
.endseg;
.segment /dm seg_dmda;

.global _rx_buf; .var	_rx_buf[3];
.endseg;
.segment /pm seg_pmco;

	.def	_tx_buf;	.val	_tx_buf;	.scl	2;	.dim	3;	.size	3;	.type	064;	.endef;
	.def	_rx_tcb;	.val	_rx_tcb;	.scl	2;	.tag	__0fake;	.size	9;	.type	010;	.endef;
	.def	_tx_tcb;	.val	_tx_tcb;	.scl	2;	.tag	__0fake;	.size	9;	.type	010;	.endef;
	.def	_tx_ptr;	.val	_tx_ptr;	.scl	2;	.type	024;	.endef;
.endseg;
.segment /dm seg_dmda;

.global _tx_ptr; .var	_tx_ptr;
.endseg;
.segment /pm seg_pmco;

	.def	_tx_compteur;	.val	_tx_compteur;	.scl	2;	.type	04;	.endef;
.endseg;
.segment /dm seg_dmda;

.global _tx_compteur; .var	_tx_compteur;
.endseg;
