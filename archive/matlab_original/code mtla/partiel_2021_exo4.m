clear all;close all;clc;

concentration= zeros(400,400);
concentration(200,200) = 100;
elements = 3*ones (400,400)
elements(200,200) = 1;
elements(100,100)=2;
elements(300,300)=2 ;
piece=[concentration , elements];
 
for i = 1
 if concentration(i)!= 0
     concentration(i)= concentration(find(concentration(i)=0));
 
 else 
     i=i+1;
 
end 