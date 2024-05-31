clc
close all;

global a11 a12 a21 a22 b1 b2 E;

a11 = -1;
a12 = 1;
a21 = -1;
a22 = -1;
b1 = 1;
b2 = 1;

E = 4.4/2;    % Voltaje entrada

LoadX1;
LoadX2;

f = 0.083;
T = 1/f;      % Periodo
tt = 0;       % Tiempo de simulación
xx = [0 0];   % Salida solución numérica:
              %     - Corriente en el inductor
              %     - Voltaje en el inductor

%dataIl;     % Carga de los datos de corriente
%dataVl;     % Carga de los datos de voltaje

h0 = [0 0]; % Condiciones iniciales simulación
tspan = [0 T/2];

for i=1:4
    % Solución numérica
    [t, x] = ode23('EDOs', tspan, h0); 
    tt = [tt; t - 1.4];
    xx = [xx; x];
    
    
    E = -E;   % Invirtiendo la entrada
    h0 = [x(end,1) x(end,2)]; % Calculando condiciones inciales de la simulación
    tspan = [tspan(end) T/2 + tspan(end)];
end

xx = xx(2:length(xx(:,1)) , :); % Eliminando primer punto en 0, 0
tt = tt(2:length(tt(:,1)) , :); % Eliminando primer punto en 0, 0

figure(1);
subplot(2,1,1);
plot(X1Simu(:,1),X1Simu(:,2),X1Simu(:,1),X1Simu(:,2), X1.t, X1.X1);
ylabel('$X_{1}(t)$','interpreter', 'latex','FontSize',13);
xlabel('t','interpreter', 'latex','FontSize',13);
title('Estado X1')
grid minor;
subplot(2,1,2);
plot(tt, xx(:,2), X2.t, X2.X2);
ylabel('$X_{2}(t)$','interpreter', 'latex','FontSize',13);
xlabel('t','interpreter', 'latex','FontSize',13);
title('Estado X2')
grid minor;

figure(2);
plot(xx(:,1),xx(:,2),'*');
grid minor;

% % Errores para el periodo completo
% maeDatosSimu = [...
%     sum(abs(MedicionesIl(:,2) - xx(:,1))) / length(xx(:,1)), ...
%     sum(abs(MedicionesVl(:,2) - xx(:,2))) / length(xx(:,2))...
%     ];
% 
% maeDatosExpli = [...
%     sum(abs(MedicionesIl(:,2) - ee(:,1))) / length(ee(:,1)), ...
%     sum(abs(MedicionesVl(:,2) - ee(:,2))) / length(ee(:,2))...
%     ];
% 
% mapeDatosSimu = [...
%     sum(abs((MedicionesIl(:,2) - xx(:,1))./MedicionesIl(:,2))) / length(xx(:,1))*1e2 , ...
%     sum(abs((MedicionesVl(:,2) - xx(:,2))./MedicionesVl(:,2))) / length(xx(:,2))*1e2  ...
%     ];
% 
% mapeDatosExpli = [...
%     sum(abs((MedicionesIl(:,2) - ee(:,1))./MedicionesIl(:,2)))  / length(ee(:,1))*1e2 , ...
%     sum(abs((MedicionesVl(:,2) - ee(:,2))./MedicionesVl(:,2))) / length(ee(:,2))*1e2  ...
%     ];
% 
% % Errores para medio periodo
% mIl = MedicionesIl(1:length(t0),2);
% mVl = MedicionesVl(1:length(t0),2);
% odeIl = xx(1:length(t0),1);
% odeVl = xx(1:length(t0),2);
% eIl = ee(1:length(t0),1);
% eVl = ee(1:length(t0),2);
% 
% maeDatosSimu2 = [...
%     sum(abs(mIl - odeIl)) / length(mIl), ...
%     sum(abs(mVl - odeVl)) / length(mVl)...
%     ];
% 
% maeDatosExpli2 = [...
%     sum(abs(mIl - eIl)) / length(mIl), ...
%     sum(abs(mVl - eVl)) / length(mVl)...
%     ];
% 
% mapeDatosExpli2 = [...
%     sum(abs((mIl - eIl)./mIl)) / length(mIl)*1e2 , ...
%     sum(abs((mVl - eVl)./mVl)) / length(mVl)*1e2  ...
%     ];
% 
% mapeDatosSimu2 = [...
%     sum(abs((mIl - odeIl)./mIl)) / length(mIl)*1e2 , ...
%     sum(abs((mVl - odeVl)./mVl)) / length(mVl)*1e2  ...
%     ];