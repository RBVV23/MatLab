function dY = S_ODE( t, y )
g=10;
dY=zeros(2,1);
dY(1)=y(2);
dY(2)=-g;
end
% 
% function dy=S_ODE(t,y)
% % y(1) - перемещение; y(2) - скорость
% g=9.8;
% dy=zeros(2,1);
% dy(1)=y(2);
% dy(2)=-g;