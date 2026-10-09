%%filtre passe bas 
%genreation du signal 
data=load('signalbase.mat')% load
field_existant=fieldnames(data) % cherhcer les field
xn= data.(field_existant{1}) % attribuer le premier field a la variable sn
size(xn)
yn=zeros(1,250);
% generation du bruit blanc centree
sigma=sqrt(1/2) ;     %bruir gaussien de variance 0.5
bruit=sigma*randn(1, 250);
yn= xn + bruit;
fe=1000;%freq d'echantillonnage egale a 1Khz
%%V.b filtre passe bas 

% Paramètres
fc = 500; % Fréquence de coupure en Hz
N = length(yn); % Longueur du signal
f = linspace(-fe/2, fe/2, N); % Échelle fréquentielle

% Transformée de Fourier du signal bruité
Y = fftshift(fft(yn));

% Masque fréquentiel (filtre passe-bas idéal)
masque = abs(f) <= fc; % 1 si |f| <= fc, 0 sinon

% Filtrage dans le domaine fréquentiel
Y_filtre = Y .* masque;

% Retour au domaine temporel
yn_filtre = ifft(ifftshift(Y_filtre), 'symmetric'); % Filtrage en temporel

% Affichage
figure(2);
plot(yn, 'r', 'LineWidth', 1); 
hold on;
plot(yn_filtre, 'b', 'LineWidth', 1.5);
title(sprintf('Filtrage passe-bas idéal avec fc = %d Hz', fc));
xlabel('Échantillons');
ylabel('Amplitude');
legend('Signal bruité', 'Signal filtré');