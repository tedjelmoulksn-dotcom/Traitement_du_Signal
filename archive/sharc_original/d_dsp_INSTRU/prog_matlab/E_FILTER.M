% exemple de détermination de la réponse impulsionnelle 
% d'un filtre de Butterworth passe-bande [100Hz, 200Hz]
% d'ordre 5

echo off
% échantillonnage à 1000Hz
fe=1000;


% les fréquences normalisées
% bande passante
fn=[100 200]/(fe/2);

% lancement de la synthèse ... : fonction butter

[b,a] = butter(5, fn);

% réponse impulsionnelle
% sequence x(t) en entrée
x=[1 zeros(1,100)];

% sequence y(t) en sortie par la fonction FILTER

y=filter(b,a,x);

% affichage

stem(y)
% ou plot(y,'o')
