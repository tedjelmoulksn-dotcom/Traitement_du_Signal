clear all;close all;clc;
t=[0:2:10];
ta=5*(1-exp(-t));
plot( t, ta ,'-bs');
title('évolution de la tension RA4(t) l’instant d’Appui sur le PB','fontsize',25);
xlabel ('temps','fontsize',14);
ylabel('tA','fontsize',14);

