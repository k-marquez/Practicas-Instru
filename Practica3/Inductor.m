function dx = Inductor(~, x) 
 
global E R1 R2 Rm Rf Rl L;
 
    dx(1) = (-(R1*R2+R1*Rl+R1*Rm+R2*Rf+R2*Rl+R2*Rm+Rf*Rl+Rf*Rm)*x(1)+E*R2)/(L*(R1+R2+Rf));
    dx(2) = -(R1*R2+R1*Rl+R1*Rm+R2*Rf+R2*Rl+R2*Rm+Rf*Rl+Rf*Rm)*x(2)/(L*(R1+R2+Rf));
  
    dx = dx';
end