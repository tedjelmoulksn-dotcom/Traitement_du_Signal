clear all;clc;
%la matrice augmete est M=[1 1 1;2 1 3;1 -1 2] elle admet 3 equations et 3
%inconnues
A=[1 1 1;2 1 3;1 -1 2]
[n,m]=size(A)


function A=ajoute(A,a,l1,l2)
A(l2,:)=A(l2,:)+a.*A(l1,:);
end
