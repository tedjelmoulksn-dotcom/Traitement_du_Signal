
%convolution
k= ones(1 , 13 )/ 7 %jai 13 valeurs je moyenne sur 7
k(1:6)=0 %comme ca jairai les 0 sur les 6 premiere valmeur 
new_cases_avg=conv (new_cases , k, 'same');





