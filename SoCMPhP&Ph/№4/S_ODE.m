function dF = S_ODE( t, f )
global gamma;
global n;
k=1;
m=1;
wo=sqrt(k/m);
dF=zeros(2,1);
dF(1)=f(2);
dF(2)=(-k*wo*wo)*f(1) - gamma(n)*f(2);
end
% 
% function dy=S_ODE(t,y)
% f(1) - координата; 
% f(2) - скорость
% dy(1)=y(2);
% dy(2)=-g;