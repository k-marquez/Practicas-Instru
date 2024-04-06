function dx = EDOs(~, x, C)
 
global E R1 Rf Rl L Ric Ril;
    % Il(t)
    dx(1) = ((-1+Ric/(R1+Ric))*x(2)+(-Rf-Rl-Ril-Ric*R1/(R1+Ric))*x(1)+E)/L;
    % Vc(t)
    dx(2) = (x(1)*R1-x(2))/((R1+Ric)*C);
    % Vl(t)
    dx(3) = (-1+Ric/(R1+Ric))*x(4)/C+(-Rf-Rl-Ril-Ric*R1/(R1+Ric))*x(3)/L;
    % Ic(t)
    dx(4) = (x(3)*R1/L-x(4)/C)/(R1+Ric);
  
    dx = dx';
end