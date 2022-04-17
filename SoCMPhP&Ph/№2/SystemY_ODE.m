function dY = SystemX_ODE( t, y )
g=10;


dY=zeros(2,1);
dY(1)=y(2);        %Vx
dY(2)=(-g);     %X

% % y(1) - перемещение; y(2) - скорость

end