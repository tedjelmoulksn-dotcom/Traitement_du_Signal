function A =ajoute( A,a,l1,l2)
%cette foction ajoute a la lige 2 de la matrice A la lige 1 mulitiplie par u
%coefficiront a
%   Detailed explanation goes here
A(l2,:)=A(l2,:)+a.*A(l1,:);
end

