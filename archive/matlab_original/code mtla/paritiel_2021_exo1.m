%%jeu
%i est un vecteur les lignes representes un nv et les colonnes sont les
%diff vecteur 
%p represente le nombre des pieces ramasse COLO 1
%v nombre de vie gagane ouperdues COLO 2
%s est le score COLO 3
%t represente le temps COLO 4 
%b est un vecteur de booleen si =1 alors yavais un boss COLO 5
% afficher le nombre de niveau du jeu 
disp(size(i,1));
pieces_totale= sum(i(:,1) ,1) ; %somme de tt les elements de la premeir colonnne
temps_de_chauqe_nv=  i(: , 4) % disp le temps pr chaque nv 
fprintf(' le temps passe est %f s \n' ,temps_de_chauqe_nv )%f secode" , temps_de_chauqe_nv)

bossy= i( : , size(i,2));%je prend la colonne des boss
numel(find(bossy==1));% combient de fois ya le bosse
vies_finale= 3+ sum(i(:,2),1) %3 est les vies au debit et a cjaque fois on regardes combien de vies a perdu ou gagn
nv_plus_rapide= max(i(: , 4))