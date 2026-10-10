% Données pour les types de mesure (par exemple, Or, Arg, Alum)
types_mesure = {'Or', 'Arg', 'Alum'};

% neff en fonction des métaux pour chaque cas
neff_eau = [1.70, 1.45, 1.36];
neff_P1 = [1.73, 1.47, 1.38];
neff_P1_P2 = [1.77, 1.49, 1.40];

% Tracé des graphes
figure;
hold on;

% Tracé pour neff_eau en utilisant un style particulier
plot(1:3, neff_eau, 'r--o', 'DisplayName', 'neff eau');

% Tracé pour neff_P1 en utilisant un style particulier
plot(1:3, neff_P1, 'g-.s', 'DisplayName', 'neff P1');

% Tracé pour neff_P1+P2 en utilisant un style particulier
plot(1:3, neff_P1_P2, 'b-^', 'DisplayName', 'neff P1+P2');

% Ajouter des labels, une légende et personnaliser les axes
set(gca, 'XTick', 1:3, 'XTickLabel', types_mesure);
xlabel('Type de mesure');
ylabel('neff');
title('neff en fonction des types de mesure pour eau, P1, et P1+P2');
legend show;
grid on;
hold off;
