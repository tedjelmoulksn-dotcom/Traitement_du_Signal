clear all;close all;clc;

%A= [5 2 6 9 ; 8 6 1 3];
%A= find(A>3);
%M=A(find (A>3));
%z=numel(M);
%[ligne, colonne]=size(A)

%for i=1 : ligne
 %   for j=1:colonne 
  %  A(i,j)
 %   end
%end

%%exo partiel 2020/2021
%for N = 1 : 40 
%j1= randi(20,1000,5);
%j2= randi(20,1000,5);
%resultat = (j1+j2 > N | j1==j2);
%parties_gagnees_j2 = sum(resultat, 2) >=3;

%end
%sum(parties_gagnees_j2) %pour trouver  toutes les parties gagne
%prsnt= sum(parties_gagnees_j2)*100/1000 %les pa
%find( prsnt <60 & prsnt > 40) %pour chercher la valeur la plus proche de 50%
%k= numel(find (prsnt > 40 & prsnt < 60))
%add=sum(,1)

%if numel(add>25) > 3 | j1==j2 
 %   disp(' joueur 2 gagne ');
%else
 %   disp ('joueur 1 gage');
  %  i=i+1;
%end
%p= (i*100)/ 1000
    

%if numel> 25
 %   disp(' j1 gagne');
%elseif j1==j2 
 %   disp(' j2 gagne ');
%else
 %   disp(' j1 gagne');
%end


% ecrie un seul cosi simple
%pas=0.001;
%t= 0:pas:1-pas;
%x=cos ( 2*pi* 10 * t);
%plot(t,x)
A= [5 2 6 9 ; 8 6 1 3; 0 4 6 9]
fprintf('koko')
find(A==6)

%for i= (1: 3)'
  % if max < A(i , 2)
  %     max == A(i , 2)
     
      
 %  end
  
%end



