clc;
close all;
clear all;
% Parámetros del modelo
k = 10
r = rand(1,k); % Tasas de crecimiento intrínseco de cada especie
a = rand(k,k)   % Coeficientes de competencia entre especies
K = 300.*rand(1,k); % Capacidades de carga de cada especie

% Condiciones iniciales
N0 = rand(1,k); % Poblaciones iniciales de cada especie

% Tiempo
t_start = 0;
t_end = 100;

% Número de especies
n_species = numel(N0);


% Función del modelo
model = @(t, N) LotkaVolterraCompetition(t, N, r, a, K, k);

% Resolver el sistema de ecuaciones utilizando ode45
[t, N] = ode45(model, [t_start, t_end], N0);

% Gráfica de las poblaciones en función del tiempo
figure;
hold on;
for i = 1:n_species
    plot(t, N(:, i));
end
hold off;
xlabel('Time');
ylabel('Density');

    % Función del modelo de competencia de Lotka-Volterra
function dNdt = LotkaVolterraCompetition(t, N, r, a, K, k)
    dNdt = zeros(20, 1);
    
    for i = 1:20
        competition = 0;
        for j = 1:10
            competition = competition + a(i, j) * N(j);
        end
        if i <= 10
        dNdt(i) = r(i) * N(i) * (1 - competition / K(i));
        else
            dNdt(i) = N(i);
        end
    end
end

   