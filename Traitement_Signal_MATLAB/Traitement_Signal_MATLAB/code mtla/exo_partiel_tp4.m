clear all;close all;clc;
structure = zeros(50,50);%cest une matric 50*50 qcontenat des zeros partt sauf ...
temperature= ones(50,50)*10;
structure(25,25)= 2 ; %cets un radiateur
temperature(25,25)=30;
structure(25,25)=2;%cets un radiateur
temperature(10,10)=30;

%caes avec les murs int
structure(17,17)=1
structure(32,32)=1
%ceses asur les bords
temperature( : , 1 )=15;
temperature(: ,end)=15;
temperature( 1 , : )=15;
temperature(end, :)=15;

structure(: ,1 )=2;
structure(: ,end )=2;
structure(1 ,: )=2;
structure(end , : )=2;
for i= 0: 200

%chercer le max dans les 8 t
T1=temperature(16:18 ,16:18);
t_maximale_1=sum(max(T1))/3; %pour avoir le max
 
T2=temperature(31:33 ,31:33);
t_maximale_2=sum(max(T2))/3; %pour avoir le max

%donc onn met a jour les temperature 
temperature(17 ,17)=t_maximale_1
temperature(32 ,32)=t_maximale_2
%indice_mur=find(structure==1)
%for i = indice_mur'
 %   [r,c]=ind2sub( size(temperature),i);
  %  temperature(r,c) = max(temperature(r-1:r+1 , c-1:c+1)( : ));
%end
%pour les cases vide
U=ones(3,3)/9
%s1=structure(16:18 ,16:18)
%for i=1:50
moy=conv2(temperature ,U)
%end
temperature(structure==0)= moy(structure==0);
end
imagesc( temperature , climits = [10 30] );
colorbar;
pause(0.05);