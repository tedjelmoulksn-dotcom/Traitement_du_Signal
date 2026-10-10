clear all;close all;clc;
x1=[ 0.1:0.1:4];
y1= 30*log(x1);
y2=exp(x1);

plot (x1,y1);
figure;
plot(x1 , y2);
