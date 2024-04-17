function ts = TS(p, w)
    Sub = [4/(p(1)*w(1)); 3/(p(1)*w(1))];
    Cri = [4/(p(2)*w(2)); 3/(p(2)*w(2))];
    Sob = [4/(p(3)*w(3)); 3/(p(3)*w(3))];
    
    ts = table(Sub,Cri,Sob,'RowNames',{'2%'; '5%'});
end