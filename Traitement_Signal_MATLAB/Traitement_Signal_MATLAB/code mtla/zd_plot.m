% Données pour les types de métaux
types_mesure = {'Or', 'Argent', 'Aluminium'};

% Profondeur de pénétration (Zd) en fonction des métaux
Zd = [121.5, 176, 310.38];

% Tracé du graphe
figure;
hold on;

% Tracé de Zd en utilisant un style particulier
plot(1:3, Zd, 'm-d', 'DisplayName', 'Zd');

% Ajouter des labels, une légende et personnaliser les axes
set(gca, 'XTick', 1:3, 'XTickLabel', types_mesure);
xlabel('Type de métal');
ylabel('Profondeur de pénétration Zd (nm)');
title('Profondeur de pénétration Zd en fonction des types de métaux');
legend show;
grid on;
hold off;
