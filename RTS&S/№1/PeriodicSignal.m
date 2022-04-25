clc
clear all
close all

global E f Timp

E=1;
Epost=-0.1;
Niter=100;
q=2;
Timp=60E-6;
dt=Timp/Niter;
T=Timp*q;
Ngarm=30;
Fo=1/T;
Wo=2*pi/T;
Int=0;
Tmax=2*T/2;
Tmin=-2*T/2;
Ntime=(Tmax-Tmin)/dt;
summ=0;

R=80;
C=20E-9;
T=R*C;



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
       W(n)=Wo*n;
       Sjw1=Universignal(W(n), T1, T2, k1, E1);
       Sjw2=Universignal(W(n), T2, T3, k2, E2);
       Sjw3=Universignal(W(n), T3, T4, k3, E3);
       Sjw4=Universignal(W(n), T4, T5, k4, E4);
       Sjw5=Universignal(W(n), T5, T6, k5, E5);
       Sjw=Sjw1 + Sjw2 + Sjw3 + Sjw4 + Sjw5;
            A(n)=(2/T)*Sjw;
            Ampl(n)=abs(A(n));
           Phase(n)=angle(A(n));
            summ=summ+Ampl(n)*cos(W(n)*t(i)+Phase(n));
        end
    S(i)=summ+Epost;
    summ=0;
end

dw=Wo/100;
Kmax=Ngarm*Wo/dw +1;


for k=1:Kmax
    w(k)=(k-1)*dw;
    K(k)=1/(sqrt((w(k)*T)^2 + 1));
end


% figure
% plot(t*1E6, S, '-r', 'LineWidth', 3)
% hold on
% grid on
% axis([Tmin*1000000 Tmax*1000000 -1.5*E E])
% minT=Tmin*1000000;
% maxT=Tmax*1000000;
% h=Timp*1000000/2;
% set(gca, 'XTick', minT:h:maxT)
% xlabel('t, мкс')
% ylabel('u, В')
% title('Периодический сигнал s(t)')
% legend('Скважность q=2')

Amplo=max(Ampl);
figure
plot(Ampl/Amplo, '--r', 'LineWidth', 1)
grid on
hold on
stem(Ampl/Amplo, '*r', 'LineWidth', 3)
title('Нормированный мплитудный спектр сигнала s(t)')
xlabel('n, номер гармоники')
ylabel('|A|, В')
legend('Огибающая')


for n=1:Ngarm
   F(n)=n*Wo/(2*pi); 
   Filtr(n)=Ampl(n)*[1/(sqrt((2*pi*F(n)*T)^2 + 1))];
end

figure
plot(F, Ampl, '--r', 'LineWidth', 1)
grid on
hold on
stem(F, Ampl, '*r', 'LineWidth', 3)
title('Амплитудный спектр сигнала s(t)')
xlabel('f, Гц')
ylabel('|A|, В')
legend('Огибающая')


% figure
% plot(Phase/pi, '*r', 'LineWidth', 3)
% grid on
% hold on
% plot(Phase/pi, '--r', 'LineWidth', 1)
% title('Фазовый спектр сигнала s(t)')
% xlabel('n, номер гармоники')
% ylabel('\theta, \pi')

figure
plot(w/(2*pi), K, '-r', 'LineWidth', 3)
grid on
hold on
title('АЧХ ограничивающего фильтра')
xlabel('f, Гц')
ylabel('|K|')

figure
stem(F, Ampl, '--b', 'LineWidth', 1)
grid on
hold on
stem(F, Filtr, '*r', 'LineWidth', 3)
title('Амплитудный спектр s(t)')
xlabel('f, Гц')
ylabel('|A|, В')
legend('До фильтра','После фильтра')

figure
stem(F, Ampl, '--b', 'LineWidth', 1)
grid on
hold on
stem(F, Filtr, '*r', 'LineWidth', 3)
title('Амплитудный спектр s(t) в ОВЧ')
xlabel('f, Гц')
ylabel('|A|, В')
axis([100000-2*Fo Ngarm*Fo 0 1.5]);
legend('До фильтра','После фильтра')

figure
stem(F, Ampl, '--b', 'LineWidth', 1)
grid on
hold on
stem(F, Filtr, '*r', 'LineWidth', 3)
title('Амплитудный спектр s(t) в ОНЧ')
xlabel('f, Гц')
ylabel('|A|, В')
axis([0 100000-2*Fo 0 30]);
legend('До фильтра','После фильтра')
