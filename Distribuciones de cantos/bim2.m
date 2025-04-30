clc;
clear all;
close all;

% Definir las distribuciones bimodales
x = linspace(-5, 5, 1000);
y1 = normpdf(x, -2, 1) + normpdf(x, 2, 1);
y2 = normpdf(x, -1, 0.5) + normpdf(x, 1, 0.5);

% Encontrar los puntos de intersección
intersection_points = fzero(@(x) interp1(x, y1, x, 'spline') - interp1(x, y2, x, 'spline'), [-5, 5]);

% Calcular el área entre las curvas considerando los puntos de intersección
x_area = linspace(min(x), max(x), 1000);
y1_area = interp1(x, y1, x_area, 'spline');
y2_area = interp1(x, y2, x_area, 'spline');
area = trapz(x_area, abs(y1_area - y2_area));

% Graficar las distribuciones y resaltar los puntos de intersección
figure;
plot(x, y1, 'b', 'LineWidth', 2);
hold on;
plot(x, y2, 'r', 'LineWidth', 2);
plot(intersection_points, interp1(x, y1, intersection_points, 'spline'), 'ko', 'MarkerSize', 10);
plot(intersection_points, interp1(x, y2, intersection_points, 'spline'), 'ko', 'MarkerSize', 10);
hold off;

% Etiquetas y leyenda
xlabel('x');
ylabel('Densidad de probabilidad');
legend('Distribución 1', 'Distribución 2', 'Puntos de intersección');

% Mostrar el área entre las curvas en el título del gráfico
title(['Área entre las curvas: ', num2str(area)]);
