clear all;clc;
fp=1e4;
A=1;
t=0:1e-6:3e-3;
x=A*cos(2*pi*fp*t);
plot(t,x)
fb=1e3;
y=cos(2*pi*fb*t);
figure(2);
plot (t,y,'r')
m=1.5;
z=(1+m*y).*x;
figure(3);
plot(t,z);

