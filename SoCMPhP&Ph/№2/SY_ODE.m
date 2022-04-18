function dY = SystemX_ODE( t, y )
g=9.8;
Vpr=17;

dY=zeros(2,1);
dY(1)=y(2);        %Vx
dY(2)=(-g) + (-g/Vpr)*sign(y(2))*y(2);     %X

% % y(1) - перемещение; y(2) - скорость

end