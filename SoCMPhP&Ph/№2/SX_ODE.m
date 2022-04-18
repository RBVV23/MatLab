function dX = SystemX_ODE( t, x )
g=9.8;
Vpr=17;

dX=zeros(2,1);
dX(1)=x(2);        %Vx
dX(2)=(-g/Vpr)*x(2);     %X

% % x(1) - перемещение; x(2) - скорость

end