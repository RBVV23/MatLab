function [ dF ] = Sys_ODE( t, f )
BETTA=100;
U=3e3;

dF=zeros(2,1);
dF(1)=-BETTA;
dF(2)=(-U/f(1))*dF(1);    

% f(1) - масса
% f(2) - скорость

end

