% Données pour les types de mesure (par exemple, Or, Arg, Alum)
types_mesure = {'Or', 'Arg', 'Alum'};

% lambda en fonction des métaux pour chaque cas
lambda_eau = [313, 366, 391];
lambda_P1 = [304, 361, 385];
lambda_P1_P2 = [300, 357, 380];

% Tracé des graphes
figure;
hold on;

% Tracé pour lambda_eau en utilisant un style particulier
plot(1:3, lambda_eau, 'r--o', 'DisplayName', 'lambda eau');

% Tracé pour lambda_P1 en utilisant un style particulier
plot(1:3, lambda_P1, 'g-.s', 'DisplayName', 'lambda P1');

% Tracé pour lambda_P1_P2 en utilisant un style particulier
plot(1:3, lambda_P1_P2, 'b-^', 'DisplayName', 'lambda P1+P2');

% Ajouter des labels, une légende et personnaliser les axes
set(gca, 'XTick', 1:3, 'XTickLabel', types_mesure);
xlabel('Type de mesure');
ylabel('lambda (nm)');
title('lambda en fonction des types de mesure pour eau, P1, et P1+P2');
legend show;
grid on;
hold off;
