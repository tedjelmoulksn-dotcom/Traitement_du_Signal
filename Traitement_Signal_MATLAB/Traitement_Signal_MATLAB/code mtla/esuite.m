function u = esuite(N,t0,tN,y0)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%t=0 
%f=cos(2*y)

h = (tN-t0)/N
y=y0;
for t=t0:h:tN
    y=y+h*dabord(t,y)
end
u = y;
end

