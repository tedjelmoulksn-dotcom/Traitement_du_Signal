function A =essai( A,l1,l2 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if A(1,:) 
A(l2,:)=A(l2,:)+A(l2*-1,:).*A(l1,:)
 
A(l1,:)=1./A(l1,:)
fin si




end

