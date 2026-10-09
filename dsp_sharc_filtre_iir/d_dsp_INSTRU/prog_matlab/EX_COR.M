% exemple de calcul de la fonction d'autocorrélation

echo off
fs=1000 ;% échantillonnage à 1000Hz 

% base de temps
t=0:0.001:0.499; % t de 0 à 499 ms par pas de 1 ms

% signal étudié : sinusoidal à 100 Hz
x = 5*square(2*pi*100*t); 

%x = 3*sin(2*pi*100*t); 

% avec du bruit en plus 
%x = x + .5*randn(size(t));
a=3;
%x = a*randn(size(t)); % loi normale Pm=a^2
%x = a*rand(size(t)); % loi uniforme Pm=a^2/12
% visualisations
figure(1)
plot(t(1:50),x(1:50))
title('signal x(t)');
pause

% calcule de la fonction d'autocorrélation Rxx
Rxx = xcorr(x);
m=length(x);
Rxx=Rxx/m;

pause

% et l'affiche :

% nombre de points à afficher
pts=m/2;
plot(t(1:pts),Rxx(m:m+pts-1));
title ('Fonction d''Autocorrélation');

pause

% on retrouve la puissance moyenne Pm par Rxx(m):
Pm=Rxx(m)

pause

% la Transformée de Fourier de Rxx est la densité spectrale
% de puissance :

y=fft(Rxx,256);


Pxx=2*abs(y)/(length(x));

% axe des fréquences : 128 premières fréquences car X est
% symétrique par rapport à la fréquence de Nyquist (X(129))
% X(1) est la composante continue de x(t)

f = fs/(2*128)*(0:127);

% tracé du spectre de puissance
figure(2)
plot(f,Pxx(1:128))

title('Spectre de puissance');
xlabel('Frequence (Hz)')

pause

% REVOIR ICI CAR :
% OK EN SINUSOÏDAL
% OK EN CARRE : saut harmoniques en 1/n^2 au lieu de 1/n
% KO avec bruit normal ou uniforme !!!

% et de nouveau la puissance moyenne par 
c=sum(Pxx(1:128))*(fs/(2*256))

