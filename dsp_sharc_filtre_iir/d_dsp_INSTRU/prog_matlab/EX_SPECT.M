% exemple de tracé d'un spectre de puissance pour
% un signal carré : fonction SPECTRUM et SPECPLOT

echo off
fs=1000 ;% échantillonnage à 1000Hz 

% base de temps
t=0:(1/fs):1; % t de 0 à 1s par pas de 1 ms

% signal étudié : carré à 100 Hz
x = square(2*pi*100*t); 
%x = 5*sin(2*pi*100*t); 

% avec du bruit en plus 
%x = x + .5*randn(size(t));

%x = 2*randn(size(t)); %loi normale
%x = 2*rand(size(t)); %loi uniforme

% visualisations
figure(1)
plot(t(1:50),x(1:50))
title('signal x(t)');
pause

% calcule le spectre de puissance sur 256 points
P = spectrum(x,256);

% et l'affiche
specplot(P,fs)

pause

% calcul de la puissance moyenne totale Pm du signal
[m,n]=size(P);

Pm=sum(P(1:m))/m;

% que l'on peut obtenir aussi par la covariance :
c=cov(x)

% d'où la RMS de x(t) :
RMS=sqrt(Pm)
