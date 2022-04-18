clc
clear all
close all

fprintf('Начальные условия')

global gamma;
global wo;
global k;
global n

k=1
m=1
Xo=0
Vo=0.1
To=0

Ax=sqrt( (m*Vo*Vo + k*Xo*Xo)/k )
Av=sqrt( (m*Vo*Vo + k*Xo*Xo)/m )
wo=sqrt(k/m)
fi=-acos(Xo/Ax)
T=(2*pi)/wo
Tmax=20*T;
Tmin=To;
dt=T/100;
N=(Tmax-Tmin)/dt;

gamma= [0.1 0.5 1 2 4 8]
t=linspace(Tmin, Tmax, N+1);

for n=1 : 1
[t Fode]=ode45('S_ODE', t, [Xo Vo]);
figure
plot(Fode(:,1), Fode(:,2), '-r', 'Linewidth', 2)
Ao(1)=Av;
eps=0.001;

i=1;

for j= 1 : N
    
    if ( abs( abs(Fode(j,2)) - Ao(i) ) <eps  )
        tau(i)=t(j);
        i=i+1;
        Ao(i)=Fode(j,2)*exp(-1);
        fprintf('!');
    end
    
end









end


figure
plot(t, Fode(:,1), '-k', 'LineWidth', 3)
grid on
hold on
title('Координата X от времени t')
% 
% 
% figure
% plot(t, Fode(:,2), '-k', 'LineWidth', 3)
% grid on
% hold on
% title('Скорость Vx от времени t')

% plot(At, '-g', 'LineWidth', 3)
% hold on
% grid on
% title('Время релаксации')



