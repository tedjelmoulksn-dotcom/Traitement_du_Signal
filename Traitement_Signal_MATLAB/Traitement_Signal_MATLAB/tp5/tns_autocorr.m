a=2; 
f0=50; 
phi= pi/2;

fe=500;
Te=1/fe;
N=fe; %% lenombre dechantlions pour la duree 3

t=(0:N-1)* Te; %le t de chaque echantillons
xn=a*sin(2*pi*f0*t+phi);
sigma=sqrt(5);
bn=sigma*randn(1,N); %bruir gaussien
yn= xn+bn;
%autocorrelation de chcaun des signaux avrc un ecart de L=40;
L=40;
[Cb,L]=xcorr(bn); %%autocorel avec une delimitation maxlag=L
[Cxn,L]=xcorr(xn);
[Cyn,L]=xcorr(yn);
figure(1)
stem(L,Cb,'r')
hold on;
stem(L,Cxn,'b')
hold on;
stem(L,Cyn,'g');
xlabel ('ecart');
ylabel('autocorrelation');