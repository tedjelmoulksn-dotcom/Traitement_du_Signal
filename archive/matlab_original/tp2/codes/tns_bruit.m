a=2; 
f0=50; 
phi= pi/2;

fe=500;
Te=1/fe;
N=fe; %% lenombre dechantlions pour la duree 3

t=(0:N-1)* Te; %le t de chaque echantillons
xn=a*sin(2*pi*f0*t+phi);
sigma=sqrt(0.3);
bn=sigma*randn(1,N); %bruir gaussien
yn= xn+bn;
%fft et fftshift pour y
Yf=fft(yn);
Y_shifted=fftshift(Yf);
f=(-N/2:N/2-1)*(fe/N);
DSP_Y=(abs(Y_shifted).^2)/N;
figure(3);
plot(f,Y_shifted);
xlabel('frequence')
ylabel('DSP de yn');
%%filtre 
taille_du_filtre=2;
mask=abs(f)>=(f0-taille_du_filtre) & abs(f) <=(f0+taille_du_filtre); %%def du masque 
Y_filtre=Y_shifted.*mask;

plot(f,Y_filtre)
xlabel('frequence')
ylabel('DSP filtree');
