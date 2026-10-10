% analyse 3D de la résolution fréquentielle par FFT
% Fe=fréquence d'échantillonnage
% N=nombre d'échantillons
% la fft calcule une fréquence tous les Fe/N Hz
% signal analysé : sinusoïdal à la fréquence F

% dans le cas où F=kFe/N le pouvoir séparateur est 2Fe/N

% mais si F n'est pas un multiple de Fe/N, à cause de 
% la fenêtre d'observation ( ici rectangulaire ), on a 
% un élargissement des raies du spectre ( une multiplication
% par une fenêtre echantillonnée dans le domaine temporel, se traduisant
% en fréquentiel par la convolution avec la TF de la fenêtre)
% ici on convole avec une raie, ce qui revient à centrer
% la TF de la fenêtre sur la raie 

% Rem : on peut cependant augmenter la précision 
% de l'affichage du spectre en faisant un remplissage
% par des Zéros ( zero padding ) : on rajoute des 0
% à la séquence à analyser pour atteindre une longueur
% L ( L est une puissance de 2 ) 
% ( L-N zéros rajouter ), ce qui revient à calculer
% la FFT tous les Fe/L et donc d'avoir plus de fréquences
% à afficher 

% ici on va visualiser en 3 dimensions, l'évolution du spectre
% de la somme de 2 sinusoïdes de fréquences F1 et F2 qui ont
% tendance à se rapprocher 
% F1 varie de 30Hz à 32Hz et F2 de 35Hz à 33Hz

% on remarquera qu'on distingue F1 et F2 tant que celles-ci sont
% distantes de plus de 2Fe/N. Ensuite les raies se rejoignent
% Notons également une fluctuation de l'amplitude des raies
% lorsque la condition F(1 ou 2) = kFe/N n'est pas réalisée


echo off

% effacement de toutes les variables et figures
clear;
clg;

N=128; % 128 échnatillons
n=0:N-1;
Fe=128; % echantillonnage à 128 Hz 
A=1; % amplitude des sinusoïdes

F1b=30;
F1h=32;
F2b=33;
F2h=35;

NS=20; %nombre de spectres visualisés

% création de 3 matrices vides NS*N 

X1=zeros(NS,N); % pour les NS séquences temporelles à F1
X2=zeros(NS,N); % pour les NS séquences temporelles à F2
spectres=zeros(NS,N); % pour les NS spectres de X1+X2

% remplissage des séquences temporelles
% ici chaque ligne correspond à un deltaF1=2/20=0,1Hz
i=1; % indice de ligne
for f=F1b:(F1h-F1b)/NS:F1h;
X1(i,1:N)=A*sin(2*pi*f*n/Fe);
i=i+1;
end

% visualisation
% plot(X1(1,1:N));

i=1; % indice de ligne
for f=F2h:(F2b-F2h)/NS:F2b;
X2(i,1:N)=A*sin(2*pi*f*n/Fe);
i=i+1;
end


% la somme des sinusoïdes
X3=X1+X2;

% remplissage des NS spectres de X3
for i=1:NS;
spectres(i,1:N)=abs(fft(X3(i,1:N)));
end

% tracé en 3D
% zoom sur la région intéressante
% si on ne fait pas cela on récupère aussi les fréquences
% Fe-F1 et Fe-F2 ( repliement spectral
zoom_spect=spectres(1:NS,27:38);
% l'indice 1 de l'axe des fréquences vaut donc 24 Hz !!!

subplot(211);
mesh(zoom_spect)
xlabel('Fréquence');
ylabel('Ecart entre F1 et F2');
zlabel('Amplitude');


subplot(212);
mesh(zoom_spect);
xlabel('Fréquence');
ylabel('Ecart entre F1 et F2');
zlabel('Amplitude');
view(45,45);

% Notons également qu'il existe d'autres fenêtres que
% la rectangulaire qui permettent d'améliorer les résolutions
% - fréquentielle ( capacité de distinguer 2 raies de
% même hauteur très proches : dépend de la largeur du lobe central de la
% TF de la fenêtre qui élargit les raies )
% - et en amplitude ( capacité à repérer une raie proche d'une autre dont
% l'amplitude est plus faible : dépend du rapport entre les
% amplitudes du lobe principal et du premier lobe secondaire, la
% raie plus faible pouvant être masquée par le lobe secondaire
% de la plus grande )

% quelques données relatives à cela pour quelques fenêtres courantes :

%	Fenêtre		Largeur du	Atténuation du	Décroissance des
%			lobe principal	premier lobe	lobes secondaires
%					secondaire
%					(dB)		(dB/octave)
%	Rectangulaire	2Fe/N		-13		-6
%	Hamming		4Fe/N		-43		-6
%	Blackman	6Fe/N		-58		-18
%	Kaiser		env 4Fe/N	-37		-6

% Le choix de la fenêtre de pondération est donc à faire avec soin 
% en fonction de la résolution en fréquence et de la dynamique
% en amplitude désirée !!!

