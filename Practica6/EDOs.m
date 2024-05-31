function dx = EDOs(~, x) 
 
global a11 a12 a21 a22 b1 b2 E;
 
    dx(1) = a11*x(1) + a12*x(2) + b1*E;
    dx(2) = a21*x(1) + a22*x(2) + b2*E;
    dx = dx';
end