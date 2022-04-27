clc
clear all
close all

global E f Timp

Timp=500E-6;
Tfront=20E-6
Evbr=72;

Niter=100;
q=1

dt=Timp/Niter;
T=Timp*q;
Ngarm=30;
Wo=2*pi/T;
Int=0;
Tmax=10*T/2;
Tmin=0;
Ntime=(Tmax-Tmin)/dt;
summ=0;
% 
% 
% 
% T1=-Timp;
% k1=(E+Evbr)/(Timp);
% E1=E-Evbr;
% 
% T2=0;
% k2=-(E+Evbr)/(Tfront);
% E2=E+Evbr;
% 
% T3=Tfront;
% 
% 
% for i=1:Ntime
%     t(i)=Tmin + dt*(i-1);
%         for n=1:Ngarm
%        W(n)=Wo*n;
%        Sjw1=Universignal(W(n), T1, T2, k1, E1);
%        Sjw2=Universignal(W(n), T2, T3, k2, E2);
%        Sjw=Sjw1 + Sjw2;
%             A(n)=(2/T)*Sjw;
%             Ampl(n)=abs(A(n));
%             Phase(n)=Angle(A(n));
%             summ=summ+Ampl(n)*cos(W(n)*t(i)+Phase(n));
%         end
%     S(i)=summ;
%     summ=0;
% end
% 
% figure
% plot(t*1E6, E*1E3, '--r', 'LineWidth', 1)
% hold on
% grid on
% plot(t*1E6, -25, '--r', 'LineWidth', 1)
% plot(t*1E6, (S+Evbr+0.075)*1E3, '-r', 'LineWidth', 3)
% xlabel('t, мкс')
% ylabel('U, мВ')
% title('Треугольный сигнал')
% legend('Амплитуда - 508 мВ', 'Выброс 68 мВ')
% 
% Anorm=max(Ampl);
% 
% figure
% stem(Ampl/Anorm, 'ro', 'LineWidth', 3)
% grid on
% title('Идеальный спектр')
% hold on
% legend('Нормированный график')
% xlabel('f/fo')
% ylabel('S(w)/Sm(w)')
% set(gca, 'XTick', 0:1:10)
% set(gca, 'YTick', 0:0.25:2)
% axis([0 10 0 1.25]) 

Y=[-6.3 -50 -7.9 -50 -8.9 -50 -18.6 -50 -20.8 -50 -23 ];
Norm=max(Y)
Y=Y-Norm;
Y=exp(Y)


figure
stem( Y, 'ro', 'LineWidth', 3)
grid on
title('Реальный спектр')
hold on
legend('Нормированный график')
xlabel('f/fo')
ylabel('S(w)/Sm(w)')
set(gca, 'XTick', 0:1:10)
set(gca, 'YTick', 0:0.25:2)
axis([0 10 0 1.25]) 

% % 
% % 
% % figure
% % plot(Phase/pi, '*r', 'LineWidth', 3)
% % grid on
% % hold on
% % plot(Phase/pi, '--r', 'LineWidth', 1)
% % title('Фазовый спектр сигнала s(t)')
% % xlabel('n, номер гармоники')
% % ylabel('\theta, \pi')
% % 
