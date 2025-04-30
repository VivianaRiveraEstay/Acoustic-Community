close all;
clear all;
clc;

%rango de horas desde la salida del sol
x= linspace(-5, 16, 1000);

% Distribución para especies crepusculares de día y noche (bimodal)
crep_dn = normpdf(x, 1, 0.8) + normpdf(x, 13, 0.8);

% Distribución para especies crepusculares de día (unimodal)
crep_d = normpdf(x, 2, 0.8);

% Distribución para especies crepusculares de noche (unimodal)
crep_n = normpdf(x, 12, 0.8);

%Distribución de especies que cantan todo el día (amodal)
fullday = normpdf(x, 8, 6);

% Distribución amodal
y_amodal = ones(1, 1000) / 6;

% Estandarizar las distribuciones dividiendo por el área bajo la curva
crep_dn = crep_dn / trapz(x, crep_dn);
crep_d = crep_d / trapz(x, crep_d);
crep_n = crep_n / trapz(x, crep_n);
fullday = fullday / trapz(x, fullday);

% Calcular el área entre las curvas
area1 = trapz(x, min(fullday,crep_dn));
area2 = trapz(x, min(fullday,crep_d));
area3 = trapz(x, min(fullday,crep_n));
area4 = trapz(x, min(crep_dn,crep_d));
area5 = trapz(x, min(crep_dn,crep_d));
area6 = trapz(x, min(crep_d,crep_n));


% Graficar las distribuciones
figure(1);

subplot(2, 2, 1);
plot(x, crep_dn, 'b', 'LineWidth', 2);
xlabel('Horas después del amanecer');
ylabel('Densidad de probabilidad');
xlim([0, 16]);
title('Crespusculares día y noche')

subplot(2, 2, 2);
plot(x,crep_d, 'b', 'LineWidth', 2);
xlabel('Horas después del amanecer');
ylabel('Densidad de probabilidad');
xlim([0, 16]);
title('Crespusculares día')

subplot(2, 2, 3);
plot(x, crep_n, 'b', 'LineWidth', 2);
xlabel('Horas después del amanecer');
ylabel('Densidad de probabilidad');
xlim([0, 16]);
title('Crespusculares noche')

subplot(2, 2, 4);
plot(x, fullday, 'b', 'LineWidth', 2);
xlabel('Horas después del amanecer');
ylabel('Densidad de probabilidad');
xlim([0, 16]);
ylim([0, 0.2]);
title('amodales')


% Graficar las distribuciones solapadas
figure(2);

subplot(2, 3, 1);
plot(x, crep_dn, 'b', 'LineWidth', 2);
hold on;
plot(x,fullday, 'r', 'LineWidth', 2);
fill(x, min(crep_dn,fullday), 'g', 'FaceAlpha', 0.3);
hold off;
% Etiquetas y leyenda
xlabel('Horas después del amanecer');
ylabel('Densidad de probabilidad');
legend('Distribución 1', 'Distribución 2', 'Solapamiento');
xlim([0, 16]);
% Mostrar el área calculada en el título del gráfico
title(['Área de solapamiento ', num2str(area1)])

subplot(2, 3, 2);
plot(x, crep_d, 'b', 'LineWidth', 2);
hold on;
plot(x,fullday, 'r', 'LineWidth', 2);
fill(x, min(crep_d,fullday), 'g', 'FaceAlpha', 0.3);
hold off;
% Etiquetas y leyenda
xlabel('Horas después del amanecer');
ylabel('Densidad de probabilidad');
legend('Distribución 1', 'Distribución 2', 'Solapamiento');
xlim([0, 16]);
% Mostrar el área calculada en el título del gráfico
title(['Área de solapamiento ', num2str(area2)])

subplot(2, 3, 3);
plot(x, crep_n, 'b', 'LineWidth', 2);
hold on;
plot(x,fullday, 'r', 'LineWidth', 2);
fill(x, min(crep_n,fullday), 'g', 'FaceAlpha', 0.3);
hold off;
% Etiquetas y leyenda
xlabel('Horas después del amanecer');
ylabel('Densidad de probabilidad');
legend('Distribución 1', 'Distribución 2', 'Solapamiento');
xlim([0, 16]);
% Mostrar el área calculada en el título del gráfico
title(['Área de solapamiento ', num2str(area3)])


subplot(2, 3, 4);
plot(x, crep_dn, 'b', 'LineWidth', 2);
hold on;
plot(x,crep_d, 'r', 'LineWidth', 2);
fill(x, min(crep_dn,crep_d), 'g', 'FaceAlpha', 0.3);
hold off;
% Etiquetas y leyenda
xlabel('Horas después del amanecer');
ylabel('Densidad de probabilidad');
legend('Distribución 1', 'Distribución 2', 'Solapamiento');
xlim([0, 16]);
% Mostrar el área calculada en el título del gráfico
title(['Área de solapamiento ', num2str(area4)])

subplot(2, 3, 5);
plot(x, crep_dn, 'b', 'LineWidth', 2);
hold on;
plot(x,crep_n, 'r', 'LineWidth', 2);
fill(x, min(crep_dn,crep_n), 'g', 'FaceAlpha', 0.3);
hold off;
% Etiquetas y leyenda
xlabel('Horas después del amanecer');
ylabel('Densidad de probabilidad');
legend('Distribución 1', 'Distribución 2', 'Solapamiento');
xlim([0, 16]);
% Mostrar el área calculada en el título del gráfico
title(['Área de solapamiento ', num2str(area5)])

subplot(2, 3, 6);
plot(x, crep_d, 'b', 'LineWidth', 2);
hold on;
plot(x,crep_n, 'r', 'LineWidth', 2);
fill(x, min(crep_d,crep_n), 'g', 'FaceAlpha', 0.3);
hold off;
% Etiquetas y leyenda
xlabel('Horas después del amanecer');
ylabel('Densidad de probabilidad');
legend('Distribución 1', 'Distribución 2', 'Solapamiento');
xlim([0, 16]);
% Mostrar el área calculada en el título del gráfico
title(['Área de solapamiento ', num2str(area6)])