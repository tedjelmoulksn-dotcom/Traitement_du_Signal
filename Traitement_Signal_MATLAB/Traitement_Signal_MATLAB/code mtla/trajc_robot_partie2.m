%deuxieme partie de sum
x = [7.5 3.8 6.5 9.5 5.7 8.4 2.7 6.2 5.8 9.6]
y = [0.8 5.0 5.2 0.9 9.0 8.8 4.3 7.8 1.4 6.1]

plot(x,y,'Color','r','Linestyle','--')

hold on;
scatter(7.5,0.8,'x','b');
%jai cree une matrice ou la premeier ligne represente lerreur des abscise
%et la deuxieme ligne represente lerreur des abscisse
e = [ x(2 :1 : 10 )- x(1: 1  :  9) ;  y(2 :1 : 10 )- y(1: 1  :  9) ] 
%on utlise la formule x^2+y^2=rayon^2 pour trouver le rayon a chaque fois
rayon= sqrt ((e(1 , 1 : end)).^2 + (e(2 , 1 : end )).^2)
%on met des cercles vertes
scatter(x(2:end),y(2:end),rayon*10,'g')
%jai limpression que lescedrcles ont le meme rayon

%figure;
t=0:9;
%plot(t,x,'r');
%hold on;
ppx = spline (t,x);%ppx est une fonction polynnomiale de degre 3 par morceuax
%pour connaitre sa valeur a instant donne t 
v= ppval (ppx , 1.5);
t_prime= 0: 0.01 : 9;
vx= ppval (ppx , t_prime);
hold on;
%plot (t_prime, vx , 'k');

%qstion
ppy=spline(t,y);%je fais une interopolation par morceau pour chcun de t par y
vy=ppval(ppy, t_prime );
%plot( t_prime , vy, 'b');
plot(vx , vy ,'Color','b');
%pour lespositions intermediaires sur le grapjhe d'origine et obtenir une
%trajectoir interpole 