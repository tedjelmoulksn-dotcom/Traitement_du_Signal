%%chpsir un motif a envoye  ete tudier la correlation de celui la 
%m=randn(1,50); %% bruit blanc
%m=sin(2*pi*(1:50)*0.1) %sinusoidie pur
m=sin(2*pi*(1:50)*0.1).*exp(-(-24:25).^2/10^2);
L=40;
[Cm,L]=xcorr(m);
figure(1)
stem(L,Cm,'r');
%cree un signal recu r vide delongeur 300
r=zeros(1,300);
%% mettre les cibles a 3 position
r(50:50 + length(m)-1)=m; %% pourv lavoir sur une plage de 50 indices
r(100:100 +length(m)-1)=m; %%
r(200:200 +length(m)-1)=m;
%% on rajoute un bruit blanc 
sigma=sqrt(2);     %bruir gaussien de de variance sigma
bruit=sigma*randn(1, 300);
r = r + bruit;
figure(5);
%plot(r)
[Cr,L]=xcorr(r,m);
figure(3)
%% trouver les decalage positive pour les afficher 
decalage_positif = find(L >= 0); % Trouver les indices pour les décalages positifs
stem(L(decalage_positif), Cr(decalage_positif), 'b'); % Afficher uniquement les décalages positive
%% calcul de la dse

DSE=abs(fft(Cr));
f = (0:length(DSE)-1)/length(DSE);
plot(f,Cr,'b')
hold on ;
[pxx,f] = periodogram(r);
plot(f, pxx,'r');