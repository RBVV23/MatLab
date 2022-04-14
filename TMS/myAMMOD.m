function [ out ] = myAMMOD( T, s_MOD, Fc, M, ini_phase )

U=(1+M*s_MOD);
out=U.*cos(2*pi*Fc*T + ini_phase);

end

