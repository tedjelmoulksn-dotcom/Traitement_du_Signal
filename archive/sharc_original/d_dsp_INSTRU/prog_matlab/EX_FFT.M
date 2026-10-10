% exemple d'analyse spectrale sur signal pur
% utilisation de la FFT
echo off
fs=1000 ;% échantillonnage à 1000Hz 

% base de temps
t=0:0.001:.5; % t de 0 à 500ms par pas de 1 ms

% signal étudié : sinusoidal à 100 Hz
x = sin(2*pi*100*t); 

% avec du bruit en plus 
x = x + .5*randn(size(t));

% visualisations
figure(1)
plot(t(1:50),x(1:50))
title('signal x(t)');
pause

% calcule la FFT
X = fft(x,256);

% la densité spectrale de puissanse vaut

%Sx = X.*conj(X)/length(X);
Sx=abs(X)/length(X);
% axe des fréquences : 128 premières fréquences car X est
% symétrique par rapport à la fréquence de Nyquist (X(129))
% X(1) est la composante continue de x(t)

f = fs/(2*128)*(0:127);

% tracé du spectre
figure(2)
plot(f,Sx(1:128))
% en Db
% semilogy(f,Sx(1:128))
title('Spectre');
xlabel('Frequence (Hz)')

pause
% soit en zoomant

plot(f(1:50),Sx(1:50))
