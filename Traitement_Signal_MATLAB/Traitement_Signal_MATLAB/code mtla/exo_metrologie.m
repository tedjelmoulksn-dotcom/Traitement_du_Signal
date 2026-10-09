clear all;close all;clc;
t=[0 1 2 4 5 6 8 9 10]
T=[18 16 14  12 11 10 9 9 8]
figure(1);
plot(t,T,'-bs');
tau =(-t/(log((T-6)/12)))
figure(2);
%la solution
Ts=6+12*exp(-t/tau);
plot(t,Ts,'-rs');