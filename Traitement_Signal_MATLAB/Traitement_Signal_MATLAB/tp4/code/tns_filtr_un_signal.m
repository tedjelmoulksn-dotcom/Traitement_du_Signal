%%qst 10
%genreation du signal 
data=load('signalbase.mat')% load
field_existant=fieldnames(data) % cherhcer les field
xn= data.(field_existant{1}) % attribuer le premier field a la variable sn
size(xn)
yn=zeros(1,250);
% generation du bruit blanc centree
sigma=1/2 ;     %bruir gaussien de de ecarttype sigma
bruit=sigma*randn(1, 250);
yn= xn + bruit;
Ps = mean(xn.^2); % ppuissance du signal
Pb = mean(bruit.^2); % puissance du bruit
RSB = 10 * log10(Ps / Pb); % RSB en Db
plot(xn, 'b', 'LineWidth', 1.5);
hold on; % Signal original
plot(yn, 'r', 'LineWidth', 1); % Signal bruité
title(sprintf('Sigma = %.2f, RSB = %.2f dB', sigma, RSB));
xlabel('Échantillons');
ylabel('Amplitude');
legend('Signal original', 'Signal bruité');
fprintf('Sigma = %.2f, RSB = %.2f dB\n', sigma, RSB);

%%qst 11
%affichage des dsp
%dsp de x
X=fft(xn);
X_shifted=fftshift(X);
fe=25; %jsp pk
Te=1/fe;
N=length(xn);
t=(0 : N-1) * Te ; %vecteur temp de xn
f=linspace( -fe/2 ,fe/2, N ); % pour cree un vecteru de lonngeur N 
size(f)
DSP_X= abs(X_shifted).^2/N;
%dsp du bruit
B=fft(bruit);
B_shifted=fftshift(B);
DSP_B= abs(B_shifted).^2/N;
%affichage des dsp 
figure(2)
semilogy(f,DSP_X,'b');% plot en log
hold on;
semilogy(f,DSP_B,'g');
xlabel('frequence')
ylabel('DSP')
%%qst 13
%la rep en freq de ce filtre 
%parametre
p=4 ; %longeur
fs=1000; %freq dechantillonnage du filtre moyuenneur
h=ones(1,p)/p;
n=2048; %resolutio
%rep fre
[H ,f]=freqz(h,1,n, fs);
%affichage 

figure(3);
subplot(2,1,1);
plot(f , abs(H))
title('Module de la reponse en frequence');
xlabel('frequence (Hz)');
ylabel('|H(f)|')
hold on 
%phase 
subplot(2,1,2);
plot(f,angle(H))
title('Phase de la reponse en freaquennce');
xlabel('Frequence Hz');
ylabel('phase en radian');


%%qst 14
%sortie du filtre 
% yn_filtered = conv(yn, h, 'same'); % Appliquer le filtre au signal bruité
% %affichage de la sortie
%autre methode 
B=ones(1,p);
B=1/p*B;
yn_filtered = filter(B, 1, yn); % Appliquer le filtre au signal bruité

figure(4)
plot(xn, 'b', 'LineWidth', 1.5);
hold on; % Signal original
plot(yn, 'r', 'LineWidth', 1); % Signal bruité
hold on; 
plot(yn_filtered, 'g', 'LineWidth', 1.5); % Signal filtré
title('Filtrage du signal bruité');
xlabel('Échantillons');
ylabel('Amplitude');
legend('Signal original', 'Signal bruité', 'Signal filtré');


%suite question 14
a1=1;
a2=0.8;

%coeff de hn :
%b=[1 a2];
%a=[1];
%calcul des coeff 
%N=2;%nombe de coeff a calculer 
%h_num = impz(b,a,N) % la rep impulssionelle 
%n=0 : N-1;

%question 20:
%a2= 0.2 ;% doit etre onfereur a 1
%a1=1-a2;

%%qst 22 
%maintenant on va filtrer yn (signal bruite) en utilisant ce filtre sous les condtion choisie 
%on cree les vecteur a et b , vecteur denomin , et vecteur nomina 

%question 20:
a2=0.3;
a1=1+a2;

% z= zeros(size(yn)); % on va cree le signal de sortie du filtre zn 
% for n= 2:length(yn) %comme ca jaurai le signal de 0 jusqua 249
%     z(n)=g * ((a2*z(n-1) + yn(n))/a1); % apparment c le filtrage recursif avce a1 =1
% end
A=[a1 -a2]
% autre methode :
z = filter(1, A, yn); % Appliquer le filtre au signal bruité

%affichage 
figure(5)
plot(xn, 'b', 'LineWidth', 1.5);
hold on; % Signal original
plot(yn, 'r', 'LineWidth', 1); % Signal bruité
hold on; 
plot(z, 'g', 'LineWidth', 1.5); % Signal filtré
title('Filtrage du signal bruité');
xlabel('Échantillons');
ylabel('Amplitude');
legend('Signal original', 'Signal bruité', 'Signal filtré');

%% qst22 
%visualisaio de la rep freq de ce filtre 
%la rep en freq de ce filtre 
%parametre
%coeff de hn 
b=[a2]; % coeff de num
a=[a1, -a2]; % coeff de denum

fs=1000; %freq dechantillonnage du filtre moyuenneur

n=2048; %resolutio
%rep fre
[Hii ,f]=freqz(b,a,n,fs);
%affichage 

figure(6);
subplot(2,1,1);
plot(f , abs(Hii))
title('Module de la reponse en frequence');
xlabel('frequence (Hz)');
ylabel('|H(f)|')
hold on 
%phase 
subplot(2,1,2);
plot(f,angle(Hii))
title('Phase de la reponse en freaquennce');
xlabel('Frequence Hz');
ylabel('phase en radian');





