clc
clear all
close all

global E f Timp
E=1;
Niter=100;


Timp=60E-6;
dt=Timp/Niter;
N=100;
Wmax=2*pi/Timp;
dw=Wmax/(Niter);
dx=dw;
Int=0;

T1=-Timp;
k1=0;
E1=0;

T2=-Timp/2;
k2=0;
E2=0;

T3=-Timp/4;
k3=0;
E3=E;

T4=Timp/4;
k4=0;
E4=0;

T5=Timp/2;
k5=0;
E5=0;

T6=Timp;

for i=1:2*Niter
   t(i)=-Timp + (i-1)*dt;
   for k=1:N*Wmax/dw
       W(k)=(k)*dw;
       Sjw1=Universignal(W(k), T1, T2, k1, E1);
       Sjw2=Universignal(W(k), T2, T3, k2, E2);
       Sjw3=Universignal(W(k), T3, T4, k3, E3);
       Sjw4=Universignal(W(k), T4, T5, k4, E4);
       Sjw5=Universignal(W(k), T5, T6, k5, E5);
       Sjw=Sjw1 + Sjw2 + Sjw3 + Sjw4 + Sjw5;
       Int=Int+Sjw*exp(j*W(k)*t(i))*dw;
       
      
   end
   S(i)=(1/(pi))*Int;
   Int=0;
end



figure
plot(t*1E6, S, '-r', 'LineWidth', 4)
grid on
hold on
title('Сигнал s(t)')
% axis([-(2/3)*Timp*1000000 (2/3)*Timp*1000000 -1.5*E E])
xlabel('t, мкс')
ylabel('u, В')


   for k=1:N*Wmax/dw
       W(k)=(k)*dw;
       Sjw1=Universignal(W(k), T1, T2, k1, E1);
       Sjw2=Universignal(W(k), T2, T3, k2, E2);
       Sjw3=Universignal(W(k), T3, T4, k3, E3);
       Sjw4=Universignal(W(k), T4, T5, k4, E4);
       Sjw5=Universignal(W(k), T5, T6, k5, E5);
       Sjw=Sjw1 + Sjw2 + Sjw3 + Sjw4 + Sjw5;
       Spectre(k)=Sjw;
       
      
   end

   
   
figure
plot(W/(2*pi), abs(Spectre), '-r', 'LineWidth', 1)
grid on
hold on
% plot(W/(2*pi), keff*sin(W/(2*pi))/(W/(2*pi)), '-r', 'LineWidth', 1)
title('Амплитудный пектр сигнала s(t)')
%axis([-(2/3)*Timp*1000000 (2/3)*Timp*1000000 -1.5*E E])
xlabel('f, Гц')
ylabel('u, В')


figure
plot(W/(2*pi), angle(Spectre), 'r', 'LineWidth', 1)
grid on
hold on
title('Фазовый спектр сигнала s(t)')
%axis([-(2/3)*Timp*1000000 (2/3)*Timp*1000000 -1.5*E E])
xlabel('f, Гц')
ylabel('u, В')
