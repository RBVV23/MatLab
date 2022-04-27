clc

clear all
close all



%Количество гармоник
fprintf('Количество гармоник: ')
N=150

%Количество разбиений на один период
fprintf('Количество разбиений на один период: ')
Niter=100

%Количество просчитываемых периодов
fprintf('Количество просчитываемых периодов: ')
Nperiod=3

%Скважность сигнала
fprintf('Скважность сигнала: ')
tau=2

%Частота сигнала
fprintf('Частота сигнала (Гц): ')
f=2E3


E=
w=2*pi*f;
T=1/f;
dt=T/Niter;

s(1)=0;



for i=1:(Niter*Nperiod)
t(i)=(i-1)*dt;     

   for n=1:N
      A(n)=E*SINC(n*pi/tau);%*exp(-j*w*T/2);
      a(n)=abs(A(n));
      O(n)=angle(A(n));
      s(n+1)=s(n)+a(n)*cos( n*w*t(i) + O(n) );
      ans=s(n+1);
   end
   Ao=SINC((0)*pi/tau);
   s0=abs(Ao)*cos(0*w*t(i) + angle(Ao));
   S(i)=ans+s0/2;
   s(1)=0;
end

%Emax=E*SINC(1*pi/4);

figure
plot(t, S, '-r', 'LineWidth', 2)
grid on
hold on
title('Прямоугольный сигнал')

xlabel('t, мкс')
ylabel('u, мВ')
%axis([0 Nperiod*T -0.125*Emax 1.125*Emax])




figure
stem(a, '*r', 'LineWidth', 2)
grid on
hold on
title('Амплитудный спектр')
xlabel('Номер гармоники, n')
ylabel('Амплитуда, ')
%axis([0 N -0.125 2])

% 
% figure
% plot(O/pi, '*r', 'LineWidth', 2)
% grid on
% hold on
% title('Фазовый спектр')
% xlabel('Номер гармоники, n')
% ylabel('Начальная фаза, \pi')
% %axis([0 N -0.125 2])

