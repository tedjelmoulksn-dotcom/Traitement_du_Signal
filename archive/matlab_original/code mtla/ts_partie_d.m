%t=TP1_2(0.57,2,200,0.5);
T0=20e-3; %pour travailler en secde
fe=500;
Te=1/fe;
t_echan=40e-3;
N=t_echan * fe; %represente le nb d'echantillons
t=(0:N-1)*Te;% vect temps pour echantillonnage 
%% en utilise la fct square pour construrie un signal carre
x = square(2*pi*(1/T0)*t);
Xf=fft(x);
X_shifted=fftshift(Xf);
f=(-N/2 : N/2-1)*(fe/N) ; %%vecteur de freq centree 
figure(1);
plot(f,X_shifted)
%hold;
%Sx= (abs(X_shifted).^2)/N;
%figure(1);
%plot(f,Sx)
%xlabel('frequence');
%ylabel('DSP');
%%tracee
%figure(1);
%plot(t,x) ;
%xlabel('temps en s');
%ylabel('amplitude de x');

