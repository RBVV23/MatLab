clc
clear all
close all

global E f Timp

E=218;
Niter=100;
q=2;
Timp=500E-6;
Tfront=20E-6
Evbr=72;
dt=Timp/Niter;
T=Timp*q;
Ngarm=70;
Wo=2*pi/T;
Int=0;
Tmax=6*T/2;
Tmin=0;%-3*T/2;
Ntime=(Tmax-Tmin)/dt;
summ=0;



T1=-Timp;
k1=0;
E1=E;

T2=0;
k2=0;
E2=E;



for i=1:Ntime
    t(i)=Tmin + dt*(i-1);
        for n=1:Ngarm
       W(n)=Wo*n;
       Sjw1=Universignal(W(n), T1, T2, k1, E1);
%        Sjw2=Universignal(W(n), T2, T3, k2, E2);
%        Sjw3=Universignal(W(n), T3, T4, k3, E3);
%        Sjw4=Universignal(W(n), T4, T5, k4, E4);
%        Sjw5=Universignal(W(n), T5, T6, k5, E5);
       Sjw=Sjw1;% + Sjw2;% + Sjw3 + Sjw4 + Sjw5;
            A(n)=(2/T)*Sjw;
            Ampl(n)=abs(A(n));
            Phase(n)=Angle(A(n));
            summ=summ+Ampl(n)*cos(W(n)*t(i)+Phase(n));
        end
    S(i)=summ+E/2;
    summ=0;
end

figure
plot(t*1E6, S, '-r', 'LineWidth', 3)
hold on
grid on
axis([Tmin*1000000 Tmax*1000000 -0.5*E 1.5*E])
min=Tmin*1000000;
max=Tmax*1000000;
h=Timp*1000000/2;
set(gca, 'XTick', min:h:max)
xlabel('t, мкс')
ylabel('u, мВ')
title('Прямоугольный сигнал')
% legend('Скважность q=2', 4)

Norm=138.783110376133;
figure
stem(W/Wo, Ampl/Norm, '*r', 'LineWidth', 3)
grid on
hold on
title('Идеальный спектр')
legend('Нормированный график')
xlabel('f/fo')
ylabel('S(w)/Sm(w)')
set(gca, 'XTick', 0:1:10)
set(gca, 'YTick', 0:0.25:2)
axis([0 10 0 1.25]) 


% figure
% plot(Phase/pi, '*r', 'LineWidth', 3)
% grid on
% hold on
% plot(Phase/pi, '--r', 'LineWidth', 1)
% title('Фазовый спектр сигнала s(t)')
% xlabel('n, номер гармоники')
% ylabel('\theta, \pi')

