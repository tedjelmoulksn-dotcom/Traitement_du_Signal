%genreation du signal 
data=load('signalbase.mat')% load
field_existant=fieldnames(data) % cherhcer les field
xn= data.(field_existant{1}) % attribuer le premier field a la variable sn
size(xn)
N = length(xn); % Taille du signal
fe = 1000; % Fréquence d'échantillonnage (1 kHz)
t = (0:N-1) / fe; % Échelle temporelle (en secondes)

% Génération de la perturbation sinusoïdale
freq_sin = 50; % Fréquence de la sinusoïde en Hz
amplitude_sin = 1.2; % Amplitude de la sinusoïde
perturbation = amplitude_sin * sin(2 * pi * freq_sin * t);
xn_perturbe=xn+perturbation;
yn=zeros(1,250);
% generation du bruit blanc centree
sigma=sqrt(1/2) ;     %bruir gaussien de variance 0.5
bruit=sigma*randn(1, 250);
yn= xn_perturbe + bruit;

% Affichage
figure(1);
plot(xn_perturbe, 'b', 'LineWidth', 1); 
hold on;
plot(yn, 'r', 'LineWidth', 1.5);

%visualiser la dsp 

Yn=fft(yn);
Yn_shifted=fftshift(Yn);
f=linspace( -fe/2 ,fe/2, N ); % pour cree un vecteru de lonngeur N 
size(f);
DSP= abs(Yn_shifted).^2/N;
%affichage 
figure (2);
semilogy(f,DSP);% plot en log
xlabel('frequence')
ylabel('DSP de yn')

% Paramètres du filtre coupe-bande
fe = 1000; % Fréquence d'échantillonnage (1 kHz)
fnyquist = fe / 2; % Fréquence de Nyquist
fcoupe_basse = 45; % Fréquence basse de coupure (45 Hz)
fcoupe_haute = 55; % Fréquence haute de coupure (55 Hz)
Wn = [fcoupe_basse, fcoupe_haute] / fnyquist; % Fréquences normalisées

% Conception du filtre coupe-bande
ordre = 2; % Ordre initial du filtre
b = fir1(ordre, Wn, 'stop', hann(ordre + 1)); % 'stop' pour un filtre coupe-bande

% Vérification du gabarit avec freqz
figure(3);
freqz(b, 1, 1024, fe); % Afficher la réponse en fréquence
title('Réponse en fréquence du filtre coupe-bande');
grid on;

%% Affichage des coefficients du filtre
disp('Coefficients du filtre RIF :');
disp(b);
%%filtrage 
yn_cp = filter(b,1,yn) ;
%%affichage 
figure(4);
plot(yn, 'r', 'LineWidth', 1); 
hold on;
plot(yn_cp, 'b', 'LineWidth', 1.5);
hold on ;
% Affichage de la réponse en fréquence
title(sprintf('Filtrage rif dordre %d ', ordre));
xlabel('Échantillons');
ylabel('Amplitude');
legend('Signal bruité', 'Signal filtré');