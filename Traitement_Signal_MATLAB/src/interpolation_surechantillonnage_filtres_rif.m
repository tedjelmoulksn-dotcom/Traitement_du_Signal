%%premiere qst seace 3
data=load('signalbase.mat')% load
field_existant=fieldnames(data) % cherhcer les field
sn= data.(field_existant{1}) % attribuer le premier field a la variable sn
size(sn)
fe=25;
Te=1/fe;
N=length(sn);
t=(0 : N-1) * Te ; %vecteur temp de sn

S=fft(sn);
S_shifted=fftshift(S);
f=linspace( -fe/2 ,fe/2, N ); % pour cree un vecteru de lonngeur N 
size(f)
DSP= abs(S_shifted).^2/N;
figure (1);
semilogy(f,DSP);% plot en log
xlabel('frequence')
ylabel('DSP de sn')
%%2eme qst seace 3
t_target= 1.3 % temps d'interpol
%calculde lindice central
n_central = round(t_target /Te);%l'index le plus proche a mon target 
window_size= 10; %nb d'echatillons de chaque cote pour la troncature on peut modifier selon lallure 
%approxi en utilisant shannon
s_approxi=0;
for k= - window_size : window_size
    n= n_central + k ; %index actuel
    if n>0 && n<= N
        s_approxi=s_approxi+ sn(n) * sinc((t_target- (n-1)* Te)/ Te);
    end
end
fprintf('la valeur interpolee de s(%.1f) est aprooxi %.2f \n', t_target, s_approxi)
%%represetaio de vn 
t_target= 1.3 % temps d'interpol
%calculde lindice central
n_central = round(t_target /(Te/2));%l'index le plus proche a mon target 
window_size= 10; %nb d'echatillons de chaque cote pour la troncature on peut modifier selon lallure 
%approxi en utilisant shannon
v_approxi=0;
for k= - window_size : window_size
    n= n_central + k ; %index actuel
    if n>0 && n<= N
        v_approxi=v_approxi+ sn(n) * sinc((t_target- (n-1)* (Te/2))/ (Te/2));
    end
end
fprintf('la valeur interpolee de v(%.1f) est aprooxi %.2f \n', t_target, v_approxi)



%% Calcul et représentation de la DSP de v_n
% Création du signal v_n en intercalant des zéros
v_n = zeros(1, 2 * N); % Initialiser v_n avec des zéros
v_n(1:2:end) = sn; % Insérer les échantillons de sn dans v_n

% Calcul de la Transformée de Fourier de v_n
V = fft(v_n); % Transformée de Fourier
V_shifted = fftshift(V); % Déplacement du zéro au centre du spectre
f_v = linspace(-fe, fe, 2 * N); % Création d'un vecteur de fréquence de longueur 2*N
DSP_v = abs(V_shifted).^2 / (2 * N); % Densité Spectrale de Puissance

% Représentation de la DSP de v_n
figure(2);
semilogy(f_v, DSP_v); % Plot en échelle logarithmique
xlabel('Fréquence (Hz)');
ylabel('DSP de v_n');
title('DSP de v_n (signal avec intercalage de zéros)');


%% affichage de la repd du filtre% Calcul de la réponse en fréquence du filtre H1
H1 = [1, 1]; % Coefficients du filtre H1: y_n = v_n + v_(n-1)

% Réponse en fréquence du filtre
[H1_freq, f_H1] = freqz(H1, 1, 2048); % Fct donne la rep freq dun filtre digital ; on donne les coef du filtre et retournnne n pt rep freq enfct de omega 
magnitude_H1 = abs(H1_freq); % Magnitude
% Calcul de la fréquence de coupure
cutoff_level = max(magnitude_H1) / sqrt(2); % Niveau de coupure
cutoff_index = find(magnitude_H1 < cutoff_level, 1); % Index de coupure
cutoff_frequency = f_H1(cutoff_index); % Fréquence de coupure

% Visualisation de la réponse en fréquence du filtre
figure(5);
plot(f_H1, magnitude_H1); % Tracé de la magnitude
xlabel('Fréquence (Hz)');
ylabel('Magnitude');
title('Réponse en Fréquence du Filtre H1');
grid on;
hold on;
% Utiliser line pour dessiner la ligne de niveau de coupure
line(xlim, [cutoff_level cutoff_level], 'Color', 'r', 'LineStyle', '--', 'DisplayName', 'Fréquence de coupure');
% Ajouter une ligne verticale pour la fréquence de coupure
line([cutoff_frequency cutoff_frequency], ylim, 'Color', 'g', 'LineStyle', '--', 'DisplayName', ['f_c = ' num2str(cutoff_frequency) ' Hz']);

legend('show'); % Afficher la légende


% Affichage de la fréquence de coupure
disp(['Fréquence de coupure : ' num2str(cutoff_frequency) ' Hz']);
%%qst 9 filtrer vn

% y_n=zeros(1,2*N)
% 
% n=0;
% for n = 1 : N
%     y_n(n)= v_n(n)+v_n(n-1)
% end
% y_n
figure(6)
y_n= filter(H1,1,v_n); %filtrer v_n en utilisant H1
% visualisation
t_y=(0:length(y_n)-1) * (Te/2);
plot(t_y , y_n , 'b','Displayname', 'y_n filtre');
hold on ; % rajputer sn dans le meme plot 
plot(t, sn,'r--', 'Displayname' , 's_n');
title('y_n et s_n supperpose');

%%qst 11 ; la rep freq de h2
% Réponse en fréquence du filtre
H2 = [1,2,1]/2 ; %coeff du filtre h2
[H2_freq, f_H2] = freqz(H2, 1, 2048); % Fct donne la rep freq dun filtre digital ; on donne les coef du filtre et retournnne n pt rep freq enfct de omega 
magnitude_H2 = abs(H2_freq); % Magnitude
% Calcul de la fréquence de coupure
cutoff_level2 = max(magnitude_H2) / sqrt(2); % Niveau de coupure
cutoff_index2 = find(magnitude_H2 < cutoff_level2, 1); % Index de coupure
cutoff_frequency2 = f_H2(cutoff_index2); % Fréquence de coupure
%affichage 
figure(5);
plot(f_H2, magnitude_H2,'Color','y'); % Tracé de la magnitude
xlabel('Fréquence (Hz)');
ylabel('Magnitude');
title('Réponse en Fréquence du Filtre H1');
grid on;
hold on;
% Utiliser line pour dessiner la ligne de niveau de coupure
line(xlim, [cutoff_level2 cutoff_level2], 'Color', 'r', 'LineStyle', '--', 'DisplayName', 'Fréquence de coupure');
% Ajouter une ligne verticale pour la fréquence de coupure
line([cutoff_frequency2 cutoff_frequency2], ylim, 'Color', 'g', 'LineStyle', '--', 'DisplayName', ['f_c = ' num2str(cutoff_frequency2) ' Hz']);
legend('show'); % Afficher la légende
legend('H1','freq de coupure x','freq de coupure y' ,'H2','freq de coupure x','freq de coupure y')
hold off;
