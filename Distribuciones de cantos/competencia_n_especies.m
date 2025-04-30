clc;
close all;
clear all;

k = 6; %numero de especies
T = 1; %numero de comunidades

%generar T matrices de tamaño k 

matrices = cell(T, 1);  % Celda para almacenar las matrices generadas

for i = 1:T
    matriz = rand(k);  % Genera una matriz aleatoria de tamaño k x k
    matrices{i} = matriz;  % Almacena la matriz en la celda
end


% Parámetros del modelo
r = rand(1,k); % Tasas de crecimiento intrínseco de cada especie
K = 300.*rand(1,k); % Capacidades de carga de cada especie
NF = zeros(T,k);

for h=1:T

a=matrices{h};

% Condiciones iniciales
N0 = rand(1,k); % Poblaciones iniciales de cada especie

% Tiempo
t_start = 0;
t_end = 100;

% Número de especies
n_species = numel(N0);

% Función del modelo
model = @(t, N) LotkaVolterraCompetition(t, N, r, a, K, n_species);

% Resolver el sistema de ecuaciones utilizando ode45
[t, N] = ode45(model, [t_start, t_end], N0);

NF(h,:)=N(end,:);

%Gráfica de las poblaciones en función del tiempo

figure;
hold on;
for i = 1:n_species
    plot(t, N(:, i));
end
hold off;
xlabel('Time');
ylabel('Density');
end 



% Función del modelo de competencia de Lotka-Volterra
function dNdt = LotkaVolterraCompetition(t, N, r, a, K, n_species)
    dNdt = zeros(n_species, 1);
    
    for i = 1:n_species
        competition = 0;
        for j = 1:n_species
            competition = competition + a(i, j) * N(j);
        end
        dNdt(i) = r(i) * N(i) * (1 - competition / K(i));
    end
end




