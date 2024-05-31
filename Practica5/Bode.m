clc
clear all;
close all;

global P CERO K;

% Ganancia de FT de Vc
K = 4.436965116e8;
% Raices del polinomio característico
P = [12002.07437 91540.59893];
% TI + a*s
CERO = [5.710379814e5 6.21118012];

% Carga de datos
CargarDatosIl;
CargarDatosVc;

% Vc
% Matlab bode Vc
tf_Vc = tf(K,[1 1.035426734e5 1.098677076e9]);
[tf_magnitud_vc, tf_fase_vc, tf_frecuencia_rds_vc] = bode(tf_Vc);

tf_magnitud_vc = squeeze(tf_magnitud_vc);
tf_fase_vc = squeeze(tf_fase_vc);

tf_frecuencia_hrz_vc = tf_frecuencia_rds_vc/(2*pi);
tf_magnitud_vc_db_vc = 20*log10(tf_magnitud_vc);

% Modelo bode Vc
[te_frecuencia_rds_vc, te_magnitud_db_vc, te_fase_vc] = BodeTeorico(tf_frecuencia_rds_vc, true, 1);

f1 = figure('NumberTitle', 'off', 'Name', 'Bode VC');

subplot(2,1,1);
semilogx(tf_frecuencia_hrz_vc, tf_magnitud_vc_db_vc); hold on;
semilogx(ValoresVc.FrecuenciaHz, ValoresVc.M, '--m');
semilogx(tf_frecuencia_hrz_vc, te_magnitud_db_vc, '--'); hold off;

grid minor;

ylabel('Magnitud (dB)')
legend({'Simulación', 'Medición', 'Teórico'})

subplot(2,1,2);
semilogx(tf_frecuencia_hrz_vc, tf_fase_vc); hold on;
semilogx(ValoresVc.FrecuenciaHz, ValoresVc.A, '--m');
semilogx(tf_frecuencia_hrz_vc, te_fase_vc, '--'); hold off;
grid minor;

ylabel('Fase (deg)')
legend({'Simulación', 'Medición', 'Teórico'})

han=axes(f1,'visible','off'); 
han.Title.Visible='on';
han.XLabel.Visible='on';
xlabel(han,'Frecuencia (Hz)');
title(han, 'Diagrama de Bode (Vc)')

% Il
% Matlab bode Il
tf_Il = tf([6.211180124 5.710379814e5],[1 1.035426734e5 1.098677076e9]);
[tf_magnitud_il, tf_fase_il, tf_frecuencia_rds_il] = bode(tf_Il);

tf_magnitud_il = squeeze(tf_magnitud_il);
tf_fase_il = squeeze(tf_fase_il);

tf_frecuencia_hrz_il = tf_frecuencia_rds_il/(2*pi);
tf_magnitud_il_db_il = 20*log10(tf_magnitud_il);

% Modelo bode Vc
[te_frecuencia_rds_il, te_magnitud_db_il, te_fase_il] = BodeTeorico(tf_frecuencia_rds_il, false, 1);

f2 = figure('NumberTitle', 'off', 'Name', 'Bode IL');

subplot(2,1,1);
semilogx(tf_frecuencia_hrz_il, tf_magnitud_il_db_il); hold on;
semilogx(ValoresIl.FrecuenciaHz, ValoresIl.M, '--m');
semilogx(tf_frecuencia_hrz_il, te_magnitud_db_il, '--'); hold off;

grid minor;

ylabel('Magnitud (dB)')
legend({'Simulación', 'Medición', 'Teórico'})

subplot(2,1,2);
semilogx(tf_frecuencia_hrz_il, tf_fase_il); hold on;
semilogx(ValoresIl.FrecuenciaHz, ValoresIl.A, '--m');
semilogx(tf_frecuencia_hrz_il, te_fase_il, '--'); hold off;
grid minor;

ylabel('Fase (deg)')
legend({'Simulación', 'Medición', 'Teórico'})

han=axes(f2,'visible','off'); 
han.Title.Visible='on';
han.XLabel.Visible='on';
xlabel(han,'Frecuencia (Hz)');
title(han, 'Diagrama de Bode (Il)')