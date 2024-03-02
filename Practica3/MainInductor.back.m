clc
close all;
global E R1 R2 Rm Rf Rl L MedicionesIl MedicionesVl

% ______ Parámetros ______
E=9.5/2;
Rf=50;
R1=505.5;
R2=212.1;
Rm=105.3;
Rl=90.1;
L=141e-3;
% Entradas del algoritmo
f=158.3;
T=1/f;
tt=0;
xx=[0 0];
options = odeset('RelTol',1e-8,'AbsTol',1e-7);
% Tiempo de simulación
t0=0;
tf=T/2;
tspan=[t0 tf];
% ______ Condiciones iniciales ______
alpha=R1*R2+R1*Rl+R1*Rm+R2*Rf+R2*Rl+R2*Rm+Rf*Rl+Rf*Rm;
h0=[-E*R2/alpha (2*E*R2)/(Rf+R2+R1)];

for i=1:2

[t,x]=ode23('Inductor',tspan,h0,options);
tt=[tt;t];
xx=[xx;x];

E=-E;
t0=tf;
tf=tf+T/2;
tspan=[t0 tf];
h0=[x(length(x),1) (2*E*R2)/(Rf+R2+R1)];
 
[t,x]=ode23('Inductor',tspan,h0,options);
tt=[tt;t];
xx=[xx;x];

E=-E;
t0=tf;
tf=tf+T/2;
tspan=[t0 tf];
h0=[x(length(x),1) (2*E*R2)/(Rf+R2+R1)];
end

% Sumando el voltaje de la resistencia interna del inductor a
% los resultados de la simulación
xx(:,2)=xx(:,2)+xx(:,1)*Rl;

% ______ Cargando datos ______
dataIl=importdata('F0000CH1.CSV',',',18);
dataIl=dataIl.data(:, 4:5);
dataVl=importdata('F0000CH2.CSV',',',18);
dataVl=dataVl.data(:, 4:5);

% Extrayendo índices de los elementos del primer periodo.
i=dataIl(:,1)>0 & dataIl(:,1)<T;

% Extrayendo datos del primer periodo
timeDataIl=dataIl(i,1);
dataIl=dataIl(i,2)/Rm+.4e-3;
timeDataVl=dataVl(i,1);
dataVl=dataVl(i,2);

% ______ Soluciones análiticas ______
E=abs(E);
% t0=0;
% tf=T/2;
% t=t0:0.00001:tf;
It0=-E*R2/alpha;
Vl0=2*E*R2/(R1+R2+Rf);
Ilt=[];
Vlt=[];
timeAnalitic=[];

for i=1:1
timeAnalitic=[timeAnalitic t];
% (t-t0): Es para hacerle creer a la función explícita que está en el
% origen y no en el estado estacionario
Ilt=[Ilt (It0-(E*R2)/alpha)*exp(-(alpha)*(t-t0)/((R1+R2+Rf)*L))+(E*R2)/alpha];
Vlt=[Vlt exp(-(alpha)*(t-t0)/((R1+R2+Rf)*L))*Vl0];

E=-E;
t0=tf;
tf=T/2+tf;
t=t0:0.00001:tf;
It0=Ilt(length(Ilt));
Vl0=-Vl0;
timeAnalitic=[timeAnalitic t];
Ilt=[Ilt (It0-(E*R2)/alpha)*exp(-(alpha)*(t-t0)/((R1+R2+Rf)*L))+(E*R2)/alpha];
Vlt=[Vlt exp(-(alpha)*(t-t0)/((R1+R2+Rf)*L))*Vl0];

E=-E;
t0=tf;
tf=T/2+tf;
t=t0:0.00001:tf;
It0=Ilt(length(Ilt));
Vl0=-Vl0;
end

% Sumando el voltaje de la resistencia interna del inductor a
% los resultados de la solución analítica
Vlt=Vlt+Ilt*Rl;

% Eliminando el último valor para tener el mismo número de mediciones
Ilt=Ilt(1:length(Ilt)-1);
Vlt=Vlt(1:length(Vlt)-1);
timeAnalitic=timeAnalitic(1:length(timeAnalitic)-1);

% Errores
% ______ Simulación - Datos ______

% ______ Solución G. - Datos ______
maeSimuDatos = sum(abs(dataIl - Ilt.'))/length(Ilt);

% Gráficas
% ____________ Il(t) _____________
figure(1)
% __________ Simulación __________
plot(tt,xx(:,1))
hold;
% ___________ Medición ___________
plot(timeDataIl,dataIl);
% ________________________________
% ___________ Analitica __________
plot(timeAnalitic,Ilt);
ylabel('$I_{l}(t)$','interpreter', 'latex','FontSize',13);
xlabel('t','interpreter', 'latex','FontSize',13);
title('Corriente en el Inductor')
legend({'Simulación','Medición','Analitica'},'FontSize',12);
grid;
% ________________________________
% ____________ Vl(t) _____________
figure(2)
% __________ Simulación __________
plot(tt,xx(:,2));
hold;
% ___________ Medición ___________
plot(timeDataVl,dataVl);
% ________________________________
% ___________ Analitica __________
plot(timeAnalitic,Vlt);
ylabel('$V_{l}(t)$','interpreter', 'latex','FontSize',13);
xlabel('t','interpreter', 'latex','FontSize',13);
title('Voltaje en el Inductor');
legend({'Simulación','Medición','Analítica'},'FontSize',12);
grid;
% ________________________________