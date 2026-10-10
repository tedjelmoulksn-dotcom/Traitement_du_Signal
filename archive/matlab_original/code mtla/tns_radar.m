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
sigma=sqrt(0.2);     %bruir gaussien de de variance sigma
bruit=sigma*randn(1, 300);
r = r + bruit;
figure(2);
[Crm,L]=xcorr(r,m);
figure(3)
stem(L,Crm,'r');
%%trouever les decalagepositif 
decalage_positif=find(L>=0);
plot(L(decalage_positif),Crm(decalage_positif), 'b');    %affocher uniquement les decalage positif

%verifie : la transforme de foureir de la fonction d'intercorr est la dse
[Cr,L]=xcorr(r,L);
DSE_via_fft=abs(fft(Cr)).^2;
f_fft=(0:length(DSE_via_fft)-1)/length(DSE_via_fft); %freq
DSE_via_r=abs(fft(r)).^2
f_r=(0:length(DSE_via_r)-1)/length(DSE_via_r); %freq
figure(4);
plot(f_fft,DSE_via_fft,'r')
hold on;
plot(f_r,DSE_via_r,'g')
