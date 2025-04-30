clc;
close all;
clear all;
% Parámetros del modelo
k = 5
r = rand(1,k); % Tasas de crecimiento intrínseco de cada especie
K = 300.*rand(1,k); % Capacidades de carga de cada especie
a = rand(k,k)   % Coeficientes de competencia entre especies
b = rand(k,k)   % Coeficientes de competencia entre especies
G = rand(1,k)

% Condiciones iniciales
N0 = rand(1,10); % Poblaciones iniciales de cada especie

% Tiempo
t_start = 0;
t_end = 100;

% Número de especies
n_species = numel(r);
m_species=2*n_species;

% Función del modelo
model = @(t, N) LotkaVolterraCompetition(t, N, r, a, K, b, G, m_species);

% Resolver el sistema de ecuaciones utilizando ode45
[t, N] = ode45(model, [t_start, t_end], N0);


% Gráfica de las poblaciones en función del tiempo
figure;
hold on;
for i = 1:m_species
    plot(t, N(:, i));
end
hold off;
xlabel('Time');
ylabel('Density');


% Función del modelo de competencia de Lotka-Volterra
function dNdt = LotkaVolterraCompetition(t, N, r, a, K, b, G, m_species)
    dNdt = zeros(m_species, 1);
    
    for i = 1:n_species
        competition = 0;
        trait = 0;
        for j = 1:n_species
            competition = competition + a(i, j) * exp(-(N(n_species+i)-N(n_species+j))/(2*b(i, j))) * N(j);
            trait = trait + N(i+1) * a(i, j) * exp(-(N(n_species+i)-N(n_species+j))/(2*b(i, j))) * (N(n_species+i)-N(n_species+j))
        end
        dNdt(i) = r(i) * N(i) * (1 - competition / K(i));
        dNdt(n_species+i) = G(i) * trait;

    end
end

%(Y(5)-2)*(0-Y(5))*G1*(Y(2)*a12*exp(-((Y(5)-Y(6))^(2))/2*b12^2)*((Y(5)-Y(6))/b12^2)+Y(3)*a13*exp(-((Y(5)-Y(7))^(2))/2*b13^2)*((Y(5)-Y(7))/b13^2)+Y(4)*a14*exp(-((Y(5)-Y(8))^(2))/2*b14^2)*((Y(5)-Y(8))/b14^2));

%r1*(1-(Y(1)/K1))*Y(1)-a12*exp(-((Y(5)-Y(6))^(2))/2*b12^2)*Y(1)*Y(2)-a13*exp(-((Y(5)-Y(7))^(2))/2*b13^2)*Y(1)*Y(3)-a14*exp(-((Y(5)-Y(8))^(2))/2*b14^2)*Y(1)*Y(4);