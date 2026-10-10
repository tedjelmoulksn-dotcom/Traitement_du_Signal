clear all;close all;clc;
%r= zeros(1,10000);
%for i=1:10000
 %   lancer= 0;
  %% while somme<20
    %    somme= somme+randi(6,1);
       % lancer = lancer +1;
       %end
    %r(i)= lancer;
%end
%hist( r , 3:10);

%alea= randi (6 ,20,10^4)
%s= cumsum(alea);
%f= s>=20 %matrice de booleen
%[valeur_max , position_max]= max( f , [] , 1)
%r=position_max;
%hist(r , 3:18)
%xlim([3 10 ])
%partie 3
n= 0 : 100;%pour les entiers de 1 a100
u_n= (n-3) ./ (n+3); % pour les vameurs de ma suite 
%on veut tracer la valeur de la suite en fonction des valeursden en Rouge
plot (n, u_n , 'Color' , 'r')
const = ones (size(u_n))% on veut voir y=1
hold on ;
plot(n , const , 'Color', 'b' , 'LineStyle' , '--' ); 
%comme on vois pas bien la ligne bleu on va cree de la place 
ylim([-1.5 7]);
title ('la suite u(n) conerge ers 1');
xlabel('n');
ylabel('u(n)');
legend('u(n)' , 'valeur 1');
hold on;
v_n = (n+3) ./ (n-3);
plot(n , v_n , 'Color', 'g');
xlim([4 :20: 100]);
title ('la suite u(n)et vn conerge vers 1');
legend('u(n)' , 'valeur 1', 'v(n)');
hold on;
