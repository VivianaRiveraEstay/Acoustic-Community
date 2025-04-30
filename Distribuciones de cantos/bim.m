clc;
clear all;
close all;
% Parámetros de la distribución bimodal aproximada
w1 = 0.5;
mu1 = 9;
sigma1 = 0.5;
w2 = 0.5;
mu2 = 4;
sigma2 = 0.5;

w3 = 0.4;
mu3 = 1;
sigma3 = 0.5;
w4 = 0.6;
mu4 = 6;
sigma4 = 1;


% Rango de valores para x
x1 = linspace(0, 12, 1000);
x2 = linspace(0, 12, 1000);

% Calcular los valores de la función aproximada
y1 =bimodal1_aprox(x1, w1, mu1, sigma1, w2, mu2, sigma2);
y2 =bimodal2_aprox(x2, w1, mu3, sigma3, w2, mu4, sigma4);


figure(1)
% Graficar la función aproximada
plot(x1, y1)
xlabel('x')
ylabel('f(x)')
title('Aproximación de una distribución bimodal')
grid on
hold on 
plot(x2, y2)
grid on

% Calcular el área entre las curvas
overlap_area = trapz(x1, min(y1,y2));


% Graficar las distribuciones
figure(2);
plot(x1, y1, 'b', 'LineWidth', 2);
hold on;
plot(x1, y2, 'r', 'LineWidth', 2);
fill(x1, min(y1, y2), 'g', 'FaceAlpha', 0.3);
hold off;

% Etiquetas y leyenda
xlabel('x');
ylabel('Densidad de probabilidad');
legend('Distribución 1', 'Distribución 2', 'Solapamiento');

% Mostrar el área de solapamiento en el título del gráfico
title(['Área de solapamiento: ', num2str(overlap_area)]);


function fa = bimodal1_aprox(x1, w1, mu1, sigma1, w2, mu2, sigma2)
    f1 = w1 * (1 / (sigma1 * sqrt(2 * pi))) * exp(-(x1 - mu1).^2 / (2 * sigma1^2));
    f2 = w2 * (1 / (sigma2 * sqrt(2 * pi))) * exp(-(x1 - mu2).^2 / (2 * sigma2^2));
    fa = f1 + f2;
end

function fb = bimodal2_aprox(x2, w1, mu3, sigma3, w2, mu4, sigma4)
    f1 = w1 * (1 / (sigma3 * sqrt(2 * pi))) * exp(-(x2 - mu3).^2 / (2 * sigma3^2));
    f2 = w2 * (1 / (sigma4 * sqrt(2 * pi))) * exp(-(x2 - mu4).^2 / (2 * sigma4^2));
    fb = f1 + f2;
end