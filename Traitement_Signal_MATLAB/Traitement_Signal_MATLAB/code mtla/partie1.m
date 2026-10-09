function A = partie1(A,a,l1,l2,c)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if A(l,1)== 1
   A(l2,:)=A(l2,:)+a.*A(l1,:);
else
    A(l,:)=a.*A(l,:);
    A(l2,:)=A(l2,:)+a.*A(l1,:);
end

    

end

