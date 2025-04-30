% En este codigo graficamos la solucion numerica de una ecuacion
% diferencial, utilizado la funcion ODE45, con distintas condiciones iniciales.
%Solucion vivi
%Fijacion de Parametros:
clc 
close all
clear all
%% Parametros
format long
r = 3*rand(1,4); 
K = 300*rand(1,4);
% Generar una matriz aleatoria
a = rand(4);
% Hacer la matriz simétrica
a = (a + a')/2;
b12= 1;
b13= 1;
b14= 1;
b21= 1;
b23= 1;
b24= 1;
b31= 1;
b32= 1;
b34= 1;
b41= 1;
b42= 1;
b43= 1;
G1= 0.01; 
G2= 0.01;
G3= 0.01;
G4= 0.01;

P=[r K a(1,:) a(2,:) a(3,:) a(4,:) b12 b13 b14 b21 b23 b24 b31 b32 b34 b41 b42 b43 G1 G2 G3 G4];
%% Condiciones iniciales:
x0=rand(1,8)

x0=[x0];
%% Simulacion del Modelo
[tv,Yv]=ode45(@(t,Y) vivi(t,Y,P),[0 100],x0);%

figure
subplot(1,2,1),plot(tv,Yv(:,1),'LineWidth',2),xlabel('Tiempo'),ylabel('Densidad');
hold on
plot(tv,Yv(:,2),'LineWidth',2),xlabel('Tiempo'),ylabel('Densidad');
plot(tv,Yv(:,3),'LineWidth',2),xlabel('Tiempo'),ylabel('Densidad');
plot(tv,Yv(:,4),'LineWidth',2),xlabel('Tiempo'),ylabel('Densidad');
legend('Especie 1','Especie 2', 'Especie 3','Especie 4')
subplot(1,2,2),plot(tv,Yv(:,5),'LineWidth',2),xlabel('Tiempo'),ylabel('Valor rasgo');
hold on
plot(tv,Yv(:,6),'LineWidth',2),xlabel('Tiempo'),ylabel('Valor rasgo');
plot(tv,Yv(:,7),'LineWidth',2),xlabel('Tiempo'),ylabel('Valor rasgo');
plot(tv,Yv(:,8),'LineWidth',2),xlabel('Tiempo'),ylabel('Valor rasgo');
legend('Rasgo 1','Rasgo 2', 'Rasgo 3', 'Rasgos 4')
saveas(gcf,'competencia-rasgo','jpg')

