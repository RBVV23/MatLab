clc
clear all
close all

global E f Timp

E=1;
Niter=50;
q=2;
Timp=60E-6;
dt=Timp/Niter;
T=Timp*q;
Ngarm=30;
Wo=2*pi/T;
Int=0;
Tmax=T/2;
Tmin=-T/2;
Ntime=(Tmax-Tmin)/dt;
summ=0;



T1=-Timp/2;
k1=-E/(Timp/6);
E1=-3*E;

T2=-Timp/3;
k2=0;
E2=-E;

T3=-Timp/6;
k3=(3/2)*E/(Timp/3);
E3=-E/4;

T4=Timp/6;
k4=0;
E4=E/2;

T5=Timp/3;
k5=-(E/2)/(Timp/6);
E5=3*E/2;

T6=Timp/2;

for i=1:Ntime
    t(i)=Tmin + dt*(i-1);
        for n=1:Ngarm
       Sjw1=Universignal(n*Wo, T1, T2, k1, E1);
       Sjw2=Universignal(n*Wo, T2, T3, k2, E2);
       Sjw3=Universignal(n*Wo, T3, T4, k3, E3);
       Sjw4=Universignal(n*Wo, T4, T5, k4, E4);
       Sjw5=Universignal(n*Wo, T5, T6, k5, E5);
       Sjw=Sjw1 + Sjw2 + Sjw3 + Sjw4 + Sjw5;
            A(n)=Sjw;
            Ampl(n)=abs(A(n));
            Phase(n)=Angle(A(n));
            summ=summ+Ampl(n)*cos(n*Wo*t(i)+Phase(n));
        end
    S(i)=summ-0.25*E;
    summ=0;
end

figure
plot(t*1E6, S, '-r', 'LineWidth', 3)
hold on
grid on
%axis([Tmin*1000000 Tmax*1000000 -1.5*E E])
xlabel('t, мкс')
ylabel('u, В')

figure
plot(Ampl, '*r', 'LineWidth', 3)
grid on
hold on
title('Амплитудный спектр сигнала s(t)')
xlabel('f, Гц')
ylabel('|A|, В')


figure
plot(Phase/pi, '*r', 'LineWidth', 3)
grid on
hold on
title('Фазовый спектр сигнала s(t)')
xlabel('n, номер гармоники')
ylabel('\theta, \pi')

