function S=Newton(v,n,M)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%v=1000;
%n=5;
%M=6000;
syms x
y=v*((1-(1+x).^(n+1))./(1-(1+x))-1")-M;
z=diff(y,1,x);
j(1)=0.05;
k=2;
i=1;
while i<k
    j(i+1)=j(i)-(vpa(subs(y,x,j(i)))/vpa(subs(z,x,j(i))));
    i=i+1;
end
S=j(i);

end


