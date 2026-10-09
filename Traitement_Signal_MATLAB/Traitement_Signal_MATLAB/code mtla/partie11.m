function A = partie1(A,a,l1,l2,c)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
for i==1:n-1
    if i~=1
       A(l,:)=a.*A(l,:);
    end
    if i==1
        A(l2,:)=A(l2,:)+a.*A(l1,:);

end

