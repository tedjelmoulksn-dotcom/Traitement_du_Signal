clear all;close all;clc;
v=1000
n=5
T=0.05
M=v*(1+T)^n;
M=v*((1-(1+T)^(n+1))/(1-(1+T)))