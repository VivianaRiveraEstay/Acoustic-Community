% Definir las curvas
x = linspace(0, 10, 100);
y1 = sin(x);
y2 = cos(x);

% Calcular el área entre las curvas
area = trapz(x, abs(y1 - y2));

% Graficar las curvas
plot(x, y1, 'b', 'LineWidth', 2)
hold on
plot(x, y2, 'r', 'LineWidth', 2)
fill([x, fliplr(x)], [y1, fliplr(y2)], 'g', 'FaceAlpha', 0.3)
hold off

% Etiquetas y leyenda
xlabel('x')
ylabel('y')
legend('y1 = sin(x)', 'y2 = cos(x)', 'Area entre las curvas')

% Mostrar el área calculada en el título del gráfico
title(['Área entre las curvas: ', num2str(area)])