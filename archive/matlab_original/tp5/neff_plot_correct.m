% Données pour les cas (par exemple, eau, P1, P1+P2)
cas = {'eau', 'P1', 'P1+P2'};

% lambda pour chaque métal en fonction des cas
lambda_or = [313, 304, 300];
lambda_arg = [366, 361, 357];
lambda_alum = [391, 385, 380];

% Tracé des graphes
figure;
hold on;

% Tracé pour lambda_or en utilisant un style particulier
plot(1:3, lambda_or, 'r--o', 'DisplayName', 'lambda Or');

% Tracé pour lambda_arg en utilisant un style particulier
plot(1:3, lambda_arg, 'g-.s', 'DisplayName', 'lambda Arg');

% Tracé pour lambda_alum en utilisant un style particulier
plot(1:3, lambda_alum, 'b-^', 'DisplayName', 'lambda Alum');

% Ajouter des labels, une légende et personnaliser les axes
set(gca, 'XTick', 1:3, 'XTickLabel', cas);
xlabel('Cas');
ylabel('lambda (nm)');
title('lambda en fonction des cas pour Or, Arg, et Alum');
legend show;
grid on;
hold off;
