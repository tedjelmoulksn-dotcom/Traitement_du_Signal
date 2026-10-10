% exemple d'analyse d'un filtre prototype analogique de Cauer ( elliptique )
echo off
N=input ( 'Ordre du filtre ? :');

% ondulation bande passante en dB
Rp=input('ondulation bande passante en dB ?:');

% atténuation bande coupée en dB
Rs=input('atténuation bande coupée en dB ?:');

% récuperation des caractéristiques (zeros, pôkles et gain ) du filtre
[z,p,k]=ellipap(N,Rp,Rs);

% échelle des frequences
w=logspace(-1,1);

% réponse en frequence
% poly permet de reconstruire un polynôme 
% à partir de ses racines

h=freqs(k*poly(z),poly(p),w);

% tracé de la réponse
loglog(w,abs(h))

% ondulation dans la bande passante et coupée
% présence de zéros de transmission
% zone de transistion entre bande passante et coupée minimale

