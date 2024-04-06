clc
close all;
global E R1 R2 Rm Rf Rl L T MedicionesIl MedicionesVl CHANGETIME

CHANGETIME = -0.006330000000000; % Tiempo donde se cambia la entrada

E = 9.5/2;    % Voltaje entrada
f = 158.3;    % Frecuencia de la fuente de voltaje
Rf = 50;      % Resistencia interna fuente
R1 = 505.5;   % Resistencia 1
R2 = 212.1;   % Resistencia 2
Rm = 105.3;   % Resistencia para medición de la corriente
Rl = 90.1;    % Resistencia interna del inductor
L = 141e-3;   % Inductancia
alpha = R1*R2+R1*Rl+R1*Rm+R2*Rf+R2*Rl+R2*Rm+Rf*Rl+Rf*Rm; % Calculo auxiliar

T = 1/f;      % Periodo
tt = 0;       % Tiempo de simulación
xx = [0 0];   % Salida solución numérica:
              %     - Corriente en el inductor
              %     - Voltaje en el inductor
ee = [0 0];   % Salida solución explícita:
              %     - Corriente en el inductor
              %     - Voltaje en el inductor

dataIl;     % Carga de los datos de corriente
dataVl;     % Carga de los datos de voltaje

tao = (L*R1+L*R2+L*Rf)/alpha
fiveTao = 5 * tao

h0 = [-E*R2/alpha (2*E*R2)/(Rf+R2+R1)]; % Condiciones iniciales simulación
V0 = (2*E*R2)/(Rf+R2+R1); % Voltaje incial función explícita
I0 = -E*R2/alpha; % Corriente incial función explícita

t0 = MedicionesIl(MedicionesIl(:,1) <= T/2); % Tiempos hasta la primera mitad del periodo
tf = MedicionesIl(MedicionesIl(:,1) > T/2); % Tiempos después de la primera mitad del periodo

tspan = [t0, tf];

for i=1:2
    % Solución numérica
    [t, x] = ode23('Inductor', tspan(:,i)', h0); 
    x(:,2) = x(:,2) + x(:,1)*Rl; % Sumando el voltaje en la resitencia interna del inductor
    tt = [tt; t];
    xx = [xx; x];
    
    % Solución explícita
    tspan(:,i) = tspan(:,i) - tspan(1,i);
    Ilt = (I0-(E*R2)/alpha)*exp(-(alpha)*tspan(:,i)/((R1+R2+Rf)*L))+(E*R2)/alpha;
    Vlt = exp(-(alpha)*tspan(:,i)/((R1+R2+Rf)*L))*V0;
    Vlt = Vlt + Ilt*Rl; % Sumando el voltaje en la resitencia interna del inductor
    ee = [ee; [Ilt Vlt]];
    % Nota: (tspan(:,i)-tspan(1,i)) es para hacerle creer a la función
    %       explícita que está en el origen y no en el estado estacionario
    
    E = -E;   % Invirtiendo la entrada
    h0 = [x(end,1) -alpha*x(end,1)/(R1+R2+Rf)+E*R2/(R1+R2+Rf)]; % Calculando condiciones inciales de la simulación
    I0 = Ilt(end); % Calculando corriente incial función explícita
    V0 = -alpha*I0/(R1+R2+Rf)+E*R2/(R1+R2+Rf); % Calculando voltaje incial función explícita
end

xx = xx(2:length(xx(:,1)) , :); % Eliminando primer punto en 0, 0
ee = ee(2:length(ee(:,1)) , :); % Eliminando primer punto en 0, 0
tt = tt(2:length(tt(:,1)) , :); % Eliminando primer punto en 0, 0

tao1 = fiveTao*ones(length(tt));
tao2 = (fiveTao+T/2)*ones(length(tt));

figure(1);
plot(MedicionesIl(:,1),MedicionesIl(:,2),tt,xx(:,1),tt,ee(:,1),tao1,ee(:,1),tao2,ee(:,1));
ylabel('$I_{l}(t)$','interpreter', 'latex','FontSize',13);
xlabel('t','interpreter', 'latex','FontSize',13);
title('Corriente en el Inductor')
legend({'Medición','Simulación','Explícita','T/2 + 5*Tao','5*Tao'},'FontSize',12);
grid minor;
figure(2);
plot(MedicionesVl(:,1),MedicionesVl(:,2),tt,xx(:,2),tt,ee(:,2),tao1,ee(:,2),tao2,ee(:,2));
ylabel('$V_{l}(t)$','interpreter', 'latex','FontSize',13);
xlabel('t','interpreter', 'latex','FontSize',13);
title('Voltaje en el Inductor');
legend({'Medición','Simulación','Explícita','T/2 + 5*Tao','5*Tao'},'FontSize',12);
grid minor;

% Errores para el periodo completo
maeDatosSimu = [...
    sum(abs(MedicionesIl(:,2) - xx(:,1))) / length(xx(:,1)), ...
    sum(abs(MedicionesVl(:,2) - xx(:,2))) / length(xx(:,2))...
    ];

maeDatosExpli = [...
    sum(abs(MedicionesIl(:,2) - ee(:,1))) / length(ee(:,1)), ...
    sum(abs(MedicionesVl(:,2) - ee(:,2))) / length(ee(:,2))...
    ];

mapeDatosSimu = [...
    sum(abs((MedicionesIl(:,2) - xx(:,1))./MedicionesIl(:,2))) / length(xx(:,1))*1e2 , ...
    sum(abs((MedicionesVl(:,2) - xx(:,2))./MedicionesVl(:,2))) / length(xx(:,2))*1e2  ...
    ];

mapeDatosExpli = [...
    sum(abs((MedicionesIl(:,2) - ee(:,1))./MedicionesIl(:,2)))  / length(ee(:,1))*1e2 , ...
    sum(abs((MedicionesVl(:,2) - ee(:,2))./MedicionesVl(:,2))) / length(ee(:,2))*1e2  ...
    ];

% Errores para medio periodo
mIl = MedicionesIl(1:length(t0),2);
mVl = MedicionesVl(1:length(t0),2);
odeIl = xx(1:length(t0),1);
odeVl = xx(1:length(t0),2);
eIl = ee(1:length(t0),1);
eVl = ee(1:length(t0),2);

maeDatosSimu2 = [...
    sum(abs(mIl - odeIl)) / length(mIl), ...
    sum(abs(mVl - odeVl)) / length(mVl)...
    ];

maeDatosExpli2 = [...
    sum(abs(mIl - eIl)) / length(mIl), ...
    sum(abs(mVl - eVl)) / length(mVl)...
    ];

mapeDatosExpli2 = [...
    sum(abs((mIl - eIl)./mIl)) / length(mIl)*1e2 , ...
    sum(abs((mVl - eVl)./mVl)) / length(mVl)*1e2  ...
    ];

mapeDatosSimu2 = [...
    sum(abs((mIl - odeIl)./mIl)) / length(mIl)*1e2 , ...
    sum(abs((mVl - odeVl)./mVl)) / length(mVl)*1e2  ...
    ];