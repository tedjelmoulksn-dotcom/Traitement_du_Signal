% Données pour les types de mesure (par exemple, Or, Arg, Alum)
types_mesure = {'Or', 'Arg', 'Alum'};

% Cas avec une seule couche de protéine (P1), en pointillé
delta_theta_or_P1 = 5.65;
delta_theta_arg_P1 = 1.08;
delta_theta_alum_P1 = 0.98;
theta_P1 = [delta_theta_or_P1, delta_theta_arg_P1, delta_theta_alum_P1];

% Cas avec deux couches de protéine (P1+P2), en ligne continue
delta_theta_or_P1_P2 = 8.71;
delta_theta_arg_P1_P2 = 2.15;
delta_theta_alum_P1_P2 = 1.98;
theta_P1_P2 = [delta_theta_or_P1_P2, delta_theta_arg_P1_P2, delta_theta_alum_P1_P2];

% Tracé des graphes
figure;
hold on;

% Tracé pour une couche de protéine (P1) en pointillé
plot(1:3, theta_P1, 'r--o', 'DisplayName', 'P1');

% Tracé pour deux couches de protéines (P1+P2) en ligne continue
plot(1:3, theta_P1_P2, 'b-o', 'DisplayName', 'P1+P2');

% Ajouter des labels, une légende et personnaliser les axes
set(gca, 'XTick', 1:3, 'XTickLabel', types_mesure);
xlabel('Type de mesure');
ylabel('\Delta \theta');
title('\Delta \theta pour P1 et P1+P2');
legend show;
grid on;
hold off;
