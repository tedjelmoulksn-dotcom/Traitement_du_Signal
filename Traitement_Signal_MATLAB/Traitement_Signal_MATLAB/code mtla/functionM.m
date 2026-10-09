function M=calcM(v,T,n)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
v=1000;
n=5;
T=0.05
M=v*((1-(1+T)^(n+1))/(1-(1+T)));

end

