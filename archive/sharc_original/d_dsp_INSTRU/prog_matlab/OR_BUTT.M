% exemple de détermination de l'ordre d'un filtre
% de Butterworth passe-bas avec pas plus de 3 dB
% d'atténuation jusqu'à 100 Hz et au moins 20 dB
% d'atténuation à 150 Hz ...
echo off
% échantillonnage à 1000Hz
fe=1000;


% les fréquences normalisées
% fréquence de coupure
fc=100/(fe/2);

% et le 150 Hz
fs=150/(fe/2);

% récuperation de l'ordre minimal : BUTTORD
[N,fn]=buttord(fc,fs,3,20);

pause
% lancement de la synthèse ... : fonction butter

[b,a] = butter(N, fn);

% réponse complexe en fréquence  du filtre correspondant ( n=256 points ):
n=256;
[h,w] = freqz(b,a,n);

% module en dB
h = 20*log10(abs(h));

% et son affichage
% échelle en fréquence dénormalisée
f=w*(fe/2)/pi;

figure(1)
plot(f,h)
