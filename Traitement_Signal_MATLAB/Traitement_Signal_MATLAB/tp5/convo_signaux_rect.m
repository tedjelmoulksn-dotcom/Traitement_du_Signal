% Define parameters for rectangular signals
clear all;close all;clc;
A = 1/2;  % Height of signal A
B = 1/3;  % Height of signal B
a = 0;  % Width of signal A
b = 2.5;  % Width of signal B

% Function to compute the convolution product of two signals
function result = convolution_product(signal1, signal2, dt)
    result = conv(signal1, signal2) * dt;
    % Trim the convolution result to have the same length as the input signals
    result = result(1:length(signal1));
      end

% Function to generate a rectangular pulse signal
function signal = rectangular_pulse(t, width, height)
    signal = zeros(size(t));
    half_width = width / 2;
    signal(abs(t) <= half_width) = height;
end

% Define time vector
t = linspace(-10, 10, 1000);
dt = t(2) - t(1);

% Generate rectangular signals
rect_A = rectangular_pulse(t, a, A);
rect_B = rectangular_pulse(t, b, B);

% Compute convolution product
convolution_result = convolution_product(rect_A, rect_B, dt);

% Plot the signals and the convolution result
figure;
plot(t, rect_A, 'b', 'LineWidth', 2);
hold on;
plot(t, rect_B, 'r', 'LineWidth', 2);
plot(t, convolution_result, 'g', 'LineWidth', 2);
xlabel('Time');
ylabel('Amplitude');
title('Convolution Product of Rectangular Signals');
legend('Rectangular Signal A', 'Rectangular Signal B', 'Convolution Product');
grid on;
