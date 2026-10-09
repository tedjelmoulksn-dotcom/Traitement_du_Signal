%%exo partiel 2020/2021
best_prsnt=10
best_n=N
for N = 1 : 40 
j1= randi(20,1000,5);
j2= randi(20,1000,5);
resultat = (j1+j2 > N | j1==j2);
parties_gagnees_j2 = sum(resultat, 2) >=3;

    sum(parties_gagnees_j2)
    prsnt = sum(parties_gagnees_j2)*100/1000
    if abs (prsnt - 50 )< abs(best_prsnt - 50)
        best_prsnt=50
        best_n=N
    end

end
best_n
    