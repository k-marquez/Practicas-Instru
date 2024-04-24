clear all;
clc;

VC = tf([4.442267087*10^8],[1 1.657010674*10^5 6.813569813*10^9]);
% [mag, phase, wout] = bode(VC);
bode(VC);
% mag = squeeze(mag);
% phase = squeeze(phase);
% 
% fout = wout/(2*pi);
% dbout = 20*log10(mag);
% 
% f = figure(1);
% 
% subplot(2,1,1);
% semilogx(fout, dbout); hold on

grid minor;