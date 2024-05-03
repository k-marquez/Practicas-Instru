function [w, m, f] = BodeTeorico(w, vc, deg)
    if vc
        [w, m, f] = BodeVc(w, deg);
    else
        [w, m, f] = BodeIl(w, deg);
    end
end

function [w, mag, fase] = BodeIl(w, deg)
    global P CERO;
    
    real = (CERO(1)*(-w.^2+P(1)*P(2))+CERO(2)*w.^2*(P(1)+P(2)))./((-w.^2+P(1)*P(2)).^2+(w*(P(1)+P(2))).^2);
    img = (CERO(2)*w.*(-w.^2+P(1)*P(2))-CERO(1)*(P(1)+P(2))*w)./((-w.^2+P(1)*P(2)).^2+(w*(P(1)+P(2))).^2);
    mag = 20*log10(sqrt(real.^2 + img.^2));
    fase = (180 * deg/pi)*atan2(img, real);
end

function [w, mag, fase] = BodeVc(w, deg)
    global P K;
    
    real = K*(-w.^2+P(1)*P(2))./((-w.^2+P(1)*P(2)).^2+w.^2*(P(1)+P(2))^2);
    img = -K*w*(P(1)+P(2))./((-w.^2+P(1)*P(2)).^2+w.^2*(P(1)+P(2))^2);
    mag = 20*log10(sqrt(real.^2 + img.^2));
    fase = (180 * deg/pi)*atan2(img, real);           
end