clc
clear all
close all


xmin=0;
xmax=10*pi;

%Наперед заданная точность
eps=1E-6

%Определение оптимального размера шага h
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
emax=10;
h=1;

while emax>eps
    
N=(xmax-xmin)/h;
    for i=1:N
        x(i)=xmin+(i-1)*h;
        F(i)=abs(VTPR(x(i)));
    end
   emax=max(F)*(h^3)/12;
   h=h/2;
end

h=h
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Определение верхнего предела интегрирования T
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T=4*pi;
dS=10;
j=0;

while dS>eps
   T=T+100*pi;
   dS=TRAP(T,T+pi,h)- TRAP(T-pi,T,h);
   dS=abs(dS);
   j=j+1;
end

xmax=T

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

I=TRAP(xmin, xmax, h)
otkl=pi/2 - I




