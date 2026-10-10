% Constants
mu0 = 4 * pi * 10^-7; % Permeability of free space (H/m)
f = 1 * 10^9; % Frequency (Hz)

% Conductivities (S/m)
sigma_Au = 4.1 * 10^7;
sigma_Ag = 6.3 * 10^7;
sigma_Al = 3.5 * 10^7;

% Calculate skin depths (m)
delta_Au = 1 ./ sqrt(pi * f * mu0 * sigma_Au);
delta_Ag = 1 ./ sqrt(pi * f * mu0 * sigma_Ag);
delta_Al = 1 ./ sqrt(pi * f * mu0 * sigma_Al);

% Metals
metals = {'Gold', 'Silver', 'Aluminum'};
skin_depths = [delta_Au, delta_Ag, delta_Al];

% Plotting
figure;
bar(categorical(metals), skin_depths);
xlabel('Metal');
ylabel('Skin Depth (m)');
title('Skin Depth (z_d) as a function of Metal');
grid on;
