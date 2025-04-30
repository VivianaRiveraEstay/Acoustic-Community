close all;
clear all;
clc;

n_crepusculares = 2; % número de especies que cantan de día y noche
n_dia = 3+n_crepusculares;  % número de especies que cantan de día
n_noche = 2+n_crepusculares; % número de especies que cantan de noche
n_tarde = 1; % número de especies que cantan de tarde
S=n_dia+n_noche-n_crepusculares+n_tarde; %número total de especies 

min_valor_dia = 1;  % Valor mínimo del rango día
max_valor_dia = 8;  % Valor máximo del rango día

min_valor_tarde = 9;  % Valor mínimo del rango tarde
max_valor_tarde = 16;  % Valor máximo del rango tarde

min_valor_noche = 10;  % Valor mínimo del rango noche
max_valor_noche = 24;  % Valor máximo del rango noche

medias_dia= randi([min_valor_dia, max_valor_dia], 1, n_dia);
medias_tarde= randi([min_valor_tarde, max_valor_tarde], 1, n_tarde);
medias_noche= randi([min_valor_noche, max_valor_noche], 1, n_noche);

%rango de horas desde la salida del sol
x= linspace(-5, 25, 1000);

indiceDivision = n_crepusculares;  % Índice de división
medias_crepusculares_dia = medias_dia(1:indiceDivision);  % valor medias de día para aves que cantan de día y noche
medias_diaa = medias_dia(indiceDivision+1:end);  % valor de medias para aves que cantan sólo de día 

medias_crepusculares_noche = medias_noche(1:indiceDivision);  % valor medias de noche para aves que cantan de día y noche
medias_nochee = medias_noche(indiceDivision+1:end);  % valor de medias para aves que cantan sólo de noche 

for i=1:n_crepusculares
crep_dn(i,:)= normpdf(x,medias_crepusculares_dia(i), 0.8) + normpdf(x,medias_crepusculares_noche(i), 0.8);
trap_dn(i,:)=trapz(x, crep_dn(i,:));
crep_dn_estand(i,:)=crep_dn(i,:)/trap_dn(i,:);
end


for j=1:length(medias_diaa)
crep_d(j,:)= normpdf(x,medias_diaa(j) , 0.8);
trap_d(j,:) =trapz(x, crep_d(j,:));
crep_d_estand(j,:)=crep_d(j,:)/trap_d(j,:);
end

for k=1:length(medias_nochee)
crep_n(k,:)= normpdf(x,medias_nochee(k) , 0.8);
trap_n(k,:) =trapz(x, crep_n(k,:));
crep_n_estand(k,:)=crep_n(k,:)/trap_n(k,:);
end


for l=1:n_tarde
crep_t(l,:)= normpdf(x,medias_tarde(l) , 0.8);
trap_t(l,:) =trapz(x, crep_t(l,:));
crep_t_estand(l,:)=crep_t(l,:)/trap_t(l,:);
end

%CALCULO DE SOLAPAMIENTO ENTRE ESPECIES (estos podrían ser los coeficientes de competencia)

D=[crep_dn_estand ;crep_d_estand ; crep_n_estand ; crep_t_estand]; %todas las distribuciones

for n=1:S;
    for m=1:S;
if n==m
    a(n,m)= 0;
else
    a(n,m)= trapz(x,min(D(n,:),D(m,:)));
end
    end
end




figure %grafica de distribuciones de día
subplot(2, 2, 1);
for g1=1:length(medias_diaa)
hold on 
plot(x, crep_d_estand(g1,:), 'LineWidth', 2);
xlabel('Horas después del amanecer');
ylabel('Densidad de probabilidad');
xlim([0, 24]);
title('Día')
end

subplot(2, 2, 2) %gráfica distribuciones de tarde
for g4=1:n_tarde
hold on 
plot(x, crep_t_estand(g4,:), 'LineWidth', 2);
xlabel('Horas después del amanecer');
ylabel('Densidad de probabilidad');
xlim([0, 24]);
title('Tarde')
end


subplot(2, 2, 3)%gráfica distribuciones de noche 
for g3=1:length(medias_nochee)
hold on 
plot(x, crep_n_estand(g3,:), 'LineWidth', 2);
xlabel('Horas después del amanecer');
ylabel('Densidad de probabilidad');
xlim([0, 24]);
title('Noche')
end

subplot(2, 2, 4) %gráfica distribuciones de día y noche
for g2=1:n_crepusculares
hold on 
plot(x, crep_dn_estand(g2,:),'LineWidth', 2);
xlabel('Horas después del amanecer');
ylabel('Densidad de probabilidad');
xlim([0, 24]);
title('Crespusculares día y noche')
end

figure
plot(x, crep_dn(1,:), 'b', 'LineWidth', 2);
hold on;
plot(x,crep_dn(2,:), 'r', 'LineWidth', 2);
fill(x, min(crep_dn(1,:),crep_dn(2,:)), 'g', 'FaceAlpha', 0.3);
hold off;
% Etiquetas y leyenda
xlabel('Horas después del amanecer');
ylabel('Densidad de probabilidad');
legend('Distribución 1', 'Distribución 2', 'Solapamiento');
xlim([0, 24]);
% Mostrar el área calculada en el título del gráfico
title(['Área de solapamiento ', num2str(trapz(x, min(crep_dn(1,:),crep_d(1,:))))])


figure
plot(x, crep_dn(1,:), 'b', 'LineWidth', 2);
hold on;
plot(x,crep_d(1,:), 'r', 'LineWidth', 2);
fill(x, min(crep_dn(1,:),crep_d(1,:)), 'g', 'FaceAlpha', 0.3);
hold off;
% Etiquetas y leyenda
xlabel('Horas después del amanecer');
ylabel('Densidad de probabilidad');
legend('Distribución 1', 'Distribución 2', 'Solapamiento');
xlim([0, 24]);
% Mostrar el área calculada en el título del gráfico
title(['Área de solapamiento ', num2str(trapz(x, min(crep_dn(1,:),crep_d(1,:))))])





%Ecuaciones

% Parámetros del modelo
r = rand(1,S); % Tasas de crecimiento intrínseco de cada especie
K = 300.*rand(1,S); % Capacidades de carga de cada especie
NF = zeros(1,S);

