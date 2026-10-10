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
fnyquist=fe/2;

% Paramètres
fc =0.4 * fnyquist ; % Fréquence de coupure en Hz
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
figure(1);
plot(yn, 'r', 'LineWidth', 1); 
hold on;
plot(yn_filtre, 'b', 'LineWidth', 1.5);
hold on ;
%plot(xn , 'g','LineWidth',1.5)
title(sprintf('Filtrage passe-bas idéal avec fc = %d Hz', fc));
xlabel('Échantillons');
ylabel('Amplitude');
legend('Signal bruité', 'Signal filtré');

%%V-7synthese du filtre
%frequence normalisee 
Wn = fc / fnyquist;
ordre=50; %ordre du filtre 
% Appliquer la fenêtre de Hamming
window = hann(4);
% Calculer les coefficients du filtre FIR
b = fir1(3, Wn, window);
% Afficher les coefficients du filtre
disp(b);
yn_rif = filter(b, 1, yn); 
%affichage 

% Affichage
figure(2);
plot(yn, 'r', 'LineWidth', 1); 
hold on;
plot(yn_rif, 'b', 'LineWidth', 1.5);
hold on ;
%plot(xn , 'g','LineWidth',1.5)
% Affichage de la réponse en fréquence
fvtool(b, 1);
title(sprintf('Filtrage rif dordre %d ', ordre));
xlabel('Échantillons');
ylabel('Amplitude');
legend('Signal bruité', 'Signal filtré');

% Affichage
figure(3);
plot(xn, 'g', 'LineWidth', 1); 
%%le rii

hold on;
plot(yn_rif, 'b', 'LineWidth', 1.5);
hold on ;
%plot(xn , 'g','LineWidth',1.5)
% Affichage de la réponse en fréquence
title(sprintf('Filtrage rif dordre %d ',ordre));
xlabel('Échantillons');
ylabel('Amplitude');
legend('Signal bruité', 'Signal filtré');
%%affichage  de fonction de transfert du filtrre 


%%afffichage de la fonction de transfert du filtre 
figure(4);
freqz(b, 1, 1024, fe);  % 1024 points pour une réponse fine, et fe pour la fréquence d'échantillonnage
title('Réponse en fréquence du filtre FIR');

%%
fc = 0.2 * fnyquist; % Fréquence de coupure (en Hz)
fa = 0.8 * fnyquist; % Fréquence d'atténuation (en Hz)

% Fréquences normalisées
Wp = fc / fnyquist; % Fréquence de coupure normalisée
Ws = fa / fnyquist; % Fréquence d'atténuation normalisée

% Critères de performances
Rp = 1; % Ondulation maximale en dB dans la bande passante
Rs = 40; % Atténuation minimale en dB dans la bande coupée

% Calcul de l'ordre optimal et de la fréquence de coupure
[n, Wn] = buttord(Wp, Ws, Rp, Rs);

%% Synthèse du filtre passe-bas
[b, a] = butter(n, Wn); % Calcul des coefficients du filtre

%% Application du filtre au signal bruité
yn_filtre_butter = filter(b, a, yn);

% Affichage
figure;
plot(yn, 'r', 'LineWidth', 1);
hold on;
plot(yn_filtre_butter, 'b', 'LineWidth', 1.5);
title(sprintf('Filtrage passe-bas Butterworth d''ordre %d', n));
xlabel('Échantillons');
ylabel('Amplitude');
legend('Signal bruité', 'Signal filtré');

% Réponse en fréquence du filtre
figure;
freqz(b, a, 1024, fe); % Réponse en fréquence
title('Réponse en fréquence du filtre Butterworth');