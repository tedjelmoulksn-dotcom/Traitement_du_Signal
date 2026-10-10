a=2; 
f0=50; 
fe=500;
Te=1/fe;
phi=pi/2;
N=1; %% lenombre dechantlions pour la duree 3
t=(0:N-1)*Te; %le t de chaque echantillons
xn=a*sin(2*pi*f0*t+phi);
sigma=sqrt(0.3);
bn= sigma*randn(1,N) %bruit
yn=xn+bn;
Y=fft(yn);
Y_shifted= fftshift(Y);
f=(-N/2 : N/2-1)*(fe/N);
DSP_Y=((abs(Y_shifted).^2)/N;
figure(1);
plot(f,DSP_Y)

figure(1)
plot(xn);
hold;
%%on va calcuuler la tfd de xn
Xf=fft(xn);
f=(0:N-1)*(fe/N);%% la freq de chaque echantillon

% on appliuqe la formule 
Sx=(abs(Xf).^2)/N
%affichage 
size(f)
size(Sx)
figure(2);
plot(f,Sx);% je veux que le sfreq positive 


