clear all;close all;clc;
C=100e-9;
R=1000;
fe=1000;%frequence d'echantillonage
fc=1/(2*pi*R*C); %frequence de coupure
te=1/fe %periode d'echantillonage
t=(0:te:1);
freq=(0:length(t)-1)*(fe/length(t));
x=freq/fc;
y=1./sqrt(1+x.*x);
%semilogx(freq,y);
figure
semilogx(freq,y);
hold on
grid on